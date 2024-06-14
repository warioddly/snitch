import 'package:flutter/material.dart' show BuildContext, Navigator, RoutePredicate;





extension NavigatorExtenstion on BuildContext {

  void go(String route, { Object? arguments }) {
    Navigator.pushNamed(this, route, arguments: arguments);
  }

  Future<bool> goBack<T extends Object?>([ T? result ]) async {
    return await Navigator.maybePop(this, result);
  }

  void goBackUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  bool canGoBack() {
    return Navigator.of(this).canPop();
  }

}