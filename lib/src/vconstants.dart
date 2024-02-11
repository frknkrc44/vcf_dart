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

const _newLine = '\r\n';

class VConstants {
  const VConstants._();

  static const vcard = 'VCARD';
  static const begin = 'BEGIN';
  static const end = 'END';
  static const version = 'VERSION';
  static const name = 'N';
  static const formattedName = 'FN';
  static const address = 'ADR';
  static const agent = 'AGENT';
  static const anniversary = 'ANNIVERSARY';
  static const birthday = 'BDAY';
  static const calAdrUri = 'CALADRURI';
  static const calUri = 'CALURI';
  static const categories = 'CATEGORIES';
  static const classOfCard = 'CLASS';
  static const clientIDMap = 'CLIENTPIDMAP';
  static const email = 'EMAIL';
  static const fbUrl = 'FBURL';
  static const gender = 'GENDER';
  static const geo = 'GEO';
  static const impp = 'IMPP';
  static const publicKey = 'KEY';
  static const kind = 'KIND';
  static const label = 'LABEL';
  static const lang = 'LANG';
  static const logo = 'LOGO';
  static const mailer = 'MAILER';
  static const member = 'MEMBER'; // NOTE: KIND must be 'group' to use this
  static const nickname = 'NICKNAME';
  static const note = 'NOTE';
  static const organization = 'ORG';
  static const photo = 'PHOTO';
  static const productId = 'PRODID';
  static const related = 'RELATED';
  static const revisionDate = 'REV';
  static const role = 'ROLE';
  static const sound = 'SOUND';
  static const source = 'SOURCE';
  static const phone = 'TEL';
  static const title = 'TITLE';
  static const timeZone = 'TZ';
  static const uniqueId = 'UID';
  static const url = 'URL';
  static const xml = 'XML';

  // name parameters
  static const nameParamType = 'TYPE';
  static const nameParamEncoding = 'ENCODING';
  static const nameParamMediaType = 'MEDIATYPE';
  static const nameParamLanguage = 'LANGUAGE';
  static const nameParamValue = 'VALUE';
  static const nameParamPref = 'PREF';
  static const nameParamAltId = 'ALTID';
  static const nameParamGeo = geo;
  static const nameParamTimeZone = timeZone;

  // not a standard, just used for values before dot
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
}
