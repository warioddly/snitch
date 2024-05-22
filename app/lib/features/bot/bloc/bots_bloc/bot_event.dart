part of 'bots_bloc.dart';

sealed class BotsEvent extends Equatable {
  const BotsEvent();
  @override
  List<Object> get props => [];
}

final class BotsReadEvent extends BotsEvent {
  const BotsReadEvent();
}

final class BotsDeleteEvent extends BotsEvent {
  const BotsDeleteEvent();
}
