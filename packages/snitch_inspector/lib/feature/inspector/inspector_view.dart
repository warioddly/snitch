import 'package:flutter/material.dart';
import 'package:snitch_inspector/feature/inspector/inspector_view_model.dart';
import 'package:snitch_inspector/shared/base/view_model.dart';
import 'package:snitch_inspector/shared/ui/layouts/dynamic_card.dart';
import 'package:snitch_interface/snitch_interface.dart';

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
    final screenSize = MediaQuery.sizeOf(context);
    return ViewModelProvider(
      viewModel: vm,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Inspector'),
          forceMaterialTransparency: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(8.0),
                clipBehavior: Clip.hardEdge,
                child: ListView.builder(
                  itemCount: vm.logs.length,
                  itemBuilder: (context, index) {
                    final log = vm.logs[index];
                    return ListTile(
                      title: Text(log.message),
                      leading: Text(
                        '[${DateTime.fromMillisecondsSinceEpoch(log.timestamp)}] ${log.level.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        vm.selectLog(vm.logs[index]);
                      },
                    );
                  },
                ),
              ),
            ),
            ListenableBuilder(
              listenable: vm,
              builder: (context, _) {
                final selectedLog = vm.selectedLog;
                if (selectedLog == null) {
                  return const SizedBox.shrink();
                }
                return DynamicCard(
                  size: Size(
                    screenSize.width,
                    screenSize.height * 0.4,
                  ),
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    clipBehavior: Clip.hardEdge,
                    child: LogExpandedView(log: selectedLog),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LogExpandedView extends StatelessWidget {
  const LogExpandedView({super.key, required this.log});

  final Log log;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Details'),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.close),
          //   onPressed: () {
          //     vm.selectLog(null);
          //   },
          // ),

          // share
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share.share(log.toString());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectableText(
              '[${DateTime.fromMillisecondsSinceEpoch(log.timestamp)}] ${log.level.name}: ${log.message}',
            ),

            SelectableText(
              'Error: ${log.error}'
              '\nStacktrace: ${log.stackTrace}',
            ),
          ],
        ),
      ),
    );
  }
}
