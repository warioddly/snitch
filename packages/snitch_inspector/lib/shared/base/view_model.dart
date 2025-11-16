import 'package:flutter/cupertino.dart';

abstract class ViewModel extends ChangeNotifier {
  static T of<T extends ViewModel>(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<_ViewModel<T>>();
    if (inherited == null) {
      throw FlutterError(
        'ViewModel.of<$T> called but no ViewModelProvider ancestor was found for type $T.\n'
        'Make sure your widget tree includes a ViewModelProvider<$T> above this context.',
      );
    }
    return inherited.notifier as T;
  }
}

class _ViewModel<T extends ViewModel> extends InheritedNotifier<ViewModel> {
  const _ViewModel({
    super.key,
    required ViewModel viewModel,
    required super.child,
  }) : super(notifier: viewModel);
}

class ViewModelProvider extends StatelessWidget {
  const ViewModelProvider({
    super.key,
    required this.viewModel,
    required this.child,
  });

  final ViewModel viewModel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ViewModel(
      viewModel: viewModel,
      child: child,
    );
  }
}
