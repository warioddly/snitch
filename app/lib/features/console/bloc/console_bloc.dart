import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

part 'console_event.dart';
part 'console_state.dart';

class ConsoleBloc extends Bloc<ConsoleEvent, ConsoleState> {

  ConsoleBloc({ required this.bot }) : super(ConsoleInitial()) {
    on<ConsoleStarted>(_onStarted);
    on<ConsoleMessageSent>(_onMessageSent);
    on<ConsoleMessageReceived>(_onMessageReceived);
  }

  final BotModel bot;
  late final TeleDart teledart;

  Future<void> _onStarted(ConsoleStarted event, Emitter<ConsoleState> emit) async {

    // final telegram = Telegram(bot.token);
    teledart = TeleDart(bot.token, Event(bot.name));
    teledart.start();
    teledart.onMessage().listen((message) {
      add(ConsoleMessageReceived(message));
    });

  }


  Future<void> _onMessageReceived(ConsoleMessageReceived event, Emitter<ConsoleState> emit) async {
    print('Message received: ${event.message.text}');
  }

  Future<void> _onMessageSent(ConsoleMessageSent event, Emitter<ConsoleState> emit) async {
    teledart.sendMessage(event.message.chat.id, event.content);
  }

}
