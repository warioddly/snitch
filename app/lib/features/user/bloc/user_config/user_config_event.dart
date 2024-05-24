part of 'user_config_bloc.dart';

sealed class UserConfigEvent extends Equatable {
  const UserConfigEvent();
}

final class UserConfigReadEvent extends UserConfigEvent {
  const UserConfigReadEvent();
  @override
  List<Object?> get props => [];
}

final class UserConfigCreateEvent extends UserConfigEvent {
  const UserConfigCreateEvent(this.config);
  final UserConfigModel config;
  @override
  List<Object?> get props => [];
}
