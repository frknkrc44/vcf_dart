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

part of '../vcf_dart.dart';

/// Stores multiple [VCardItem] types
class VCardStack {
  VCardStack._({required List<VCardItem> items}) : _items = items;

  final List<VCardItem> _items;

  /// Create an empty [VCardStack]
  factory VCardStack.empty() => VCardStack._(items: []);

  /// Parse the VCF file
  factory VCardStack.fromData(String data) {
    var items = <VCardItem>[];
    var out = <VCardProperty>[];

    for (var line in data.replaceAll(_newLine, '\n').split('\n')) {
      // skip AGENT lines for now
      if (line.startsWithMultiple([' ', '\t']) &&
          out[out.length - 1].name == VConstants.agent) {
        continue;
      }

      var property = VCardProperty._fromLine(line);

      if (property != null) {
        out.add(property);

        if (property.name == VConstants.end) {
          // delete AGENT line for now
          // TODO: Add agent parser support
          out.removeWhere((element) => element.name == VConstants.agent);

          var propertyList = [...out];
          var vcardItem = VCardItemBuilder(properties: propertyList).build();
          items.add(vcardItem);
          out.clear();
        }
      }
    }

    return VCardStack._(items: items);
  }

  /// Add a [VCardItem].
  void addItem(VCardItem item) => _items.add(item);

  /// Add multiple [VCardItem]s.
  void addAllItems(List<VCardItem> addedItems) => _items.addAll(addedItems);

  /// Remove a [VCardItem].
  bool removeItem(VCardItem item) => _items.remove(item);

  /// Remove a [VCardItem] at [index].
  VCardItem removeItemAt(int index) => _items.removeAt(index);

  /// Clear the [VCardItem] list.
  void clear() => _items.clear();

  @override
  String toString() =>
      _items.map((e) => e.toString()).toList(growable: false).toString();

  /// Create a VCF output from [VCardStack].
  String get vcardStack => _items.map((e) => e.vcard).join(
        '$_newLine$_newLine',
      );
}
