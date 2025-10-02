import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:snitch_serve/src/certificates.dart';

final class SnitchServe {
  SnitchServe({this.port = 4040, InternetAddress? address})
    : _address = address ?? InternetAddress.anyIPv6;

  final int port;
  final InternetAddress _address;

  HttpServer? _server;

  final _context = SecurityContext()
    ..useCertificateChainBytes(certificateKeyBytes)
    ..usePrivateKeyBytes(privateKeyBytes);

  final _logs = <Map<String, dynamic>>[];

  void addLog(Map<String, dynamic> data) => _logs.add(data);

  void clearLogs() => _logs.clear();

  Future<void> startServe() async {
    try {
      _log('Start serve...');

      _server = await HttpServer.bindSecure(_address, port, _context);

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
            ..write(jsonEncode(_logs.map((e) => e).toList()))
            ..close();
        } else {
          request.response
            ..statusCode = HttpStatus.notFound
            ..write(jsonEncode({'message': 'Page not found', 'status': 404}))
            ..close();
        }

      }
    } catch (e, s) {
      log('', error: e, stackTrace: s, name: 'SnitchServe');
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
        _log('https://${addr.address}:$port');
      }
    }
  }

  void _log(String message) => log(message, name: 'SnitchServe');
}
