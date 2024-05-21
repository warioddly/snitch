part of 'navigation_bar_bloc.dart';

@immutable
sealed class NavigationBarEvent {}

final class NavigationBarChanged extends NavigationBarEvent {
  final int index;

  NavigationBarChanged(this.index);
}
