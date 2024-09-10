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

/// Used for storing key-value pairs
typedef VCardNameParameter = MapEntry<String, String>;

const _newLine = '\r\n';

/// Stores constant values for this library
class VConstants {
  const VConstants._();

  /// The VCARD type (eg: BEGIN:VCARD or END:VCARD)
  static const vcard = 'VCARD';

  /// The BEGIN type (eg: BEGIN:VCARD)
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.1.1
  static const begin = 'BEGIN';

  /// The END type (eg: END:VCARD)
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.1.2
  static const end = 'END';

  /// The VERSION type (eg: VERSION:4.0)
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.7.9
  static const version = 'VERSION';

  /// The N type (eg: N:Jack)
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.2.2
  static const name = 'N';

  /// The FN type (eg: FN:Jack Simone)
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.2.1
  static const formattedName = 'FN';

  /// The ADR type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.3.1
  static const address = 'ADR';

  /// The AGENT type (it will be ignored for now) (removed)
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#appendix-A.2
  ///
  /// Old docs: https://www.rfc-editor.org/rfc/rfc2426#section-3.5.4
  static const agent = 'AGENT';

  /// The ANNIVERSARY type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.2.6
  static const anniversary = 'ANNIVERSARY';

  /// The BDAY type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.2.5
  static const birthday = 'BDAY';

  /// The CALADURI type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.9.2
  static const calAdrUri = 'CALADRURI';

  /// The CALURI type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.9.3
  static const calUri = 'CALURI';

  /// The CATEGORIES type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.7.1
  static const categories = 'CATEGORIES';

  /// The CLASS type (removed)
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#appendix-A.2
  ///
  /// Old docs: https://www.rfc-editor.org/rfc/rfc2426#section-3.7.1
  static const classOfCard = 'CLASS';

  /// The CLIENTIDMAP type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.7.7
  static const clientIDMap = 'CLIENTPIDMAP';

  /// The EMAIL type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.4.2
  static const email = 'EMAIL';

  /// The FBURL type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.9.1
  static const fbUrl = 'FBURL';

  /// The GENDER type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.2.7
  static const gender = 'GENDER';

  /// The GEO type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.5.2
  static const geo = 'GEO';

  /// The IMPP type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.4.3
  static const impp = 'IMPP';

  /// The type type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.8.1
  static const publicKey = 'KEY';

  /// The KIND type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.1.4
  static const kind = 'KIND';

  /// The LABEL type (removed)
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#appendix-A.2
  ///
  /// Old docs: https://www.rfc-editor.org/rfc/rfc2426#section-3.2.2
  static const label = 'LABEL';

  /// The LANG type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.4.4
  static const lang = 'LANG';

  /// The LOGO type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.6.3
  static const logo = 'LOGO';

  /// The MAILER type (removed)
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#appendix-A.2
  ///
  /// Old docs: https://www.rfc-editor.org/rfc/rfc2426#section-3.3.3
  static const mailer = 'MAILER';

  /// The MEMBER type
  ///
  /// KIND must be 'group' to use this
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.6.5
  static const member = 'MEMBER';

  /// The NICKNAME type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.2.3
  static const nickname = 'NICKNAME';

  /// The NOTE type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.7.2
  static const note = 'NOTE';

  /// The ORG type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.6.4
  static const organization = 'ORG';

  /// The PHOTO type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.2.4
  static const photo = 'PHOTO';

  /// The PRODID type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.7.3
  static const productId = 'PRODID';

  /// The RELATED type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.6.6
  static const related = 'RELATED';

  /// The REV type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.7.4
  static const revisionDate = 'REV';

  /// The ROLE type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.6.2
  static const role = 'ROLE';

  /// The SOUND type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.7.5
  static const sound = 'SOUND';

  /// The SOURCE type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.1.3
  static const source = 'SOURCE';

  /// The TEL type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.4.1
  static const phone = 'TEL';

  /// The TITLE type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.6.1
  static const title = 'TITLE';

  /// The TZ type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.5.1
  static const timeZone = 'TZ';

  /// The UID type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.7.6
  static const uniqueId = 'UID';

  /// The URL type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.7.8
  static const url = 'URL';

  /// The XML type
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-6.1.5
  static const xml = 'XML';

  // property parameters

  /// The LANGUAGE property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.1
  static const nameParamLanguage = 'LANGUAGE';

  /// The VALUE property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.2
  static const nameParamValue = 'VALUE';

  /// The PREF property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.3
  static const nameParamPref = 'PREF';

  /// The ALTID property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.4
  static const nameParamAltId = 'ALTID';

  /// The PID property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.5
  static const nameParamPid = 'PID';

  /// The TYPE property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.6
  static const nameParamType = 'TYPE';

  /// The MEDIATYPE property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.7
  static const nameParamMediaType = 'MEDIATYPE';

  /// The CALSCALE property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.8
  static const nameParamCalscale = 'CALSCALE';

  /// The SORT-AS property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.9
  static const nameParamSortAs = 'SORT-AS';

  /// The GEO property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.10
  static const nameParamGeo = geo;

  /// The TZ property parameter
  ///
  /// https://www.rfc-editor.org/rfc/rfc6350#section-5.11
  static const nameParamTimeZone = timeZone;

  /// The ENCODING property parameter (removed)
  ///
  /// Old docs: https://www.rfc-editor.org/rfc/rfc2426#section-2.2
  static const nameParamEncoding = 'ENCODING';

  /// not a standard, just used for values before dot
  static const nameParamItemName = 'ITEMNAME';

  // type values
  static const typeText = 'text';
  static const typeBoolean = 'boolean';
  static const typeUri = 'URI';
  static const typeUtcOffset = 'utc-offset';
  static const typeLanguageTag = 'Language-Tag';
  static const typeIanaValuespec = 'iana-valuespec';

  // phone type values
  static const phoneTypeText = 'TEXT';
  static const phoneTypeVoice = 'VOICE';
  static const phoneTypeFax = 'FAX';
  static const phoneTypeCell = 'CELL';
  static const phoneTypeVideo = 'VIDEO';
  static const phoneTypePager = 'PAGER';
  static const phoneTypeTextPhone = 'TEXTPHONE';
  static const phoneTypeWork = 'WORK';
  static const phoneTypeHome = 'HOME';
  static const phoneTypeOther = 'OTHER';

  // type list values
  static const typeTextList = 'text-list';
  static const typeDateList = 'date-list';
  static const typeDateTimeList = 'date-time-list';
  static const typeDateAndOrTimeList = 'date-and-or-time-list';
  static const typeTimestampList = 'timestamp-list';
  static const typeIntegerList = 'integer-list';
  static const typeFloatList = 'float-list';

  // separator types
  static const _separatorList = ',';
  static const _separatorValue = ';';
  static const _separatorPair = ':';
  static const _separatorItem = '.';

  // escaped separator types
  static const _escapedSeparatorPair = '\\:';
}
