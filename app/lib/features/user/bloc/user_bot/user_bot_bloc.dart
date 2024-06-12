import 'dart:convert';
import 'package:discord/discord.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snitch/features/bot/faker/bot_faker.dart';
import 'package:snitch/features/bot/models/bot_model.dart';
import 'package:snitch/features/console/model/console_message_model.dart';
import 'package:snitch/features/user/models/user_config_model.dart';

part 'user_bot_event.dart';
part 'user_bot_state.dart';

class UserBotBloc extends Bloc<UserBotEvent, UserBotState> {


  UserBotBloc() : super(UserBotInitial()) {
    on<UserBotStartEvent>(_onStarted);
    on<UserBotRestartEvent>(_onRestarted);
    on<UserBotMessageSendEvent>(_onMessageSend);
    on<UserBotMessageReceivedEvent>(_onMessageReceived);
  }


  Discord?  _discord;
  BotModel? _bot;


  DiscordUserModel? get user => _discord?.user;

  BotModel? get bot => _bot;


  Future<void> _onStarted(UserBotStartEvent event, Emitter<UserBotState> emit) async {

    try {

      emit(const UserBotStarting());

      _bot = BotFaker.createBot();

      _discord = Discord(
          token: event.config.token,
          guildId: event.config.guildId,
          onMessageCreate: _onMessage,
          onChannelReady: (channel) async {
            _sendMessage('!ping');
          },
      );

      await _discord?.start();

      emit(const UserBotStarted());

    }
    catch (e) {
      debugPrint(e.toString());
      emit(UserBotError(error: e));
    }

  }


  Future<void> _onRestarted(UserBotRestartEvent event, Emitter<UserBotState> emit) async {

    try {

      emit(const UserBotRestarting());

      _bot = BotFaker.createBot();

      if (_discord != null) {
        await _discord?.client?.close();
      }

      _discord = Discord(
          token: event.config.token,
          guildId: event.config.guildId,
          onMessageCreate: _onMessage,
          onChannelReady: (channel) async {
            _sendMessage('!ping');
          },
          onError: (e) {

            if (e is DiscordTokenSuccessStatus) {

            }

          }
      );

      await _discord?.start();

      emit(const UserBotRestarted());

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

      if (_discord == null) {
        throw 'Discord is not initialized';
      }

      final message = ConsoleMessageModel.fromJson({
        'bot': _bot?.toJson(),
        'user': _discord?.user?.toJson(),
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

      if (_discord == null) {
        throw 'Discord is not initialized';
      }

      final message = event.message;

      if (event.message.author.id.value == _discord?.user?.id || message.content.isEmpty) {
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
      await _discord?.sendMessage(content, message, reply);
    }
    catch (e) {
      debugPrint(e.toString());
    }
  }


}
