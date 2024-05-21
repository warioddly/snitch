part of 'bot_bloc.dart';

sealed class BotState extends Equatable {
  const BotState();
}

final class BotInitial extends BotState {
  @override
  List<Object> get props => [];
}

final class BotLoading extends BotState {
  @override
  List<Object> get props => [];
}

final class BotLoaded extends BotState {
  final BotModel bot;

  const BotLoaded(this.bot);

  @override
  List<Object> get props => [bot];
}

final class BotError extends BotState {
  final String message;

  const BotError(this.message);

  @override
  List<Object> get props => [message];
}

final class BotAllLoaded extends BotState {
  final List<BotModel> bots;

  const BotAllLoaded(this.bots);

  @override
  List<Object> get props => [bots];
}

final class BotListError extends BotState {
  final String message;

  const BotListError(this.message);

  @override
  List<Object> get props => [message];
}

final class BotCreated extends BotState {
  final BotModel bot;

  const BotCreated(this.bot);

  @override
  List<Object> get props => [bot];
}

final class BotUpdated extends BotState {
  final BotModel bot;

  const BotUpdated(this.bot);

  @override
  List<Object> get props => [bot];
}

final class BotDeleted extends BotState {
  final bool success;

  const BotDeleted(this.success);

  @override
  List<Object> get props => [success];
}

final class BotAllDeleted extends BotState {
  final bool success;

  const BotAllDeleted(this.success);

  @override
  List<Object> get props => [success];
}

final class BotListEmpty extends BotState {

  const BotListEmpty();

  @override
  List<Object> get props => [];
}

