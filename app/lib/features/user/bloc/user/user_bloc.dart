import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snitch/features/user/repository/user_local_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  UserBloc({required this.repository}) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<UserCheckConfig>(_checkConfig);
  }


  final UserLocalRepository repository;


  Future<void> _checkConfig(event, emit) async {

    try {

      final configs = await repository.getConfigs();

      if (configs == null) {
        throw Exception('Configs not found');
      }

      emit(UserConfigsGood());
    }
    catch (e) {
      emit(UserConfigsBad());
    }

  }


}
