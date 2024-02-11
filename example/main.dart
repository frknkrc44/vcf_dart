import 'package:vcf_dart/vcf_dart.dart';

const localStr = """BEGIN:VCARD
VERSION:3.0
N:User;Test
FN:Test User
EMAIL;TYPE=HOME:test@mail.com
END:VCARD""";

void main() {
  final stack = VCardStack.fromData(localStr);
  print(stack.vcardStack);
}
