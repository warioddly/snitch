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
  final discordValidator = const DiscordValidate();


  void _onInitial(BotActionInitialEvent event, Emitter<BotActionState> emit) async {
    emit(const BotActionInitial());
  }


  void _onCreate(BotActionCreateEvent event, Emitter<BotActionState> emit) async {

    try {
      emit(BotActionLoading());

      final result = await discordValidator.checkToken(event.bot.token);

      if (result is! DiscordTokenSuccessStatus) {
        throw result.message;
      }

      if (await repository.hasToken(event.bot.token)) {
        throw 'Token already exists';
      }

      final bot = await repository.create(event.bot);

      emit(BotActionSuccess(bot: bot));
    } catch (e) {
      emit(BotActionError(message: e.toString()));
    }
  }


  void _onUpdate(BotActionUpdateEvent event, Emitter<BotActionState> emit) async {
    try {
      emit(BotActionLoading());

      final result = await discordValidator.checkToken(event.bot.token);

      if (result is! DiscordTokenSuccessStatus) {
        throw result.message;
      }


      if (await repository.hasToken(event.bot.token, event.bot.id)) {
        throw 'This token already in use by another bot';
      }


      final bot = await repository.update(event.bot);
      emit(BotActionSuccess(bot: bot));
    } catch (e) {
      emit(BotActionError(message: e.toString()));
    }
  }


  void _onDelete(BotActionDeleteEvent event, Emitter<BotActionState> emit) async {
    try {
      emit(BotActionLoading());

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
