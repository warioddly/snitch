import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nyxx/nyxx.dart';

part 'user_bot_event.dart';
part 'user_bot_state.dart';

class UserBotBloc extends Bloc<UserBotEvent, UserBotState> {

  UserBotBloc() : super(UserBotInitial()) {
    on<UserBotStarted>(_onStarted);
    on<UserBotMessageSent>(_onMessageSent);
    on<UserBotMessageReceived>(_onMessageReceived);
  }

  PartialTextChannel? _channel;
  final String _token = "MTI0MzExNjM2NzkzMDk4NjU4Nw.Gg6VTO.jeBSmgTFvR6F_35d0pqzGYaR3Af3OI_u1YG-eU";
  late final NyxxGateway client;


  Future<void> _onStarted(UserBotStarted event, Emitter<UserBotState> emit) async {

    try {
      emit(UserBotLoading());

      client = await Nyxx.connectGateway(_token, GatewayIntents.all);
      final user = await client.users.fetchCurrentUser();

      client.onMessageCreate.listen((event) async {

        if (event.message.author.id == user.id) return;

        final message = event.message;
        _channel = message.channel;
        add(UserBotMessageReceived(message));

      });

      emit(UserBotLoaded());
    }
    catch (e) {
      debugPrint(e.toString());
    }

  }


  Future<void> _onMessageReceived(UserBotMessageReceived event, Emitter<UserBotState> emit) async {
    print('User Bot Message Received: ${event.message.content}');
    emit(UserBotMessageReceivedState(event.message));
  }

  Future<void> _onMessageSent(UserBotMessageSent event, Emitter<UserBotState> emit) async {
    final builder = MessageBuilder(content: event.content);
    _channel?.sendMessage(builder);
  }

}
