import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'console_event.dart';
part 'console_state.dart';

class ConsoleBloc extends Bloc<ConsoleEvent, ConsoleState> {

  ConsoleBloc() : super(ConsoleInitial()) {
    on<ConsoleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }


}
