part of 'user_bloc.dart';

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserConfigsGood extends UserState { }

class UserConfigsBad extends UserState { }