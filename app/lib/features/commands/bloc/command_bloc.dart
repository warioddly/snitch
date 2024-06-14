import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:snitch/features/commands/models/command_model.dart';
import 'package:snitch/features/commands/repositories/command_local_repository.dart';

part 'command_event.dart';
part 'command_state.dart';

class CommandBloc extends Bloc<CommandEvent, CommandState> {

  CommandBloc({ required this.repository }) : super(CommandInitial()) {
    on<CommandReadAllEvent>(_onReadAll);
    on<CommandCreateEvent>(_onCreate);
    on<CommandUpdateEvent>(_onUpdate);
    on<CommandDeleteEvent>(_onDelete);
  }


  final CommandLocalRepository repository;


  void _onReadAll(CommandReadAllEvent event, Emitter<CommandState> emit) async {
    try {

      emit(CommandLoading());

      final result = await repository.readAll();

      result.fold(
        (l) => throw l,
        (commands) => commands.isEmpty ? emit(CommandEmpty()) : emit(CommandReadAllSuccess(commands))
      );

    } catch (e) {
      emit(CommandError(e.toString()));
    }
  }


  void _onCreate(CommandCreateEvent event, Emitter<CommandState> emit) async {
    try {
      emit(CommandLoading());

      final command = CommandModel(command: event.command);

      final duplicate = await repository.search(event.command);

      duplicate.fold(
        (l) => throw l,
        (commands) {
          if (commands.isNotEmpty) {
            throw 'Duplicate record';
          }
        }
      );

      final result = await repository.create(command);

      result.fold(
          (l) => throw l,
          (result) => emit(CommandCreateSuccess(result))
      );

    } catch (e) {
      emit(CommandError(e.toString()));
    }
  }


  void _onUpdate(CommandUpdateEvent event, Emitter<CommandState> emit) async {
    try {

      emit(CommandLoading());

      final duplicate = await repository.search(event.command.command);

      if (duplicate.isLeft) {
        emit(const CommandError('Duplicate record'));
        return;
      }

      final result = await repository.update(event.command);

      result.fold(
        (l) => throw l,
        (result) => emit(CommandUpdateSuccess(result))
      );

    } catch (e) {
      emit(CommandError(e.toString()));
    }
  }


  void _onDelete(CommandDeleteEvent event, Emitter<CommandState> emit) async {
    try {

      emit(CommandLoading());

      final result = await repository.delete(event.id);

      result.fold(
        (l) => throw l,
        (result) => result ? emit(CommandDeleteSuccess()) : emit(const CommandError('Record not found'))
      );

    } catch (e) {
      emit(CommandError(e.toString()));
    }
  }


}
