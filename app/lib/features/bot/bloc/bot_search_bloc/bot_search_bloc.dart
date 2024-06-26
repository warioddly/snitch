import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:snitch/features/bot/models/bot_model.dart';
import 'package:snitch/features/bot/repositories/bot_local_repository.dart';

part 'bot_search_event.dart';
part 'bot_search_state.dart';

class BotSearchBloc extends Bloc<BotSearchEvent, BotSearchState> {


  BotSearchBloc({required this.repository}) : super(BotSearchInitial()) {
    on<BotSearchBotEvent>(_onSearch);
  }


  final BotLocalRepository repository;


  void _onSearch(BotSearchBotEvent event, Emitter<BotSearchState> emit) async {
    try {
      emit(BotSearchLoading());

      final result = await repository.search(event.query);

      result.fold(
        (l) => throw l,
        (bots) => bots.isEmpty ? emit(BotSearchEmpty()) : emit(BotSearchBots(bots: bots))
      );

    } catch (e) {
      emit(BotSearchError(message: e.toString()));
    }
  }



}
