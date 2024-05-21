import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/core/themes/theme.dart';

class ThemeCubit extends Cubit<SnitchThemeType> {

  ThemeCubit() : super(SnitchThemeType.DARK);

  void toggleTheme() {
    emit(state == SnitchThemeType.LIGHT ? SnitchThemeType.DARK : SnitchThemeType.LIGHT);
  }

  void setTheme(SnitchThemeType theme) {
    if (state != theme) {
      emit(theme);
    }
  }

}
