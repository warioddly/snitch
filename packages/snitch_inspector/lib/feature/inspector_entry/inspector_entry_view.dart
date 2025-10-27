import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch_inspector/feature/inspector_entry/inspector_entry_view_model.dart';

class InspectorEntryView extends StatefulWidget {
  const InspectorEntryView({super.key});

  @override
  State<InspectorEntryView> createState() => _InspectorEntryViewState();
}

class _InspectorEntryViewState extends State<InspectorEntryView> {
  final vm = InspectorEntryViewModel();

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8.0,
            children: [
              TextField(
                controller: vm.urlController,
                decoration: const InputDecoration(
                  labelText: 'Enter Snitch Server URL',
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  if (vm.isSaving) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Saving...'),
                        ),
                      );
                    return;
                  }
                  await vm.save();
                  if (context.mounted) {
                    Navigator.pushNamed(context, '/inspector');
                  }
                },
                child: ListenableBuilder(
                  listenable: vm,
                  builder: (context, child) {
                    if (vm.isSaving) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    return child!;
                  },
                  child: const Text('Enter Snitch Inspector'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
