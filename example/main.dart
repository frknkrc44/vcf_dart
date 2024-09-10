import 'package:vcf_dart/vcf_dart.dart';

const localStr = """BEGIN:VCARD
VERSION:3.0
N:;Ram;;;
TEL;TYPE=CELL:+911231231234
PHOTO:https://lh3.googleusercontent.com/contacts/AG6tpzFfv2vRgrTeT1BTaF5v-j
\\:USXTHkD4evejsZjjR5rATQjI0VPUzo
CATEGORIES:myContacts
END:VCARD
""";

void main() {
  final stack = VCardStack.fromData(localStr);
  print(stack.vcardStack);
}
