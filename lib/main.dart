import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String userName = '';

  const MyApp({super.key});

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = CoursesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.book),
                      label: Text('Courses'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
        MaterialPageRoute(builder: (context) => MyHomePage()),
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

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Hello, ${MyApp.userName}!")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.announcement),
                  SizedBox(width: 8),
                  Text(
                    "Announcements",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Card(
                  color: theme.colorScheme.primary,
                  child: Text(
                    "None right now!", 
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,),
                  )
                ),
              )
            ],
          )
        ),
      )
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

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
              Row(
                children: [
                  Icon(Icons.book),
                  SizedBox(width: 8),
                  Text(
                    "Courses",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Courses(),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseModel {
  final int id;
  String name;

  CourseModel({required this.id, required this.name});
}

class Courses extends StatefulWidget {
  const Courses({super.key});
  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<CourseModel> courses = [];
  int i = 0;

  void _addCourse() {
    setState(() {
      i++;
      courses.add(CourseModel(id: i, name: "Course ${courses.length + 1}"));
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
              final course = courses[index];
              return Course(
                courseName: course.name,
                id: course.id,
                onDelete: () {
                  setState(() {
                    courses.removeAt(index);
                  });
                },
                onRename: (newName) {
                  setState(() {
                    courses[index].name = newName;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class Course extends StatelessWidget {
  final String courseName;
  final int id;
  final VoidCallback onDelete;
  final ValueChanged<String> onRename;

  Course({
    Key? key,
    required this.courseName,
    required this.id,
    required this.onDelete,
    required this.onRename,
  }) : super(key: key);

  void showInputDialog(BuildContext context) {
    final controller = TextEditingController(text: courseName);

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
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onRename(controller.text);
              Navigator.pop(context);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                courseName,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('Start button pressed — function not implemented yet');
                    },
                    child: Text('Start'),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: () => showInputDialog(context),
                    icon: Icon(Icons.edit, color: theme.colorScheme.onPrimary),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, color: theme.colorScheme.onPrimary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}