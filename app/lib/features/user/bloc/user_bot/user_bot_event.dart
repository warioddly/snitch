part of 'user_bot_bloc.dart';

sealed class UserBotEvent extends Equatable {
  const UserBotEvent();
}

final class UserBotStartEvent extends UserBotEvent {
  const UserBotStartEvent(this.config);
  final UserConfigModel config;
  @override
  List<Object> get props => [];
}


final class UserBotMessageSendEvent extends UserBotEvent {
  const UserBotMessageSendEvent(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}


final class UserBotMessageReceivedEvent extends UserBotEvent {
  const UserBotMessageReceivedEvent(this.message);
  final ConsoleMessageModel message;
  @override
  List<Object> get props => [message];
}
