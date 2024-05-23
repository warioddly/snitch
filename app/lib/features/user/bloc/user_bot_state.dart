part of 'user_bot_bloc.dart';

sealed class UserBotState extends Equatable {
  const UserBotState();
}

final class UserBotInitialState extends UserBotState {
  @override
  List<Object> get props => [];
}

final class UserBotLoadingState extends UserBotState {
  @override
  List<Object> get props => [];
}

final class UserBotLoadedState extends UserBotState {
  @override
  List<Object> get props => [];
}


final class UserBotMessageReceivedState extends UserBotState {
  const UserBotMessageReceivedState(this.message);
  final ConsoleMessageModel message;
  @override
  List<Object> get props => [message];
}


final class UserBotMessageSentState extends UserBotState {
  const UserBotMessageSentState(this.message);
  final ConsoleMessageModel message;
  @override
  List<Object> get props => [message];
}


final class UserBotPingMessageReceivedState extends UserBotState {
  const UserBotPingMessageReceivedState(this.message);
  final ConsoleMessageModel message;
  @override
  List<Object> get props => [message];
}