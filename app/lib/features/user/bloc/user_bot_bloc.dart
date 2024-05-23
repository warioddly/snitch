import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

part 'user_bot_event.dart';
part 'user_bot_state.dart';

class UserBotBloc extends Bloc<UserBotEvent, UserBotState> {

  UserBotBloc() : super(UserBotInitial()) {
    on<UserBotStarted>(_onStarted);
    on<UserBotMessageSent>(_onMessageSent);
    on<UserBotMessageReceived>(_onMessageReceived);
  }

  late final TeleDart teledart;
  int chatId = -4277415493;
  final String token = "7169734202:AAFu9_2FeHS7X09yqaIL4dCXlAfFHOsn1JU";


  Future<void> _onStarted(UserBotStarted event, Emitter<UserBotState> emit) async {

    // final telegram = Telegram(bot.token);
    try {
      emit(UserBotLoading());
      teledart = TeleDart(token, Event("User"));
      teledart
        ..start()
        ..onMessage().listen((message) {
          chatId = message.chat.id;
          add(UserBotMessageReceived(message));
        });

      emit(UserBotLoaded());
    }
    catch (e) {
      print(e);
    }

  }


  Future<void> _onMessageReceived(UserBotMessageReceived event, Emitter<UserBotState> emit) async {
    print('User Bot Message Received: ${event.message.text}');
    emit(UserBotMessageReceivedState(event.message));
  }

  Future<void> _onMessageSent(UserBotMessageSent event, Emitter<UserBotState> emit) async {
    if (chatId == -1) {
      print('No chatId');
      return;
    }
    teledart.sendMessage(chatId, event.content);
  }

}
