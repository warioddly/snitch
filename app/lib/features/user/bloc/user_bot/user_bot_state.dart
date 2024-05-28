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

final class UserBotStarting extends UserBotState {
  const UserBotStarting();
  @override
  List<Object> get props => [];
}


final class UserBotRestarted extends UserBotState {
  const UserBotRestarted();
  @override
  List<Object> get props => [];
}

final class UserBotRestarting extends UserBotState {
  const UserBotRestarting();
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

final class UserBotError extends UserBotState {
  const UserBotError({required this.error});
  final Object error;
  @override
  List<Object> get props => [error];
}