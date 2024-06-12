import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  UserBloc() : super(UserInitial()) {
    on<UserGood>((event, emit) {emit(UserConfigsGood());});
    on<UserBad> ((event, emit) {emit(UserConfigsBad() );});
  }

}
