import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:snitch/snitch.dart';
import 'package:snitch_inspector_serve/src/assets/index.dart';


class SnitchInspector {
  SnitchInspector({
    required Snitch snitch,
    InternetAddress? internetAddress,
    this.port = 4040,
  }) : _snitch = snitch,
       internetAddress = internetAddress ?? InternetAddress.anyIPv6;

  final Snitch _snitch;
  final InternetAddress internetAddress;
  final int port;

  HttpServer? _server;

  Future<void> serve() async {
    _server = await HttpServer.bind(internetAddress, port);

    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        print('Server running at http://${addr.address}:$port/');
      }
    }

    await for (HttpRequest request in _server!) {
      final path = request.uri.path;

      print('Request: ${request.method} $path');

      if (path.startsWith('/api')) {
        if (path == '/api/logs') {
          request.response.headers.contentType = ContentType.json;

          final logs = _snitch.logs.map((log) => { "log": log.toString() }).toList();

          request.response.write(jsonEncode(logs));
        } else {
          request.response.statusCode = HttpStatus.notFound;
          request.response.write('API endpoint not found');
        }
      } else {
        request.response.headers.contentType = ContentType.html;
        request.response.write(indexHtml);
      }

      await request.response.close();
    }
  }

  ContentType getContentType(String path) {
    final ext = p.extension(path).toLowerCase();
    switch (ext) {
      case '.html':
        return ContentType.html;
      case '.json':
        return ContentType.json;
      case '.js':
        return ContentType('application', 'javascript');
      case '.css':
        return ContentType('text', 'css');
      case '.png':
        return ContentType('image', 'png');
      case '.jpg':
      case '.jpeg':
        return ContentType('image', 'jpeg');
      case '.svg':
        return ContentType('image', 'svg+xml');
      case '.ico':
        return ContentType('image', 'x-icon');
      case '.txt':
        return ContentType.text;
      default:
        return ContentType.binary;
    }
  }

  Future<void> close({bool force = false}) async {
    if (_server != null) {
      await _server?.close(force: force);
      print('Snitch Inspector server closed.');
    } else {
      print('Snitch Inspector server was not running.');
    }
  }
}
