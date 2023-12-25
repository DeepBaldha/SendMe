import 'package:first_project/data/user_info.dart';
import 'package:first_project/entities/regular_expression.dart';
import 'package:first_project/auth_screen/register_page.dart';
import 'package:first_project/widgets/auth_widgets.dart';
import 'package:first_project/screens/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String email;
  late String password;
  bool valid = true;
  final _formKey = GlobalKey<FormState>();

  Future<void> getUser() async {
    String uri = 'http://192.168.1.4/SendMe/user_login.php';
    try {
      var res = await http.post(Uri.parse(uri), body: {
        'email': email,
        'password': password,
      });
      var response = jsonDecode(res.body);
      if (!mounted) return;
      if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No User Found"),
        ));
      } else {
        UserData userData =
            UserData(email, response['name'], response['phone']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      userData: userData,
                    )));
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
                            height: height * 0.38,
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
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.075,
                                          right: width * 0.08),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const RegisterPage()));
                                            },
                                            child: const Text(
                                              'Sign Up??',
                                              style: TextStyle(
                                                  color: Color(0xff3a5372),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const Text('Forget Password',
                                              style: TextStyle(
                                                  color: Color(0xff3a5372),
                                                  fontWeight: FontWeight.bold)),
                                        ],
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
                    getUser();
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
                        'LOGIN',
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
