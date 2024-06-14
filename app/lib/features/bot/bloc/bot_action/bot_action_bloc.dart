import 'package:discord/discord.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:snitch/features/bot/models/bot_model.dart';
import 'package:snitch/features/bot/repositories/bot_local_repository.dart';

part 'bot_action_event.dart';
part 'bot_action_state.dart';

class BotActionBloc extends Bloc<BotActionEvent, BotActionState> {


  BotActionBloc({ required this.repository }) : super(const BotActionInitial()) {
    on<BotActionCreateEvent>(_onCreate);
    on<BotActionUpdateEvent>(_onUpdate);
    on<BotActionDeleteEvent>(_onDelete);
    on<BotActionInitialEvent>(_onInitial);
  }


  final BotLocalRepository repository;
  final _discord = const DiscordValidate();


  void _onInitial(BotActionInitialEvent event, Emitter<BotActionState> emit) async {
    emit(const BotActionInitial());
  }


  void _onCreate(BotActionCreateEvent event, Emitter<BotActionState> emit) async {

    try {
      emit(BotActionLoading());

      final checkResult = await _discord.checkToken(event.bot.token);

      if (checkResult is! DiscordTokenSuccessStatus) {
        throw checkResult.message;
      }

      final duplicate = await repository.hasToken(event.bot.token, event.bot.id);

      if (duplicate.isLeft) {
        throw 'Token already exists';
      }

      final result = await repository.create(event.bot);

      result.fold(
        (l) => throw l,
        (bot) => emit(BotActionSuccess(bot: bot))
      );

    } catch (e) {
      emit(BotActionError(message: e.toString()));
    }
  }


  void _onUpdate(BotActionUpdateEvent event, Emitter<BotActionState> emit) async {
    try {
      emit(BotActionLoading());

      final checkResult = await _discord.checkToken(event.bot.token);

      if (checkResult is! DiscordTokenSuccessStatus) {
        throw checkResult.message;
      }

      final duplicate = await repository.hasToken(event.bot.token, event.bot.id);

      if (duplicate.isLeft) {
        throw 'This token already in use by another bot';
      }

      final result = await repository.update(event.bot);

      result.fold(
        (l) => throw l,
        (bot) => emit(BotActionSuccess(bot: bot))
      );


    } catch (e) {
      emit(BotActionError(message: e.toString()));
    }
  }


  void _onDelete(BotActionDeleteEvent event, Emitter<BotActionState> emit) async {
    try {
      emit(BotActionLoading());

      final result = await repository.delete(event.id);

      result.fold(
        (l) => throw l,
        (result) => BotActionDeleted(result)
      );

    } catch (e) {
      emit(BotActionError(message: e.toString()));
    }
  }

}
