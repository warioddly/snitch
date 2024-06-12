part of 'user_bloc.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserGood extends UserEvent {
  const UserGood();
}

class UserBad extends UserEvent {
  const UserBad();
}
