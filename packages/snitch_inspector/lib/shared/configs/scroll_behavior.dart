import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class WebScrollBehavior extends CupertinoScrollBehavior {

  const WebScrollBehavior();
  
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
