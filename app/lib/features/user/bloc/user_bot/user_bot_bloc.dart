import 'dart:convert';
import 'package:discord/discord.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snitch/features/bot/faker/bot_faker.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/console/model/console_message_model.dart';
import 'package:snitch/features/user/model/user_config_model.dart';

part 'user_bot_event.dart';
part 'user_bot_state.dart';

class UserBotBloc extends Bloc<UserBotEvent, UserBotState> {


  UserBotBloc() : super(UserBotInitial()) {
    on<UserBotStartEvent>(_onStarted);
    on<UserBotMessageSendEvent>(_onMessageSend);
    on<UserBotMessageReceivedEvent>(_onMessageReceived);
  }


  // guildId = 1243116555248734301;
  // _token = MTI0MzExNjM2NzkzMDk4NjU4Nw.Gg6VTO.jeBSmgTFvR6F_35d0pqzGYaR3Af3OI_u1YG-eU;
  // late final String _token;
  late final Discord discord;
  late final BotModel bot;


  Future<void> _onStarted(UserBotStartEvent event, Emitter<UserBotState> emit) async {

    try {

      bot = BotFaker.createBot();

      discord = Discord(
          token: event.config.token,
          guildId: event.config.guildId,
          onMessageCreate: _onMessage,
          onChannelReady: (channel) async {
            _sendMessage('!ping');
          },
      );

      await discord.start();

      emit(const UserBotStarted());

    }
    catch (e) {
      debugPrint(e.toString());
      emit(UserBotError(error: e));
    }

  }


  Future<void> _onMessageReceived(UserBotMessageReceivedEvent event, Emitter<UserBotState> emit) async {
    try {

      if (event.message.content == '!ping') {
        emit(UserBotPingMessageReceived(event.message));
        return;
      }

      emit(UserBotMessageReceived(event.message));
    }
    catch (e) {
      debugPrint(e.toString());
    }

  }


  Future<void> _onMessageSend(UserBotMessageSendEvent event, Emitter<UserBotState> emit) async {
    try {
      final message = ConsoleMessageModel.fromJson({
        'bot': bot.toJson(),
        'user': discord.user?.toJson(),
        'content': event.message,
        'createdAt': DateTime.now().toIso8601String(),
      });
      await _sendMessage(jsonEncode(message.toJson()));
      emit(UserBotMessageSent(message));
    }
    catch (e) {
      debugPrint(e.toString());
    }
  }


  Future<void> _onMessage(MessageCreateEvent event) async {

    try {
      debugPrint('User Bot Message Received: ${event.message.content}');

      final message = event.message;

      if (event.message.author.id.value == discord.user?.id || message.content.isEmpty) {
        debugPrint('Message received: ${message.content}');
        return;
      }

      debugPrint('Message received: ${message.content}');
      add(UserBotMessageReceivedEvent(ConsoleMessageModel.fromJson(jsonDecode(message.content))));

    }
    catch (e) {
      debugPrint(e.toString());
    }

  }


  Future<void> _sendMessage(String content, [Message? message, bool reply = false]) async {
    try {
      await discord.sendMessage(content, message, reply);
    }
    catch (e) {
      debugPrint(e.toString());
    }
  }


  DiscordUserModel? get user => discord.user;

}
