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

/// The main [VCardItem] class.
class VCardItem {
  const VCardItem._({required this.lines});

  final List<VCardProperty> lines;

  /// Get the major version number.
  int get majorVersion =>
      int.parse(version.split(VConstants._separatorItem)[0]);

  /// Get the version number.
  /// Returns the fallback version number if not found.
  String get version {
    var property = findFirstProperty(VConstants.version);

    if (property == null) {
      return _vcardV30.values.first;
    }

    return property.values.first;
  }

  /// Whether the vCard file is valid.
  bool get isValid {
    var beginIndex = lines.indexWhere((e) => e.name == VConstants.begin);
    var versionIndex = lines.indexWhere((e) => e.name == VConstants.version);
    var endIndex = lines.indexWhere((e) => e.name == VConstants.end);

    // A VCard must start with the [VConstants.begin] tag.
    return beginIndex == 0 &&

        // A VCard's [VConstants.begin] tag must contain [VConstants.vcard].
        lines[beginIndex].values.length == 1 &&
        lines[beginIndex].values.first == VConstants.vcard &&

        // don't hardcode the version number index to 1 - VCard 2.1.
        versionIndex > 0 &&

        // A VCard's [VConstants.version] tag must contain a valid version.
        lines[versionIndex].values.length == 1 &&
        [2, 3, 4].contains(majorVersion) &&

        // A VCard must end with the END tag.
        endIndex == lines.length - 1 &&

        // A VCard's [VConstants.end] tag must contain [VConstants.vcard].
        lines[beginIndex].values.length == 1 &&
        lines[beginIndex].values.first == VConstants.vcard &&

        // A VCard cannot contain multiple [VConstants.begin], [VConstants.version] or [VConstants.end] tag.
        findProperties(VConstants.begin).length == 1 &&
        findProperties(VConstants.version).length == 1 &&
        findProperties(VConstants.end).length == 1;
  }

  /// Find all properties by [name].
  ///
  /// Example:
  /// ```dart
  /// var names = vcardItem.findProperties(VConstants.name);
  /// ```
  List<VCardProperty> findProperties(String name) =>
      lines.where((e) => e.name == name).toList();

  /// Find a property by [name].
  ///
  /// Example:
  /// ```dart
  /// var name = vcardItem.findFirstProperty(VConstants.name);
  /// ```
  VCardProperty? findFirstProperty(String name) {
    var idx = lines.indexWhere((e) => e.name == name);
    return idx < 0 ? null : lines[idx];
  }

  @override
  String toString() =>
      lines.map((e) => e.toString()).toList(growable: false).toString();

  /// Create a VCF output from [VCardItem].
  String get vcard => lines
      .map(
        (e) => e._getVCardLine(majorVersion),
      )
      .join(_newLine);
}

/// The builder class to build [VCardItem] objects securely.
class VCardItemBuilder {
  VCardItemBuilder({
    List<VCardProperty> properties = const [],
  }) {
    _properties.addAll(properties);
  }

  final _properties = <VCardProperty>[];

  List<VCardProperty> _findProperties(String name) =>
      _properties.where((e) => e.name == name).toList();

  /// Add a new property for [VCardItem].
  void addProperty(VCardProperty property) {
    _properties.add(property);
  }

  /// Add a new property for [VCardItem] by using [key] and [value].
  void addPropertyFromEntry(String key, String? value) {
    if (value != null) {
      _properties.add(VCardProperty(name: key, values: [value]));
    }
  }

  /// Build a new [VCardItem] from [VCardItemBuilder].
  VCardItem build() {
    if (_findProperties(VConstants.begin).isEmpty) {
      _properties.insert(0, _begin);
    }

    if (_findProperties(VConstants.version).isEmpty) {
      _properties.insert(1, _vcardV30);
    }

    if (_findProperties(VConstants.end).isEmpty) {
      _properties.add(_end);
    }

    var ret = VCardItem._(lines: _properties);

    /// Throw an exception if it's not valid
    assert(ret.isValid);

    return ret;
  }
}
