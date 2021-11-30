import 'dart:math';

String createPassword() {
  var randomizer = Random();
  return (100000 + randomizer.nextInt(8999999)).toString();
}
