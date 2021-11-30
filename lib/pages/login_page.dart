import 'package:flutter/material.dart';
import 'package:mileus/helper_functions.dart';
import 'package:mileus/pages/map_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String password = createPassword();
  TextEditingController passwordctr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordctr,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: const Text('login'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (passwordctr.text == password) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapPage()),
                              );
                            }
                          }
                        },
                      ),
                      ElevatedButton(
                        child: const Text('new password'),
                        onPressed: () {
                          setState(() {
                            password = createPassword();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('your password is : $password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
