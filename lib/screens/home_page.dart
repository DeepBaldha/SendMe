import 'package:first_project/data/user_info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserData userData;
  const HomePage({super.key, required this.userData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: const Icon(
          size: 34,
          Icons.arrow_back_ios_sharp,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              /*Navigator.push(context, MaterialPageRoute(builder: (context)=> ));*/
            },
            child: const Text('Generate Wallet')),
      ),
    );
  }
}
