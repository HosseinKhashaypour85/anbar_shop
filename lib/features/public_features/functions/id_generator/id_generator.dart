import 'dart:math';

class IdGenerator {
  String idGenerator({int length = 15}) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }
}
