part of 'user_config_bloc.dart';

sealed class UserConfigEvent extends Equatable {
  const UserConfigEvent();
  @override
  List<Object?> get props => [];
}

final class UserConfigReadEvent extends UserConfigEvent { }

final class UserConfigCreateEvent extends UserConfigEvent {
  const UserConfigCreateEvent(this.config);
  final UserConfigModel config;
  @override
  List<Object?> get props => [config];
}

final class UserConfigUpdateEvent extends UserConfigEvent {
  const UserConfigUpdateEvent(this.config);
  final UserConfigModel config;
  @override
  List<Object?> get props => [config];
}
