# VCF Dart

## Features

This library supports create and parse VCard files.

## Tested versions

- 2.1
- 3.0
- 4.0

## Getting started

Add this package to your dependency list:

```bash
dart pub add vcf_dart
```

Include into your project:

```dart
import 'package:vcf_dart/vcf_dart.dart';
```

## Usage

Parse the existing VCard file and print its content:

```dart
const localStr = """BEGIN:VCARD
VERSION:3.0
N:User;Test
FN:Test User
EMAIL;TYPE=HOME:test@mail.com
END:VCARD""";

final stack = VCardStack.fromData(localStr);
print(stack.vcardStack);
```

Create an empty VCard stack and add a VCard element:

```dart
final stack = VCardStack();
final builder = VCardItemBuilder()
  ..addProperty(
    const VCardProperty(
      name: VConstants.name,
      values: ['User', 'Test'],
    ),
  )
  ..addPropertyFromEntry(
    VConstants.formattedName,
    'Test User',
  )
  ..addProperty(
    const VCardProperty(
      name: VConstants.email,
      nameParameters: [
        VCardNameParameter(
          VConstants.nameParamType,
          VConstants.phoneTypeHome,
        ),
      ],
      values: ['test@mail.com'],
    ),
  );
stack.items.add(builder.build());
```

## TODO

- AGENT type support
- Add more checks for invalid VCF files
- Add more tests and examples
- And more...
