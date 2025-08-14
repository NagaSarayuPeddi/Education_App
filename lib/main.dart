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
  //final List<String> sections = ['Courses', 'Assignments'];
  //final List<IconData> icons = [Icons.book, Icons.assignment];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Hello, ${MyApp.userName}!')),
      body: SingleChildScrollView(
        child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                children: [
                  Row(children: [
                    Icon(Icons.book),
                    SizedBox(width:8),
                    Text("Courses", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,)
                    ),
                  ],),
                  SizedBox(height: 10,),
                  Courses(),
                  //ElevatedButton(onPressed: onPressed, child: child)
                ],
              ),
            ),
      )
      
    );
  }
}

class Courses extends StatefulWidget{
  const Courses({super.key});
  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<Course> courses = [Course(courseName: "SAT Math",)];

  void _addCourse(){
    setState(() {
      courses.add(Course(courseName: "Course ${courses.length + 1}",));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _addCourse,
          child: Text('Add Course'),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return courses[index];
            },
          ),
        ),
      ],
    );
  }
}

class Course extends StatefulWidget {
  String courseName;

  Course({Key? key, required this.courseName}) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  //var courseName = "Course Name";

  void showInputDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Name'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter new course name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.courseName = controller.text;
              });
              Navigator.pop(context); // Close dialog
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: theme.colorScheme.primary,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(20),
          //child: Text(pair.asLowerCase, style: style, semanticsLabel: pair.asPascalCase,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.courseName, 
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onPrimary, 
                  fontWeight: FontWeight.bold),),
              SizedBox(height:10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {print('Start button pressed — function not implemented yet');},
                    child:
                      Text('Start'),
                  ),
                  SizedBox(width:5),
                  IconButton(onPressed: () => showInputDialog(context), icon: Icon(Icons.edit, color: theme.colorScheme.onPrimary,))
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}

