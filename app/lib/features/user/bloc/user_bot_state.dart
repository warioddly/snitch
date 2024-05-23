part of 'user_bot_bloc.dart';

sealed class UserBotState extends Equatable {
  const UserBotState();
}

final class UserBotInitial extends UserBotState {
  @override
  List<Object> get props => [];
}

final class UserBotLoading extends UserBotState {
  @override
  List<Object> get props => [];
}

final class UserBotLoaded extends UserBotState {
  @override
  List<Object> get props => [];
}

final class UserBotMessageReceivedState extends UserBotState {
  const UserBotMessageReceivedState(this.message);

  final Message message;

  @override
  List<Object> get props => [message];
}