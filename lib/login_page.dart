import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = FirebaseFirestore.instance.collection('school');

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? id;
  // final _schoolNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  List<String> schoolname = [];
  String? sname;
  @override
  void dispose() {
    super.dispose();
    // _schoolNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  /*getUsers() {
    List<String> names = [];
    usersRef.get().then((value) {
      final docs = value.docs;
      for (var data in docs) {
        names.add(data.id);
      }
    });
  }*/

  getUsers() {
    // usersRef.get().then((value) {
    //   for (var element in value.docs) {
    //     setState(() {
    //       schoolname.add(element.id);
    //     });
        
    //   }
    // });

    usersRef.get().then((value) {
      for (var element in value.docs) {
        setState(() {
          schoolname.add(element.id);
        });
      }
    });
  }

  // void login() {
  //   usersRef
  //       .doc(id)
  //       .collection(_schoolNameController.text.trim())
  //       .get().then((value) {
  //         for(var element in value.docs){
  //             String id = element.id;
  //         }
  //       });

  // }

  void login() {
    usersRef
        .doc(sname)
        .collection(sname!)
        .where('email', isEqualTo: _emailController.text.trim())
        .where('password', isEqualTo: _passwordController.text.trim())
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        print(element['name']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButton(
                hint: const Text('Please select school'),
                value: sname,
                items: schoolname.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (String? val) {
                  setState(() {
                    sname = val;
                  });
                }),
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
                      login();
                    },
                    child: const Text('Submit')))
          ],
        ),
      ),
    );
  }
}
