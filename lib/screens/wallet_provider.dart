import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/foundation.dart';
import 'package:web3dart/web3dart.dart';
import 'package:hex/hex.dart';

abstract class WalletAddressService {
  String genrateMnemanic();
  Future<String> getPrivateKey(String mnemanic);
  Future<EthereumAddress> getPublicKey(String privateKey);
}

class WalletProvider extends ChangeNotifier implements WalletAddressService {
  @override
  String genrateMnemanic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemanic) async {
    final seed = bip39.mnemonicToSeed(mnemanic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.address;
    return address;
  }
}
