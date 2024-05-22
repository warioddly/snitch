part of 'bot_action_bloc.dart';

@immutable
abstract class BotActionState {
  const BotActionState();
}

class BotActionInitial extends BotActionState {
  const BotActionInitial();
}

class BotActionLoading extends BotActionState {}

class BotActionSuccess extends BotActionState {
  final BotModel? bot;

  const BotActionSuccess({this.bot});
}

class BotActionError extends BotActionState {
  final String message;
  const BotActionError({required this.message});
}


class BotActionDeleted extends BotActionState {
  final bool result;
  const BotActionDeleted(this.result);
}
