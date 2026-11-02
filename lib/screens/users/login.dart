import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/authmodel.dart';

import 'package:flutter_application_1/screens/users/registerpage.dart';
import 'package:flutter_application_1/screens/users/spalshscreen.dart';

import 'package:flutter_application_1/service/FireServiceAuth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEBDA),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Please enter your credentials to access the library portal',
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(height: 30),

                  SizedBox(height: 20),
                  Text(
                    'Email Address',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      hint: Row(
                        children: [
                          Center(child: Icon(Icons.email, color: Colors.grey)),
                          Text(
                            ' Name@gmail.com',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        'Forget',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 32, 77),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.visibility),
                      hint: Row(
                        children: [
                          Center(child: Icon(Icons.lock, color: Colors.grey)),
                          Text(
                            ' *********',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                  InkWell(
                    onTap: () async {
                      if (username.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter the Username')),
                        );
                      }
                      if (password.text.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Weak password')),
                        );
                      }
                      if (password.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Password was empty")),
                        );
                      }
                      setState(() {
                        loading = true;
                      });
                      final user = await FireserviceA().logUser(
                        AuthModel(
                          email: username.text.trim(),
                          password: password.text.trim(),
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Authgate()),
                        (route) => false,
                      );

                      setState(() {
                        loading = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        // color: Color(0xFF4F6F5A),
                        color: const Color.fromARGB(255, 7, 32, 77),
                      ),
                      child: Center(
                        child: loading == false
                            ? Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
                              )
                            : CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New to Library Pro?",
                        style: TextStyle(color: Colors.black38),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registerpage(),
                            ),
                          );
                        },
                        child: Text(
                          " Create Account",
                          style: TextStyle(
                            color: Color.fromARGB(255, 7, 32, 77),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
