import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:snitch/snitch.dart';

/// Основной API сервера
abstract final class SnitchServe {
  factory SnitchServe({
    required Snitch snitch,
    InternetAddress? address,
    int? port,
  }) => _SnitchServe(
    snitch: snitch,
    address: address,
    port: port,
  );

  Future<void> start();

  Future<void> close();

  Future<void> printAddresses();
}

base class _SnitchServe implements SnitchServe {
  _SnitchServe({
    required this.snitch,
    InternetAddress? address,
    int? port,
  }) : port = port ?? 4040,
       address = address ?? InternetAddress.anyIPv6;

  final Snitch snitch;
  final InternetAddress address;
  final int port;

  HttpServer? _server;
  SecurityContext? _context;
  final _clients = <WebSocket>{};

  @override
  Future<void> start() async {
    _log('Starting server on $address:$port...');

    try {
      _context ??= await _loadSecurityContext();
      _server = await HttpServer.bindSecure(address, port, _context!);

      await for (final request in _server!) {
        _handleRequest(request);
      }
    } catch (e, s) {
      _log('Server error: $e\n$s');
    }
  }

  @override
  Future<void> close() async {
    if (_server == null) {
      _log('Server is not running');
      return;
    }
    await _server?.close();
    _log('Server stopped');
  }

  Future<SecurityContext> _loadSecurityContext() async {
    final (certificateKeyBytes, privateKeyBytes) = await (
      rootBundle.load('packages/snitch_serve/certs/localhost+2.pem'),
      rootBundle.load('packages/snitch_serve/certs/localhost+2-key.pem'),
    ).wait;

    return SecurityContext()
      ..useCertificateChainBytes(certificateKeyBytes.asListUint8())
      ..usePrivateKeyBytes(privateKeyBytes.asListUint8());
  }

  Future<void> _handleRequest(HttpRequest request) async {
    _log('Request [${request.method}] ${request.uri}');

    _addCorsHeaders(request.response);

    switch (request.uri.path) {
      case '/ws':
        unawaited(_handleWebSocket(request));
        break;

      case '/logs':
        final logsJson = jsonEncode(snitch.logs.map((e) => e.toJson()).toList());
        request.response
          ..statusCode = HttpStatus.ok
          ..write(logsJson)
          ..close();
        break;

      default:
        request.response
          ..statusCode = HttpStatus.notFound
          ..write(jsonEncode({'message': 'Page not found', 'status': 404}))
          ..close();
    }
  }

  Future<void> _handleWebSocket(HttpRequest request) async {
    if (!WebSocketTransformer.isUpgradeRequest(request)) return;

    final socket = await WebSocketTransformer.upgrade(request);
    _clients.add(socket);

    final subscription = snitch.stream.listen((log) {
      final data = jsonEncode(log.toJson());
      for (final client in _clients) {
        client.add(data);
      }
    });

    socket.listen(
      (message) => _log('WS[$socket]: $message'),
      onDone: () {
        _clients.remove(socket);
        subscription.cancel();
      },
      onError: (e) {
        _log('WebSocket error: $e');
        _clients.remove(socket);
        subscription.cancel();
      },
    );
  }

  void _addCorsHeaders(HttpResponse response) => {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers': '*',
  }.forEach(response.headers.add);

  @override
  Future<void> printAddresses() async {
    for (final interface in await NetworkInterface.list()) {
      for (final address in interface.addresses) {
        Zone.root.print('https://${address.address}:$port');
      }
    }
  }

  void _log(String message) => Zone.root.print('[SnitchServe] $message');
}

extension on ByteData {
  List<int> asListUint8() => List<int>.generate(lengthInBytes, getUint8);
}
