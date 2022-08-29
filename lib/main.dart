import 'package:audio_player/screens/music_player.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/screens/login_screen.dart';
import 'package:audio_player/screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUp(),
        '/login': (context) => const Login(),
        '/player': (context) => MusicPlayer(),
      },
    );
  }
}
