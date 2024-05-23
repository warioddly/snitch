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

  final Message message;

  @override
  List<Object> get props => [message];
}

final class UserBotMessageSent extends UserBotEvent {
  const UserBotMessageSent(this.content);

  final String content;

  @override
  List<Object> get props => [content];
}