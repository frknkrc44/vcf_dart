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

/// Adds some functions to lists/maps for manage your VCard list properly
extension ListMapEntryExtras on List<VCardNameParameter> {
  /// Lists all parameters by name
  List<VCardNameParameter> subListByNameParameter(
    String parameter, {
    int limit = -1,
  }) {
    var out = <VCardNameParameter>[];
    for (var i = 0; i < length; i++) {
      var paramEntry = this[i];
      if (paramEntry.key._equalsIgnoreCase(parameter)) {
        out.add(paramEntry);

        if (limit > 0 && out.length == limit) {
          break;
        }
      }
    }

    return out;
  }

  /// Returns the first parameter by name
  VCardNameParameter? getNameParameter(String parameter, [String? def]) {
    var params = subListByNameParameter(parameter, limit: 1);
    return params.isNotEmpty
        ? params.first
        : def != null
            ? VCardNameParameter(parameter, def)
            : null;
  }

  /// Returns the parameter value by name
  String? getNameParameterValue(String parameter, [String? def]) =>
      getNameParameter(parameter, def)?.value;

  /// Removes all parameters by name
  bool removeAllParametersByName(String name) {
    var items = subListByNameParameter(name);
    removeWhere((e) => items.contains(e));
    return items.isNotEmpty;
  }

  String _findValueSeparator(String parsedName) {
    switch (parsedName) {
      case VConstants.categories:
      case VConstants.nickname:
        return VConstants._separatorList;
    }

    if (getNameParameterValue(VConstants.nameParamType, 'text')!
        .endsWith('-list')) {
      return VConstants._separatorList;
    }

    return VConstants._separatorValue;
  }
}

// Copied from https://pub.dev/packages/easy_utils
extension _StringExtensions on String {
  List<String> _splitMultiChoice(List<String> choices) {
    for (final str in choices) {
      if (contains(str)) {
        return split(str);
      }
    }

    return [this];
  }

  /// Check 'starts with' for multiple conditions
  bool _startsWithMultiple(List<String> substrings) {
    for (int i = 0; i < substrings.length; i++) {
      if (startsWith(substrings[i])) {
        return true;
      }
    }

    return false;
  }

  /// Check equality of other String but ignoring the case
  bool _equalsIgnoreCase(String? other) {
    // https://stackoverflow.com/a/54180384
    return toLowerCase() == other?.toLowerCase();
  }

  /// Returns indexes of a char
  ///
  /// Warning: Do not use separators with multiple characters
  ///
  /// Example:
  /// ```dart
  /// var myStr = 'hello,from,dart';
  /// var indexes = myStr.indexesOf(',');
  /// ```
  List<int> _indexesOf(String char) {
    assert(char.length == 1);

    List<int> out = [];

    for (int i = 0; i < length; i++) {
      if (this[i] == char) {
        if (i > 0 && this[i - 1] == r'\') {
          continue;
        }

        out.add(i);
      }
    }

    return out;
  }

  /// Returns a String list which contains parts of this String seperated by a seperator
  ///
  /// Warning: Do not use separators with multiple characters
  List<String> _splitExtended(String sep, [int? index]) {
    var indexes = _indexesOf(sep);

    if (index == null) {
      var out = <String>[];
      for (int i = 0; i < indexes.length; i++) {
        var index = i == 0 ? 0 : (indexes[i - 1] + 1);
        out.add(substring(index, indexes[i]));
      }

      return out;
    }

    assert(index > 0);
    index -= 1;

    return indexes.length <= index
        ? [this]
        : [substring(0, indexes[index]), substring(indexes[index] + 1)];
  }
}
