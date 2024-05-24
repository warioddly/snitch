part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserConfigsGood extends UserState {
  @override
  List<Object> get props => [];
}

class UserConfigsBad extends UserState {
  @override
  List<Object> get props => [];
}