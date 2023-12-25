import 'package:first_project/screens/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<WalletProvider>(
      create: (context) => WalletProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    return MaterialApp(
      home: Scaffold(
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
              onPressed: () async {
                final mnemanic = walletProvider.genrateMnemanic();
                final privateKey = await walletProvider.getPrivateKey(mnemanic);
                final publicKey = await walletProvider.getPublicKey(privateKey);

                print('Mnemanic : $mnemanic');
                print('privateKey : $privateKey');
                print('publicKey : $publicKey');
              },
              child: const Text('Generate Wallet')),
        ),
      ),
    );
  }
}
