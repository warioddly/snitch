part of 'navigation_bar_bloc.dart';

sealed class NavigationBarEvent {
  const NavigationBarEvent();
}

final class NavigationBarChanged extends NavigationBarEvent {
  final int index;
  const NavigationBarChanged(this.index);
}
