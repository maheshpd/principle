import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:principle/login_page.dart';
import 'package:principle/student_login.dart';
import 'package:principle/teacher_login.dart';
import 'package:uuid/uuid.dart';

final usersRef = FirebaseFirestore.instance.collection('school');

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? id;
  final _schoolNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _schoolNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() {
    usersRef.get().then((value) {
      for (var element in value.docs) {
        id = element.id;
      }
    });
  }

  void save() {
    var schoolid = const Uuid().v1();

    final Map<String, dynamic> data = {
      "id": schoolid,
      "name": _schoolNameController.text.trim(),
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim()
    };

    usersRef
        .doc(_schoolNameController.text.trim())
        .collection(_schoolNameController.text.trim())
        .doc(schoolid)
        .set(data);
    usersRef.doc(_schoolNameController.text.trim()).set(data);

    _schoolNameController.text = '';
    _emailController.text = '';
    _passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _schoolNameController,
                  decoration: const InputDecoration(
                    label: Text('School Name'),
                    hintText: 'School Name',
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    hintText: 'Email',
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    hintText: 'Password',
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    save();
                  },
                  child: const Text('Submit'),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text("Already have account? Login")),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StudentPage()));
                  },
                  child: const Text("Student's Login")),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TeacherPage()));
                  },
                  child: const Text("Teacher's Login"))
            ],
          ),
        ),
      ),
    );
  }
}
