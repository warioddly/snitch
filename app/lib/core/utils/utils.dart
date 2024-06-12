import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Utils {



  static void pasteToField(TextEditingController controller) {
      Clipboard.getData('text/plain').then((value) => controller.text = value?.text ?? '');
  }

}