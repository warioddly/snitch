import 'package:discord/discord.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'console_event.dart';
part 'console_state.dart';

class ConsoleBloc extends Bloc<ConsoleEvent, ConsoleState> {
  ConsoleBloc(super.initialState);

  // ConsoleBloc({ required this.bot }) : super(ConsoleInitial()) {
  //   on<ConsoleStarted>(_onStarted);
  //   on<ConsoleMessageSent>(_onMessageSent);
  //   on<ConsoleMessageReceived>(_onMessageReceived);
  // }
  //
  // final BotModel bot;
  // late final TeleDart teledart;
  // int chatId = -1;
  //
  //
  // Future<void> _onStarted(ConsoleStarted event, Emitter<ConsoleState> emit) async {
  //
  //   // final discord = discord(bot.token);
  //   teledart = TeleDart(bot.token, Event(bot.name));
  //   teledart
  //     ..start()
  //     ..onMessage().listen((message) {
  //       chatId = message.chat.id;
  //       add(ConsoleMessageReceived(message));
  //     });
  //
  // }
  //
  //
  // Future<void> _onMessageReceived(ConsoleMessageReceived event, Emitter<ConsoleState> emit) async {
  //   print('Message received: ${event.message.text}');
  // }
  //
  // Future<void> _onMessageSent(ConsoleMessageSent event, Emitter<ConsoleState> emit) async {
  //   if (chatId == -1) {
  //     print('No chatId');
  //     return;
  //   }
  //   teledart.sendMessage(chatId, event.content);
  // }

}
