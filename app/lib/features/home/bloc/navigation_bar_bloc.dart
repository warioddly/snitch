import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_bar_event.dart';
part 'navigation_bar_state.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, int> {
  NavigationBarBloc() : super(0) {
    on<NavigationBarEvent>((event, emit) {
      if (event is NavigationBarChanged) {
        emit(event.index);
      }
    });
  }
}
