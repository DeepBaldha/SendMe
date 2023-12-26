import 'package:first_project/data/user_info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserData userData;
  const HomePage({super.key, required this.userData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double money = 100;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Wallet Money',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              'Rs.$money',
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Add Money',
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
      ),
    );
  }
}
