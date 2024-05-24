part of 'user_bot_bloc.dart';

sealed class UserBotEvent extends Equatable {
  const UserBotEvent();
}

final class UserBotStarted extends UserBotEvent {
  @override
  List<Object> get props => [];
}

final class UserBotStopped extends UserBotEvent {
  @override
  List<Object> get props => [];
}

final class UserBotMessageReceived extends UserBotEvent {
  const UserBotMessageReceived(this.message);

  final ConsoleMessageModel message;

  @override
  List<Object> get props => [message];
}


final class UserBotMessageSend extends UserBotEvent {
  const UserBotMessageSend(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class UserBotMessageSent extends UserBotEvent {
  const UserBotMessageSent(this.message);

  final ConsoleMessageModel message;

  @override
  List<Object> get props => [message];
}