import 'dart:convert';
import 'package:convey/src/bot_model.dart';
import 'package:convey/src/bot_config.dart';
import 'package:convey/src/runner.dart';
import 'package:nyxx/nyxx.dart';


class Bot {

  Bot({required this.config});


  final BotConfig config;
  late final NyxxGateway client;
  late final Guild guild;
  late final GuildTextChannel channel;
  final Cmd cmd = Cmd();


  void start() async {

    client = await Nyxx.connectGateway(config.token, GatewayIntents.all);
    final botUser = await client.users.fetchCurrentUser();

    client.onReady.listen((event) async {

      print('Bot is ready to receive messages! 🚀');

      guild = await client.guilds.fetch(Snowflake(config.guildId));

      client.channels.cache.forEach((Snowflake id, Channel channel) async {
        if (channel is GuildTextChannel) {
          print('Bot is connected to channel: ${channel.name}');
          this.channel = channel;
          _ping();
        }
      });

      client.onMessageCreate.listen((event) async {

        if (event.message.author.id == botUser.id) {
          return;
        }

        final message = event.message;

        print(message);
        if (message.content.isEmpty) {
          return;
        }

        if (message.content.startsWith('!')) {
          _onCommand(message);
        } else {
          _onMessage(message);
        }

      });

    });

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

      if (message.content.trim() == '!config') {
        _onConfig(message);
        return;
      }

      final result = await cmd.run(message.content);
      _sendMessage(message, result.first.stdout);
    } catch (e) {
      _sendMessage(message, e.toString());
    }

  }


  void _onConfig(Message message) {
    print('Config command received: ${message.content}');
    _sendMessage(message, jsonEncode(config.toJson()));
  }

  
  void _sendMessage(Message message, String text) {
    final builder = MessageBuilder(
        content: jsonEncode({
          'bot': bot.toJson(),
          'message': text
        }),
        replyId: message.id,
    );

    message.channel.sendMessage(builder);
  }


  void _ping() async {
    await channel.sendMessage(MessageBuilder(
      content: jsonEncode({
        'bot': bot.toJson(),
        'message': "!ping"
      }),
    ));
  }


  void stop() {
    client.close();
    print('Bot is stopping... 🛑');
  }


  BotModel get bot => config.bot;

}