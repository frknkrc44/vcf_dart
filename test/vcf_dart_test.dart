/*
 *  This file is part of vcf_dart.
 *
 *  vcf_dart is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  vcf_dart is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *   along with vcf_dart.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:vcf_dart/vcf_dart.dart';
import 'package:test/test.dart';

void main() {
  late VCardStack vCardStack;
  late VCardItemBuilder vCardItemBuilder;
  const localStr = """BEGIN:VCARD
VERSION:3.0
N:User;Test
FN:Test User
EMAIL;TYPE=HOME:test@mail.com
END:VCARD""";

  group('VCard', () {
    test('Create VCardStack', () {
      var ret = true;
      try {
        vCardStack = VCardStack.empty();
      } catch (e) {
        ret = false;
      }

      expect(ret, isTrue);
    });

    test('Create VCardItem', () {
      var ret = true;
      try {
        vCardItemBuilder = VCardItemBuilder()
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
                MapEntry<String, String>(
                  VConstants.nameParamType,
                  VConstants.phoneTypeHome,
                ),
              ],
              values: ['test@mail.com'],
            ),
          );
      } catch (e) {
        ret = false;
      }

      expect(ret, isTrue);
    });

    test('Add VCardItem to VCardStack', () {
      var ret = true;
      try {
        vCardStack.addItem(vCardItemBuilder.build());
      } catch (e) {
        ret = false;
      }

      expect(ret, isTrue);
    });

    test('Compare created VCard', () {
      expect(vCardStack.vcardStack, localStr.replaceAll('\n', '\r\n'));
    });

    test('Create from local string and compare', () {
      bool ret = true;
      late VCardStack newStack;
      try {
        newStack = VCardStack.fromData(localStr);
      } catch (e) {
        ret = false;
      }

      expect(ret, isTrue);
      expect(vCardStack.vcardStack, newStack.vcardStack);
    });
  });
}
