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