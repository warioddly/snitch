import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

final class SnitchServe {
  SnitchServe({this.port = 4040, InternetAddress? address})
    : _address = address ?? InternetAddress.anyIPv6;

  final int port;
  final InternetAddress _address;

  HttpServer? _server;
  SecurityContext? _context;

  final _logs = <Map<String, dynamic>>[];

  void addLog(Map<String, dynamic> data) => _logs.add(data);

  void clearLogs() => _logs.clear();

  Future<void> startServe() async {
    try {
      _log('Start serve...');

      if (_context == null) {
        final (certificateKeyBytes, privateKeyBytes) = await (
          rootBundle.load('packages/snitch_serve/certs/localhost+2.pem'),
          rootBundle.load('packages/snitch_serve/certs/localhost+2-key.pem'),
        ).wait;

        _context = SecurityContext()
          ..useCertificateChainBytes(certificateKeyBytes.asListUint8())
          ..usePrivateKeyBytes(privateKeyBytes.asListUint8());
      }

      _server = await HttpServer.bindSecure(_address, port, _context!);

      if (_server == null) {
        throw Exception('Can\'t bind server');
      }

      await for (final request in _server!) {
        _log('Request [${request.method}] ${request.uri}');

        request.response.headers.add('Access-Control-Allow-Origin', '*');
        request.response.headers.add(
          'Access-Control-Allow-Methods',
          'GET, POST, OPTIONS',
        );
        request.response.headers.add('Access-Control-Allow-Headers', '*');

        if (request.uri.path == '/logs') {
          request.response
            ..statusCode = HttpStatus.ok
            ..write(jsonEncode(_logs))
            ..close();
        } else {
          request.response
            ..statusCode = HttpStatus.notFound
            ..write(jsonEncode({'message': 'Page not found', 'status': 404}))
            ..close();
        }
      }
    } catch (e, s) {
      _log('Error: $e \n$s');
    }
  }

  Future<void> close() async {
    if (_server == null) {
      _log('Server while not run');
    }
    return _server?.close();
  }

  Future<void> printAddresses() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        Zone.root.print('https://${addr.address}:$port');
      }
    }
  }

  void _log(String message) => Zone.root.print('[SnitchServe] $message');
}

extension on ByteData {
  List<int> asListUint8() => List<int>.generate(lengthInBytes, getUint8);
}