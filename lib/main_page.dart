import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  String? title;
  Dashboard({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text(title!),
      ),
    );
  }
}
