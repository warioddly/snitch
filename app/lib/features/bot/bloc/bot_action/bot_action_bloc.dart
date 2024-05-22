import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/repository/bot_local_repository.dart';

part 'bot_action_event.dart';
part 'bot_action_state.dart';

class BotActionBloc extends Bloc<BotActionEvent, BotActionState> {


  BotActionBloc({ required this.repository }) : super(const BotActionInitial()) {
    on<BotActionCreateEvent>(_onCreate);
    on<BotActionUpdateEvent>(_onUpdate);
    on<BotActionDeleteEvent>(_onDelete);
    on<BotActionInitialEvent>(_onInitial);
    // on<BotActionReadEvent>(_onRead);
  }


  final BotLocalRepository repository;


  // void _onRead(BotActionReadEvent event, Emitter<BotActionState> emit) async {
  //   emit(BotLoading());
  //   try {
  //     BotModel bot = await repository.read(event.id);
  //     emit(BotLoaded(bot));
  //   } catch (e) {
  //     emit(BotError(e.toString()));
  //   }
  // }

  void _onInitial(BotActionInitialEvent event, Emitter<BotActionState> emit) async {
    emit(const BotActionInitial());
  }


  void _onCreate(BotActionCreateEvent event, Emitter<BotActionState> emit) async {
    emit(BotActionLoading());
    try {
      final bot = await repository.create(event.bot);
      emit(BotActionSuccess(bot: bot));
    } catch (e) {
      emit(BotActionError(message: e.toString()));
    }
  }


  void _onUpdate(BotActionUpdateEvent event, Emitter<BotActionState> emit) async {
    emit(BotActionLoading());
    try {
      final bot = await repository.update(event.bot);
      emit(BotActionSuccess(bot: bot));
    } catch (e) {
      emit(BotActionError(message: e.toString()));
    }
  }


  void _onDelete(BotActionDeleteEvent event, Emitter<BotActionState> emit) async {
    emit(BotActionLoading());
    try {
      bool result = await repository.delete(event.id);
      if (result) {
        emit(BotActionDeleted(result));
      } else {
        emit(const BotActionError(message: 'Record not found'));
      }
    } catch (e) {
      emit(BotActionError(message: e.toString()));
    }
  }

}
