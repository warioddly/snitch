import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snitch/features/bot/models/bot_model.dart';
import 'package:snitch/features/bot/repositories/bot_local_repository.dart';

part 'bot_event.dart';
part 'bot_state.dart';

class BotsBloc extends Bloc<BotsEvent, BotsState> {


  BotsBloc({required this.repository}) : super(BotsInitial()) {
    on<BotsReadEvent>(_onReadAll);
    on<BotsDeleteEvent>(_onDeleteAll);
  }

  final BotLocalRepository repository;

  void _onReadAll(BotsReadEvent event, Emitter<BotsState> emit) async {
    emit(BotsLoading());
    try {
      List<BotModel> bots = await repository.readAll();

      if (bots.isEmpty) {
        emit(const BotsEmpty());
      }
      else {
        emit(BotsLoaded(bots));
      }

    } catch (e) {
      emit(BotsError(e.toString()));
    }
  }

  void _onDeleteAll(BotsDeleteEvent event, Emitter<BotsState> emit) async {
    emit(BotsLoading());
    try {
      bool result = await repository.deleteAll();
      if (result) {
        emit(BotsDeleted(result));
      } else {
        emit(const BotsError('Record not found'));
      }
    } catch (e) {
      emit(BotsError(e.toString()));
    }
  }

}
