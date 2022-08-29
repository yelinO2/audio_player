import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key, }) : super(key: key);
  

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String name = '';

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return "Username can't be empty";
                  }
                  if (name.length < 4) {
                    return "Username must be at least 4 characters";
                  }
                  return null;
                },
                onChanged: (text) => setState(() {
                  name = text;
                }),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Please enter your username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password_rounded),
                  border: OutlineInputBorder(),
                  labelText: 'Please enter your password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                name.isNotEmpty && name.length >= 4
                    ? Navigator.pushNamed(context, '/player')
                    : null;
              },
              child: const Text('Log in'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
