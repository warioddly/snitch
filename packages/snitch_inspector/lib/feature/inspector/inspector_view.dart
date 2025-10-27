import 'package:flutter/material.dart';
import 'package:snitch_inspector/feature/inspector/inspector_view_model.dart';
import 'package:snitch_inspector/shared/base/view_model.dart';
import 'package:snitch_inspector/shared/ui/layouts/dynamic_card.dart';

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
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    DynamicCard(
                      size: Size(screenSize.width * 0.7, screenSize.height),
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        clipBehavior: Clip.hardEdge,
                        child: ListView.builder(
                          itemCount: vm.logs.length,
                          itemBuilder: (context, index) {
                            final log = vm.logs[index];
                            return ListTile(
                              title: Text(log.message),
                              subtitle: Text(
                                log.timestamp.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                              leading: Card(
                                color: Colors.grey[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                margin: EdgeInsets.zero,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    log.level.name,
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              style: ListTileStyle.drawer,
                              onTap: () {
                                // Handle log tap
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: DynamicCard(
                        size: Size(screenSize.width * 0.3, screenSize.height),
                        child: ListView.builder(
                          itemCount: vm.logs.length,
                          itemBuilder: (context, index) {
                            return Text(vm.logs[index].message);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DynamicCard(
                size: Size(screenSize.width, screenSize.height * 0.3),
                child: ListView.builder(
                  itemCount: vm.logs.length,
                  itemBuilder: (context, index) {
                    return Text(vm.logs[index].message);
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
            // FloatingActionButton(
            //   onPressed: vm.getLogs,
            //   child: const Icon(Icons.http),
            // ),
            // FloatingActionButton(
            //   onPressed: vm.getSocketLogs,
            //   child: const Icon(Icons.send),
            // ),
          ],
        ),
      ),
    );
  }
}
