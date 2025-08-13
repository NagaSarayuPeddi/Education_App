//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This variable will store the user's name
  static String userName = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduApp',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();

  void _login() {
    if (_nameController.text.isNotEmpty) {
      MyApp.userName = _nameController.text;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter your name:', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Your name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> sections = ['Courses', 'Assignments'];
  final List<IconData> icons = [Icons.book, Icons.assignment];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Hello, ${MyApp.userName}!')),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              children: [
                Row(children: [
                  Icon(icons[index]),
                  SizedBox(width:8),
                  Text(sections[index], style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,)
                  ),
                ],),
                Course(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Course extends StatelessWidget {
  const Course({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primary,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        //child: Text(pair.asLowerCase, style: style, semanticsLabel: pair.asPascalCase,),
        child: Column(
          children: [
            Text('Course Name', style: theme.textTheme.bodyMedium),
            ElevatedButton(
              onPressed: () {print('Start button pressed — function not implemented yet');},
              child: Text('Start'),
            )
          ],
        )
      ),
    );
  }
}

