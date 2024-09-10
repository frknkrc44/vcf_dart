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

VCardProperty get _begin => VCardProperty(
      name: VConstants.begin,
      values: [VConstants.vcard],
    );

VCardProperty get _end => VCardProperty(
      name: VConstants.end,
      values: [VConstants.vcard],
    );

VCardProperty get _vcardV30 => VCardProperty(
      name: VConstants.version,
      values: ['3.0'],
    );

/// Contains VCard lines.
class VCardProperty {
  const VCardProperty({
    required this.name,
    this.nameParameters = const [],
    this.values = const [],
  });

  /// The line name. Example: BEGIN, END, ...
  final String name;

  /// Example: TYPE=HOME
  final List<VCardNameParameter> nameParameters;

  /// Example: +1-123-456-7890
  final List<String> values;

  String? get _itemName =>
      nameParameters.getNameParameterValue(VConstants.nameParamItemName);

  static VCardProperty? _fromLine(String line) {
    var split = line.trim()._splitExtended(VConstants._separatorPair, 1);
    if (split.length < 2) return null;

    var name = split[0].trim().split(VConstants._separatorValue);
    var itemSplit = name[0].split(VConstants._separatorItem);

    var nameExtras = <VCardNameParameter>[];
    if (itemSplit.length > 1) {
      nameExtras.add(MapEntry(VConstants.nameParamItemName, itemSplit.first));
    }

    for (var extra in name.sublist(1)) {
      var split = extra._splitMultiChoice(['=', '#']);

      if (split.length < 2) {
        nameExtras.add(MapEntry(VConstants.nameParamType, split[0]));
      } else {
        nameExtras.add(MapEntry(split[0], split[1]));
      }
    }

    var sep = nameExtras._findValueSeparator(itemSplit.last);
    var value = split[1].trim();
    var values = sep.isEmpty ? [value] : value.split(sep);

    return VCardProperty(
      name: itemSplit.last,
      nameParameters: nameExtras,
      values: values,
    );
  }

  /// Returns all [VConstants.nameParamType] values in a list.
  List<String>? get type => nameParameters
      .subListByNameParameter(VConstants.nameParamType)
      .map<String>((e) => e.value)
      .toList(growable: false);

  @override
  String toString() => jsonEncode({
        'name': name,
        'nameParameters': nameParameters.map((e) => e.toString()).toList(),
        'values': values,
      });

  String _getVCardLine(int majorVersion) {
    var parsedName = name;
    var item = _itemName;
    var nameExtras = [...nameParameters];
    if (item != null) {
      nameExtras.removeAllParametersByName(VConstants.nameParamItemName);
      parsedName = '$item${VConstants._separatorItem}$parsedName';
    }

    var typeValues =
        nameParameters.subListByNameParameter(VConstants.nameParamType);

    String parsedType = '';
    if (typeValues.isNotEmpty) {
      if (majorVersion >= 4) {
        parsedType =
            'TYPE=${typeValues.map<String>((e) => e.value.toLowerCase()).join(VConstants._separatorList)}';
      } else if (majorVersion >= 3) {
        parsedType = typeValues
            .map<String>(
              (e) => 'TYPE=${e.value.toUpperCase()}',
            )
            .join(VConstants._separatorValue);
      } else {
        parsedType = typeValues
            .map<String>(
              (e) => e.value.toUpperCase(),
            )
            .join(VConstants._separatorValue);
      }
    }

    if (parsedType.isNotEmpty) {
      nameExtras.removeAllParametersByName(VConstants.nameParamType);
      nameExtras.add(MapEntry(VConstants.nameParamType, parsedType));
    }

    var out = parsedName;
    for (var i = 0; i < nameExtras.length; i++) {
      var key = nameExtras[i];
      out += VConstants._separatorValue;
      if (key.key == VConstants.nameParamType) {
        out += key.value;
      } else {
        out += '${key.key}=${key.value}';
      }
    }

    out += VConstants._separatorPair;
    out += values.join(nameExtras._findValueSeparator(name));
    return out;
  }
}
