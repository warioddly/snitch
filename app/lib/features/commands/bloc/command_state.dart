part of 'command_bloc.dart';

@immutable
sealed class CommandState {
  const CommandState();
}

final class CommandInitial extends CommandState {}

final class CommandLoading extends CommandState {}

final class CommandEmpty extends CommandState { }

final class CommandDeleteSuccess extends CommandState { }

final class CommandReadAllSuccess extends CommandState {
  final List<CommandModel> commands;
  const CommandReadAllSuccess(this.commands);
}


final class CommandError extends CommandState {
  final String message;
  const CommandError(this.message);
}

final class CommandCreateSuccess extends CommandState {
  final CommandModel command;
  const CommandCreateSuccess(this.command);
}

final class CommandUpdateSuccess extends CommandState {
  final CommandModel command;
  const CommandUpdateSuccess(this.command);
}


