part of 'user_config_bloc.dart';


sealed class UserConfigState extends Equatable {
  const UserConfigState();
  @override
  List<Object> get props => [];
}

final class UserConfigInitial extends UserConfigState { }

final class UserConfigEmpty extends UserConfigState { }

final class UserConfigCreating extends UserConfigState { }

final class UserConfigUpdating extends UserConfigState { }

final class UserConfigReaded extends UserConfigState {
  const UserConfigReaded(this.configs);
  final UserConfigModel configs;
  @override
  List<Object> get props => [configs];
}

final class UserConfigError extends UserConfigState {
  const UserConfigError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}

final class UserConfigCreated extends UserConfigState {
  const UserConfigCreated(this.configs);
  final UserConfigModel configs;
  @override
  List<Object> get props => [configs];
}

final class UserConfigCreateError extends UserConfigState {
  const UserConfigCreateError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}

final class UserConfigUpdated extends UserConfigState {
  const UserConfigUpdated(this.configs);
  final UserConfigModel configs;
  @override
  List<Object> get props => [configs];
}

final class UserConfigUpdateError extends UserConfigState {
  const UserConfigUpdateError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}