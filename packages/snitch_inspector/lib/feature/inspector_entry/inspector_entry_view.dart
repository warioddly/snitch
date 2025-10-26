
import 'package:flutter/material.dart';


class InspectorEntryView extends StatelessWidget {
  const InspectorEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0,
          children: [

            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter Snitch Server URL',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Inspector(),
                //   ),
                // );
              },
              child: const Text('Enter Snitch Inspector'),
            )

          ],
        ),
      ),
    );
  }
}

