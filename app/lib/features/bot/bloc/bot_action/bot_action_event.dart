part of 'bot_action_bloc.dart';

@immutable
abstract class BotActionEvent {
  const BotActionEvent();
}

class BotActionCreateEvent extends BotActionEvent {
  final BotModel bot;
  const BotActionCreateEvent({required this.bot});
}

class BotActionUpdateEvent extends BotActionEvent {
  final BotModel bot;
  const BotActionUpdateEvent({required this.bot});
}

class BotActionDeleteEvent extends BotActionEvent {
  final int id;
  const BotActionDeleteEvent({required this.id});
}

class BotActionInitialEvent extends BotActionEvent {
  const BotActionInitialEvent();
}
