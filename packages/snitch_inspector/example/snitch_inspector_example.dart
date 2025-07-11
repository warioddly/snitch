import 'package:snitch/snitch.dart';
import 'package:snitch_inspector/snitch_inspector.dart';

void main() {
  final snitch = Snitch();

  snitch
    ..t("message")
    ..i("info")
    ..w("warning")
    ..e("error")
    ..d("debug")
    ..v("verbose");

  var inspector = SnitchInspector(snitch: snitch);

  inspector.serve();

  // inspector.close();
}
