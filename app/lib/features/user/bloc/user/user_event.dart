part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}


class UserGood extends UserEvent {
  const UserGood();
  @override
  List<Object> get props => [];
}


class UserBad extends UserEvent {
  const UserBad();
  @override
  List<Object> get props => [];
}
