part of 'bot_search_bloc.dart';

@immutable
sealed class BotSearchState extends Equatable {
  const BotSearchState();
  @override
  List<Object> get props => [];
}

final class BotSearchInitial extends BotSearchState {}

final class BotSearchLoading extends BotSearchState {}

final class BotSearchEmpty extends BotSearchState {}

final class BotSearchBots extends BotSearchState {
  final List<BotModel> bots;
  const BotSearchBots({required this.bots});
  @override
  List<Object> get props => [bots];
}

final class BotSearchError extends BotSearchState {
  final String message;

  const BotSearchError({required this.message});
  @override
  List<Object> get props => [message];
}