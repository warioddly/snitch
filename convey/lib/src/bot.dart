import 'dart:convert';
import 'package:convey/src/bot_model.dart';
import 'package:convey/core/services/bot_config.dart';
import 'package:convey/src/runner.dart';
import 'package:nyxx/nyxx.dart';


class Bot {

  Bot({required this.config});

  final BotConfig config;
  late final NyxxGateway client;
  final Cmd cmd = Cmd();


  void start() async {

    final client = await Nyxx.connectGateway(token, GatewayIntents.all);

    final botUser = await client.users.fetchCurrentUser();

    client.onMessageCreate.listen((event) async {
      if (event.message.author.id == botUser.id) {
        return;
      }
      final message = event.message;

      print(message);

      if (message.content.startsWith('!')) {
        _onCommand(message);
      } else {
        _onMessage(message);
      }
    });

    print('Bot is ready to receive messages! 🚀');

  }


  void _onMessage(Message message) async {
    print('Message received: ${message.content}');

    if (message.content.isEmpty) {
      _sendMessage(message, 'Please send a text message');
      return;
    }

    try {
      final result = await cmd.run(message.content);
      _sendMessage(message, result.first.stdout);
    } catch (e) {
      _sendMessage(message, e.toString());
    }

  }


  void _onCommand(Message message) async {
    print('Command received: ${message.content}');

    try {
      final result = await cmd.run(message.content);
      _sendMessage(message, result.first.stdout);
    } catch (e) {
      _sendMessage(message, e.toString());
    }

  }


  void _onConfig(Message message) {
    print('Config command received: ${message.content}');
    _sendMessage(message, jsonEncode({
      'bot': bot.toJson(),
      'config': message.content
    }));
  }

  
  void _sendMessage(Message message, String text) {
    final builder = MessageBuilder(content: jsonEncode({
      'bot': bot.toJson(),
      'message': text
    }));
    message.channel.sendMessage(builder);
  }


  void stop() {
    client.close();
    print('Bot is stopping... 🛑');
  }


  BotModel get bot => config.bot;

  String get token => config.bot.token;

}