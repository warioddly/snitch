import 'package:flutter/material.dart';

class DynamicCard extends StatefulWidget {
  const DynamicCard({super.key, required this.size, required this.child});

  final Size size;
  final Widget child;

  @override
  State<DynamicCard> createState() => _DynamicCardState();
}

class _DynamicCardState extends State<DynamicCard> {
  late Size size = widget.size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                size = Size(size.width, size.height - details.delta.dy);
              });
            },
            child: Container(
              color: Colors.green,
              height: 20,
              width: double.infinity,
              child: const Center(
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  child: Icon(
                    Icons.drag_handle,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),

          Flexible(
            child: Row(
              children: [
                GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      size = Size(size.width + details.delta.dx, size.height);
                    });
                  },
                  child: Container(
                    color: Colors.green,
                    height: double.infinity,
                    width: 20,
                    child: const Center(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.resizeLeftRight,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.drag_handle,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('Size: ${size.width.toInt()} x ${size.height.toInt()}'),
                  ),
                ),
                GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      size = Size(size.width + details.delta.dx, size.height);
                    });
                  },
                  child: Container(
                    color: Colors.green,
                    height: double.infinity,
                    width: 20,
                    child: const Center(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.resizeLeftRight,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.drag_handle,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                size = Size(size.width, size.height - details.delta.dy);
              });
            },
            child: Container(
              color: Colors.green,
              height: 20,
              width: double.infinity,
              child: const Center(
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  child: Icon(
                    Icons.drag_handle,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
