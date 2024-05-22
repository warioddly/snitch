part of 'console_bloc.dart';

sealed class ConsoleState extends Equatable {
  const ConsoleState();
}

final class ConsoleInitial extends ConsoleState {
  @override
  List<Object> get props => [];
}

final class ConsoleLoading extends ConsoleState {
  @override
  List<Object> get props => [];
}

