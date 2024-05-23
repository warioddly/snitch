import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nyxx/nyxx.dart';
import 'package:snitch/features/bot/faker/bot_faker.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/console/model/console_message_model.dart';

part 'user_bot_event.dart';
part 'user_bot_state.dart';

class UserBotBloc extends Bloc<UserBotEvent, UserBotState> {


  UserBotBloc() : super(UserBotInitialState()) {
    on<UserBotStarted>(_onStarted);
    on<UserBotMessageSend>(_onMessageSend);
    on<UserBotMessageReceived>(_onMessageReceived);
  }


  final String _token =  "MTI0MzExNjM2NzkzMDk4NjU4Nw.Gg6VTO.jeBSmgTFvR6F_35d0pqzGYaR3Af3OI_u1YG-eU";
  late final NyxxGateway client;
  late final User        user;
  late final BotModel    bot;
  PartialTextChannel?    _channel;


  Future<void> _onStarted(UserBotStarted event, Emitter<UserBotState> emit) async {

    try {

      bot    = BotFaker.createBot();
      client = await Nyxx.connectGateway(_token, GatewayIntents.all);
      user   = await client.users.fetchCurrentUser();

      client.onReady.listen((event) async {

        await _getChannel();

        debugPrint('User Bot is ready to receive messages! 🚀');

        client.onMessageCreate.listen(_onMessage);

      });

    }
    catch (e) {
      debugPrint(e.toString());
    }

  }


  Future<void> _onMessageReceived(UserBotMessageReceived event, Emitter<UserBotState> emit) async {

    try {

      if (event.message.content == '!ping') {
        emit(UserBotPingMessageReceivedState(event.message));
        return;
      }

      emit(UserBotMessageReceivedState(event.message));
    }
    catch (e) {
      debugPrint(e.toString());
    }

  }


  Future<void> _onMessageSend(UserBotMessageSend event, Emitter<UserBotState> emit) async {
    try {
      final message = ConsoleMessageModel.fromJson({
        'bot': bot.toJson(),
        'user': {
          'id': user.id.value,
          'name': user.username,
          'avatar': user.avatar.url.path,
        },
        'content': event.message,
        'createdAt': DateTime.now().toIso8601String(),
      });
      await _sendMessage(jsonEncode(message.toJson()));
      emit(UserBotMessageSentState(message));
    }
    catch (e) {
      debugPrint(e.toString());
    }
  }


  Future<void> _getChannel() async {

    await client.guilds.fetch(const Snowflake(1243116555248734301));

    client.channels.cache.forEach((Snowflake id, Channel channel) async {
      if (channel is GuildTextChannel) {
        debugPrint('User Bot is connected to channel: ${channel.name}');
        _channel = channel;
      }
    });
  }


  Future<void> _onMessage(MessageCreateEvent event) async {

    try {
      debugPrint('User Bot Message Received: ${event.message.content}');

      final message = event.message;

      if (event.message.author.id == user.id || message.content.isEmpty) {
        debugPrint('Message received: ${message.content}');
        return;
      }

      add(UserBotMessageReceived(ConsoleMessageModel.fromJson(jsonDecode(message.content))));

    }
    catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }

  }


  Future<void> _sendMessage(String content, [Message? message, bool reply = false]) async {
    try {
      await _channel?.sendMessage(MessageBuilder(content: content, replyId: reply ? null : message?.id));
    }
    catch (e) {
      debugPrint(e.toString());
    }
  }


}
