import 'dart:convert';
import 'package:convey/src/bot_model.dart';
import 'package:convey/core/services/bot_config.dart';
import 'package:convey/src/message_model.dart';
import 'package:convey/src/runner.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';


class Bot {

  Bot({required this.config});

  final BotConfig config;
  late final Telegram telegram;
  late final TeleDart teledart;
  final Cmd cmd = Cmd();


  void start() async {

    print('Bot is starting... 🤖');

    telegram = Telegram(token);
    teledart = TeleDart(token, Event(bot.name));

    teledart
      ..start()
      ..onMessage().listen(_onMessage)
      ..onCommand('start').listen(_onCommand)
      ..onCommand('config').listen(_onConfig);

    print('Bot is ready to receive messages! 🚀');

  }


  void _onMessage(Message message) async {
    print('Message received: ${message.text}');

    if (message.text == null) {
      _sendMessage(message, 'Please send a text message');
      return;
    }

    try {
      final result = await cmd.run(message.text!);
      _sendMessage(message, result.first.stdout);
    } catch (e) {
      _sendMessage(message, e.toString());
    }

  }


  void _onCommand(Message message) async {
    print('Command received: ${message.text}');
    if (message.text == null) {
      _sendMessage(message, 'Please send a text message');
      return;
    }

    try {
      final result = await cmd.run(message.text!);
      _sendMessage(message, result.first.stdout);
    } catch (e) {
      _sendMessage(message, e.toString());
    }

  }


  void _onConfig(Message message) {
    print('Config command received: ${message.text}');
    _sendMessage(message, jsonEncode({
      'bot': bot.toJson(),
      'config': message.toJson()
    }));
  }

  
  void _sendMessage(Message message, String text) {
    teledart.sendMessage(message.chat.id, jsonEncode(MessageModel(bot: bot, content: text).toJson()));
  }


  void stop() {
    teledart.stop();
    telegram.close();
    print('Bot is stopping... 🛑');
  }


  BotModel get bot => config.bot;


  String get token => config.bot.token;

}