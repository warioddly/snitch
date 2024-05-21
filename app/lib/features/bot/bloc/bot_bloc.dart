import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/repository/bot_local_repository.dart';

part 'bot_event.dart';
part 'bot_state.dart';

class BotBloc extends Bloc<BotEvent, BotState> {


  BotBloc({required this.repository}) : super(BotLoading()) {
    on<BotCreate>(_onCreate);
    on<BotReadEvent>(_onRead);
    on<BotUpdateEvent>(_onUpdate);
    on<BotDeleteEvent>(_onDelete);
    on<BotReadAllEvent>(_onReadAll);
    on<BotDeleteAllEvent>(_onDeleteAll);
    on<BotErrorEvent>(_onError);
  }


  final BotLocalRepository repository;


  void _onCreate(BotCreate event, Emitter<BotState> emit) async {
    emit(BotLoading());
    try {
      BotModel bot = await repository.create(event.bot);
      emit(BotCreated(bot));
    } catch (e) {
      emit(BotError(e.toString()));
    }
  }


  void _onRead(BotReadEvent event, Emitter<BotState> emit) async {
    emit(BotLoading());
    try {
      BotModel bot = await repository.read(event.id);
      emit(BotLoaded(bot));
    } catch (e) {
      emit(BotError(e.toString()));
    }
  }


  void _onUpdate(BotUpdateEvent event, Emitter<BotState> emit) async {
    emit(BotLoading());
    try {
      BotModel bot = await repository.update(event.bot);
      emit(BotUpdated(bot));
    } catch (e) {
      emit(BotError(e.toString()));
    }
  }


  void _onDelete(BotDeleteEvent event, Emitter<BotState> emit) async {
    emit(BotLoading());
    try {
      bool result = await repository.delete(event.id);
      if (result) {
        emit(BotDeleted(result));
      } else {
        emit(const BotError('Record not found'));
      }
    } catch (e) {
      emit(BotError(e.toString()));
    }
  }


  void _onReadAll(BotReadAllEvent event, Emitter<BotState> emit) async {
    emit(BotLoading());
    try {
      List<BotModel> bots = await repository.readAll();

      if (bots.isEmpty) {
        emit(const BotListEmpty());
      }
      else {
        emit(BotAllLoaded(bots));
      }

    } catch (e) {
      emit(BotListError(e.toString()));
    }
  }


  void _onDeleteAll(BotDeleteAllEvent event, Emitter<BotState> emit) async {
    emit(BotLoading());
    try {
      bool result = await repository.deleteAll();
      if (result) {
        emit(BotDeleted(result));
      } else {
        emit(const BotError('Record not found'));
      }
    } catch (e) {
      emit(BotError(e.toString()));
    }
  }


  void _onError(BotErrorEvent event, Emitter<BotState> emit) async {
    emit(BotError(event.message));
  }


}
