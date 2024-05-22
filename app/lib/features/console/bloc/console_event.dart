part of 'console_bloc.dart';

sealed class ConsoleEvent extends Equatable {
  const ConsoleEvent();
}

final class ConsoleStarted extends ConsoleEvent {
  @override
  List<Object> get props => [];
}

final class ConsoleStopped extends ConsoleEvent {
  @override
  List<Object> get props => [];
}

final class ConsoleMessageReceived extends ConsoleEvent {
  const ConsoleMessageReceived(this.message);

  final Message message;

  @override
  List<Object> get props => [message];
}

final class ConsoleMessageSent extends ConsoleEvent {
  const ConsoleMessageSent(this.content);

  final String content;

  @override
  List<Object> get props => [content];
}