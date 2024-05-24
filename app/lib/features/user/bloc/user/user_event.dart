part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserCheckConfig extends UserEvent {
  const UserCheckConfig();
  @override
  List<Object> get props => [];
}