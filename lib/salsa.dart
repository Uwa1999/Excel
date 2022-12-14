import 'package:encrypt/encrypt.dart' as Keys;

String salsa20(String plainText) {
  final key = Keys.Key.fromLength(32);
  final iv = Keys.IV.fromLength(8);
  final encrypter = Keys.Encrypter(Keys.Salsa20(key));
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final encryptedPassword = encrypted.base64;

  return encryptedPassword;
}

String salsa20Decrypt(String encrypted) {
  final key = Keys.Key.fromLength(32);
  final iv = Keys.IV.fromLength(8);
  final decrypter = Keys.Encrypter(Keys.Salsa20(key));
  final decrypted =
      decrypter.decrypt(Keys.Encrypted.fromBase64(encrypted), iv: iv);

  return decrypted;
}
