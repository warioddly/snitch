import 'package:flutter/cupertino.dart';

abstract class ViewModel extends ChangeNotifier {
  static T of<T extends ViewModel>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ViewModel<T>>()!.viewModel;
  }
}

class _ViewModel<T extends ViewModel> extends InheritedNotifier<ViewModel> {
  const _ViewModel({
    super.key,
    required this.viewModel,
    required super.child,
  }) : super(notifier: viewModel);

  final T viewModel;
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
