import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

/// Entrypoint of the application.
void main() {
  runApp(const MyApp());
}

/// [Widget] building the [MaterialApp].
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Dock(
            items: [
              Icons.person,
              Icons.message,
              Icons.call,
              Icons.camera,
              Icons.photo,
            ],
          ),
        ),
      ),
    );
  }


}

/// Dock of the reorderable [items].
class Dock<T> extends StatefulWidget {
  const Dock({
    super.key,
    this.items = const [],
  });

  /// Initial [T] items to put in this [Dock].
  final List<T> items;

  @override
  State<Dock<T>> createState() => _DockState<T>();
}

class _DockState<T> extends State<Dock<T>> {
  /// [T] items being manipulated.
  late final List<T> _items = widget.items.toList();
  late final List<Widget> items;

  @override
  void initState() {
    items = _items.map((icon) => dockItem(icon)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(4),
      child: SingleChildScrollView(
        child: ReorderableWrap(
          children: items,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              final Widget item = items.removeAt(oldIndex);
              items.insert(newIndex, item);
            });
          },
        ),
      )
    );
  }

  Widget dockItem(icon){
  return Container(
    width: 48,
    height: 48,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.primaries[icon.hashCode % Colors.primaries.length],
    ),
    child: Center(
      child: Icon(icon, color: Colors.white)),
    );
  }
}
