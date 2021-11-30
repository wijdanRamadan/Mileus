import 'package:flutter/material.dart';

import 'package:mileus/pages/login_page.dart';

void main() async {
  runApp(const MaterialApp(home: Mileus()));
}

class Mileus extends StatelessWidget {
  const Mileus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mileus',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage());
  }
}
