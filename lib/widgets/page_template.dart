import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const PageTemplate({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: actions,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
