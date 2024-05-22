part of 'bots_bloc.dart';

sealed class BotsState extends Equatable {
  const BotsState();
}

final class BotsInitial extends BotsState {
  @override
  List<Object> get props => [];
}

final class BotsLoading extends BotsState {
  @override
  List<Object> get props => [];
}

final class BotsLoaded extends BotsState {
  final List<BotModel> bots;

  const BotsLoaded(this.bots);

  @override
  List<Object> get props => [bots];
}

final class BotsError extends BotsState {
  final String message;

  const BotsError(this.message);

  @override
  List<Object> get props => [message];
}

final class BotsDeleted extends BotsState {
  final bool success;

  const BotsDeleted(this.success);

  @override
  List<Object> get props => [success];
}

final class BotsEmpty extends BotsState {

  const BotsEmpty();

  @override
  List<Object> get props => [];
}

