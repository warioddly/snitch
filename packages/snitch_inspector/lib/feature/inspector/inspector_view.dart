import 'package:flutter/material.dart';
import 'package:snitch_inspector/feature/inspector/inspector_view_model.dart';
import 'package:snitch_inspector/shared/base/view_model.dart';

class InspectorView extends StatefulWidget {
  const InspectorView({super.key});

  @override
  State<InspectorView> createState() => _InspectorViewState();
}

class _InspectorViewState extends State<InspectorView> {
  final vm = InspectorViewModel();

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: vm,
      child: Scaffold(
        appBar: AppBar(title: Text('Inspector')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: vm.logs.length,
                  itemBuilder: (context, index) {
                    return Text(vm.logs[index]);
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            FloatingActionButton(
              onPressed: vm.getLogs,
              child: const Icon(Icons.http),
            ),
            FloatingActionButton(
              onPressed: vm.getSocketLogs,
              child: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
