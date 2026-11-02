import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Adminmodel.dart';
import 'package:flutter_application_1/model/Usermodel.dart';
import 'package:flutter_application_1/model/authmodel.dart';

import 'package:flutter_application_1/service/FireService.dart';
import 'package:flutter_application_1/service/FireServiceAuth.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final namecnt = TextEditingController();
  final email = TextEditingController();
  final passwordcnt = TextEditingController();
  final cpassword = TextEditingController();

  int selectRole = 0;
  // int value = 0;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEBDA),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Join our modern institutional catalog',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 24),
                Text(
                  'SELECT ROLE',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectRole = 1;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectRole == 1
                                  ? const Color.fromARGB(255, 7, 32, 77)
                                  : Colors.white,
                              width: 2,
                            ),
                            color: const Color.fromARGB(255, 246, 229, 177),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 16),
                                  Icon(Icons.school_outlined, size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    'User',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 7, 32, 77),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectRole = 2;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectRole == 2
                                  ? const Color.fromARGB(255, 7, 32, 77)
                                  : Colors.white,
                              width: 2,
                            ),
                            color: const Color.fromARGB(255, 246, 229, 177),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 16),
                                  Icon(Icons.admin_panel_settings, size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    ' Admin',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 7, 32, 77),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Text(
                  'FULL NAME',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 6),
                TextField(
                  controller: namecnt,
                  decoration: InputDecoration(
                    hintText: 'John Doe',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'EMAIL ADDRESS',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 6),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'name@institution.edu',
                    prefixIcon: Icon(Icons.mail_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'PASSWORD',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 6),
                TextField(
                  controller: passwordcnt,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Min. 6 characters',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'CONFIRM PASSWORD',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 6),
                TextField(
                  controller: cpassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Repeat password',
                    prefixIcon: Icon(Icons.verified_user_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                InkWell(
                  onTap: () async {
                    try {
                      if (selectRole == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please select your Role")),
                        );
                      }
                      final user = await FireserviceA().Registeruser(
                        AuthModel(
                          email: email.text,
                          password: passwordcnt.text,
                        ),
                      );
                      setState(() {
                        loading = true;
                      });

                      if (user != null && user.user != null) {
                        final uid = user.user!.uid;

                        if (selectRole == 1) {
                          await Fireservice().userdata(
                            UserModel(
                              name: namecnt.text,
                              email: email.text,
                              password: passwordcnt.text,
                              uid: uid,
                            ),
                          );
                        }

                        if (selectRole == 2) {
                          await Fireservice().Admindata(
                            Adminmodel(
                              name: namecnt.text,
                              email: email.text,
                              password: passwordcnt.text,
                              uid: uid,
                            ),
                          );
                        }
                      }

                      Navigator.pop(context);
                      setState(() {
                        loading = false;
                      });
                    } catch (e) {
                      print(e.toString());
                    }
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
                      child: loading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Divider(color: Colors.black, thickness: 1),
                    Text('OR REGISTER WITH'),
                    Divider(color: Colors.black, thickness: 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        " Sign In",
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
    );
  }
}
