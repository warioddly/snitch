part of 'command_bloc.dart';

@immutable
sealed class CommandEvent {
  const CommandEvent();
}

class CommandReadAllEvent extends CommandEvent { }

class CommandCreateEvent extends CommandEvent {
  final String command;
  const CommandCreateEvent(this.command);
}

class CommandUpdateEvent extends CommandEvent {
  final CommandModel command;
  const CommandUpdateEvent(this.command);
}

class CommandDeleteEvent extends CommandEvent {
  final int id;
  const CommandDeleteEvent(this.id);
}