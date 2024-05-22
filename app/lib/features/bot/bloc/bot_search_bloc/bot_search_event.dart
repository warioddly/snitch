part of 'bot_search_bloc.dart';

@immutable
sealed class BotSearchEvent extends Equatable {
  const BotSearchEvent();
  @override
  List<Object> get props => [];
}

class BotSearchInitialEvent extends BotSearchEvent {
  const BotSearchInitialEvent();
}


class BotSearchBotEvent extends BotSearchEvent {
  final String query;
  const BotSearchBotEvent(this.query);
  @override
  List<Object> get props => [query];
}
