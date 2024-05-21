import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/repository/bot_local_repository.dart';

part 'bot_search_event.dart';
part 'bot_search_state.dart';

class BotSearchBloc extends Bloc<BotSearchEvent, BotSearchState> {


  BotSearchBloc({required this.repository}) : super(BotSearchInitial()) {
    on<BotSearchReadAllEvent>(_onReadAll);
    on<BotSearchBotEvent>(_onSearch);

  }


  final BotLocalRepository repository;


  void _onReadAll(BotSearchReadAllEvent event, Emitter<BotSearchState> emit) async {

    try {
      List<BotModel> bots = await repository.readAll();
      if (bots.isEmpty) {
        emit(BotSearchEmpty());
      } else {
        emit(BotSearchBots(bots: bots));
      }
    } catch (e) {
      emit(BotSearchError(message: e.toString()));
    }

  }


  void _onSearch(BotSearchBotEvent event, Emitter<BotSearchState> emit) async {
    emit(BotSearchLoading());
    try {
      final bots = await repository.search(event.query);
      print(bots.length);
      if (bots.isEmpty) {
        emit(BotSearchEmpty());
      } else {
        emit(BotSearchBots(bots: bots));
      }
    } catch (e) {
      emit(BotSearchError(message: e.toString()));
    }
  }



}
