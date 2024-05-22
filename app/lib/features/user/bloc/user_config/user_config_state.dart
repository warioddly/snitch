part of 'user_config_bloc.dart';


sealed class UserConfigState extends Equatable {
  const UserConfigState();
}

final class UserConfigInitial extends UserConfigState {
  @override
  List<Object> get props => [];
}


final class UserConfigError extends UserConfigState {
  const UserConfigError(this.message);
  final String message;
  @override
  List<Object> get props => [];
}

final class UserConfigEmpty extends UserConfigState {
  const UserConfigEmpty();
  @override
  List<Object> get props => [];
}

final class UserConfigReaded extends UserConfigState {
  const UserConfigReaded(this.configs);
  final UserConfigModel configs;
  @override
  List<Object> get props => [];
}


final class UserConfigCreating extends UserConfigState {
  const UserConfigCreating();
  @override
  List<Object> get props => [];
}

final class UserConfigCreated extends UserConfigState {
  const UserConfigCreated(this.configs);
  final UserConfigModel configs;
  @override
  List<Object> get props => [];
}

final class UserConfigCreateError extends UserConfigState {
  const UserConfigCreateError(this.message);
  final String message;
  @override
  List<Object> get props => [];
}


final class UserConfigUpdating extends UserConfigState {
  const UserConfigUpdating();
  @override
  List<Object> get props => [];
}

final class UserConfigUpdated extends UserConfigState {
  const UserConfigUpdated(this.configs);
  final UserConfigModel configs;
  @override
  List<Object> get props => [];
}

final class UserConfigUpdateError extends UserConfigState {
  const UserConfigUpdateError(this.message);
  final String message;
  @override
  List<Object> get props => [];
}