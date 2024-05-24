part of 'user_bot_bloc.dart';

sealed class UserBotState extends Equatable {
  const UserBotState();
}

final class UserBotInitial extends UserBotState {
  @override
  List<Object> get props => [];
}

final class UserBotStarted extends UserBotState {
  const UserBotStarted();
  @override
  List<Object> get props => [];
}

final class UserBotMessageReceived extends UserBotState {
  const UserBotMessageReceived(this.message);
  final ConsoleMessageModel message;
  @override
  List<Object> get props => [message];
}

final class UserBotMessageSent extends UserBotState {
  const UserBotMessageSent(this.message);
  final ConsoleMessageModel message;
  @override
  List<Object> get props => [message];
}

final class UserBotPingMessageReceived extends UserBotState {
  const UserBotPingMessageReceived(this.message);
  final ConsoleMessageModel message;
  @override
  List<Object> get props => [message];
}