import 'package:first_project/entities/regular_expression.dart';
import 'package:first_project/auth_screen/login_page.dart';
import 'package:first_project/widgets/auth_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String name;
  late String phone;
  late String email;
  late String password;
  bool valid = true;
  final _formKey = GlobalKey<FormState>();

  Future<void> makeUser() async {
    try {
      String uri = 'http://192.168.1.4/SendMe/user_registration.php';
      var res = await http.post(Uri.parse(uri), body: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      });
      var response = jsonDecode(res.body);
      if (response['success'] == 'true') {
        if (!mounted) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final double circleRadius = width * 0.4;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffc9878b), Color(0xff215297)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 2),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: circleRadius / 2.0,
                          ),
                          child: Container(
                            height: height * 0.55,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xffdcc0cc), Color(0xffa1b2ce)],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xffc0b9cb),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xff3a5791),
                                  blurRadius: 8.0,
                                  offset: Offset(0.0, 5.0),
                                ),
                              ],
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: circleRadius / 2,
                                    ),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          MyTextField(
                                            width: width,
                                            icon: Icons.person,
                                            hintText: 'Enter name',
                                            validator: (val) {
                                              if (!val!.isValidName) {
                                                valid = false;
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text("Not Valid name"),
                                                ));
                                              } else {
                                                valid = true;
                                              }
                                              return null;
                                            },
                                            onSave: () {
                                              name = _nameController.text;
                                            },
                                            controller: _nameController,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MyTextField(
                                            width: width,
                                            icon: Icons.phone,
                                            hintText: 'Enter phone No.',
                                            validator: (val) {
                                              if (!val!.isValidPhone) {
                                                valid = false;
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text("Not Valid Phone"),
                                                ));
                                              } else {
                                                valid = true;
                                              }
                                              return null;
                                            },
                                            onSave: () {
                                              phone = _phoneController.text;
                                            },
                                            controller: _phoneController,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MyTextField(
                                            width: width,
                                            icon: Icons.email,
                                            hintText: 'Enter email',
                                            validator: (val) {
                                              if (!val!.isValidEmail) {
                                                valid = false;
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text("Not Valid Email"),
                                                ));
                                              } else {
                                                valid = true;
                                              }
                                              return null;
                                            },
                                            onSave: () {
                                              email = _emailController.text;
                                            },
                                            controller: _emailController,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MyTextField(
                                            width: width,
                                            icon: Icons.lock,
                                            hintText: 'Enter password',
                                            validator: (val) {
                                              if (!val!.isValidPassword) {
                                                valid = false;
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Not Strong Password"),
                                                ));
                                              } else {
                                                valid = true;
                                              }
                                              return null;
                                            },
                                            onSave: () {
                                              password =
                                                  _passwordController.text;
                                            },
                                            controller: _passwordController,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      },
                                      child: const Text(
                                        'Already Sign Up? LOGIN',
                                        style: TextStyle(
                                            color: Color(0xff3a5372),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        Container(
                          width: circleRadius,
                          height: circleRadius,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff00264d),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8.0,
                                offset: Offset(0.0, 5.0),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Center(
                              child: Icon(
                                Icons.person_2_outlined,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate() && valid) {
                      _nameController.text = '';
                      _passwordController.text = '';
                      _emailController.text = '';
                      _phoneController.text = '';
                      makeUser();
                    }
                  },
                  child: Container(
                    height: height * 0.05,
                    width: width * 0.65,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xffdcc0cc), Color(0xffa1b2ce)],
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color(0xffc0b9cb),
                    ),
                    child: const Center(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
