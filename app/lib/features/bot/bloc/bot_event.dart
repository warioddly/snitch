part of 'bot_bloc.dart';

sealed class BotEvent extends Equatable {
  const BotEvent();
}

final class BotCreate extends BotEvent {
  final BotModel bot;

  const BotCreate(this.bot);

  @override
  List<Object> get props => [bot];
}

final class BotReadEvent extends BotEvent {
  final String id;

  const BotReadEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class BotUpdateEvent extends BotEvent {
  final BotModel bot;

  const BotUpdateEvent(this.bot);

  @override
  List<Object> get props => [bot];
}

final class BotDeleteEvent extends BotEvent {
  final int id;

  const BotDeleteEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class BotReadAllEvent extends BotEvent {
  const BotReadAllEvent();

  @override
  List<Object> get props => [];
}

final class BotDeleteAllEvent extends BotEvent {
  const BotDeleteAllEvent();

  @override
  List<Object> get props => [];
}

final class BotErrorEvent extends BotEvent {
  final String message;

  const BotErrorEvent(this.message);

  @override
  List<Object> get props => [message];
}
