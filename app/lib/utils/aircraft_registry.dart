/// Country of registration for an aircraft, from its ICAO 24-bit address
/// (Mode S hex, ICAO Annex 10 Vol III allocation blocks) or, as a fallback,
/// its registration's nationality prefix.
class RegistryCountry {
  final String iso2;
  final String name;
  const RegistryCountry(this.iso2, this.name);

  @override
  bool operator ==(Object other) =>
      other is RegistryCountry && other.iso2 == iso2;

  @override
  int get hashCode => iso2.hashCode;
}

class _Block {
  final int start;
  final int end;
  final RegistryCountry country;
  const _Block(this.start, this.end, this.country);
}

const _za = RegistryCountry('ZA', 'South Africa');
const _eg = RegistryCountry('EG', 'Egypt');
const _ma = RegistryCountry('MA', 'Morocco');
const _tn = RegistryCountry('TN', 'Tunisia');
const _et = RegistryCountry('ET', 'Ethiopia');
const _ke = RegistryCountry('KE', 'Kenya');
const _ng = RegistryCountry('NG', 'Nigeria');
const _qa = RegistryCountry('QA', 'Qatar');
const _dz = RegistryCountry('DZ', 'Algeria');
const _co = RegistryCountry('CO', 'Colombia');
const _cu = RegistryCountry('CU', 'Cuba');
const _mx = RegistryCountry('MX', 'Mexico');
const _ve = RegistryCountry('VE', 'Venezuela');
const _ru = RegistryCountry('RU', 'Russia');
const _it = RegistryCountry('IT', 'Italy');
const _es = RegistryCountry('ES', 'Spain');
const _fr = RegistryCountry('FR', 'France');
const _de = RegistryCountry('DE', 'Germany');
const _gb = RegistryCountry('GB', 'United Kingdom');
const _at = RegistryCountry('AT', 'Austria');
const _be = RegistryCountry('BE', 'Belgium');
const _bg = RegistryCountry('BG', 'Bulgaria');
const _dk = RegistryCountry('DK', 'Denmark');
const _fi = RegistryCountry('FI', 'Finland');
const _gr = RegistryCountry('GR', 'Greece');
const _hu = RegistryCountry('HU', 'Hungary');
const _no = RegistryCountry('NO', 'Norway');
const _nl = RegistryCountry('NL', 'Netherlands');
const _pl = RegistryCountry('PL', 'Poland');
const _pt = RegistryCountry('PT', 'Portugal');
const _cz = RegistryCountry('CZ', 'Czechia');
const _ro = RegistryCountry('RO', 'Romania');
const _se = RegistryCountry('SE', 'Sweden');
const _ch = RegistryCountry('CH', 'Switzerland');
const _tr = RegistryCountry('TR', 'Türkiye');
const _rs = RegistryCountry('RS', 'Serbia');
const _cy = RegistryCountry('CY', 'Cyprus');
const _ie = RegistryCountry('IE', 'Ireland');
const _is = RegistryCountry('IS', 'Iceland');
const _lu = RegistryCountry('LU', 'Luxembourg');
const _mt = RegistryCountry('MT', 'Malta');
const _hr = RegistryCountry('HR', 'Croatia');
const _lv = RegistryCountry('LV', 'Latvia');
const _lt = RegistryCountry('LT', 'Lithuania');
const _sk = RegistryCountry('SK', 'Slovakia');
const _si = RegistryCountry('SI', 'Slovenia');
const _ua = RegistryCountry('UA', 'Ukraine');
const _by = RegistryCountry('BY', 'Belarus');
const _ee = RegistryCountry('EE', 'Estonia');
const _az = RegistryCountry('AZ', 'Azerbaijan');
const _kz = RegistryCountry('KZ', 'Kazakhstan');
const _af = RegistryCountry('AF', 'Afghanistan');
const _bd = RegistryCountry('BD', 'Bangladesh');
const _mm = RegistryCountry('MM', 'Myanmar');
const _kw = RegistryCountry('KW', 'Kuwait');
const _la = RegistryCountry('LA', 'Laos');
const _np = RegistryCountry('NP', 'Nepal');
const _om = RegistryCountry('OM', 'Oman');
const _kh = RegistryCountry('KH', 'Cambodia');
const _sa = RegistryCountry('SA', 'Saudi Arabia');
const _kr = RegistryCountry('KR', 'South Korea');
const _kp = RegistryCountry('KP', 'North Korea');
const _iq = RegistryCountry('IQ', 'Iraq');
const _ir = RegistryCountry('IR', 'Iran');
const _il = RegistryCountry('IL', 'Israel');
const _jo = RegistryCountry('JO', 'Jordan');
const _lb = RegistryCountry('LB', 'Lebanon');
const _my = RegistryCountry('MY', 'Malaysia');
const _ph = RegistryCountry('PH', 'Philippines');
const _pk = RegistryCountry('PK', 'Pakistan');
const _sg = RegistryCountry('SG', 'Singapore');
const _lk = RegistryCountry('LK', 'Sri Lanka');
const _sy = RegistryCountry('SY', 'Syria');
const _cn = RegistryCountry('CN', 'China');
const _au = RegistryCountry('AU', 'Australia');
const _in = RegistryCountry('IN', 'India');
const _jp = RegistryCountry('JP', 'Japan');
const _th = RegistryCountry('TH', 'Thailand');
const _vn = RegistryCountry('VN', 'Vietnam');
const _ye = RegistryCountry('YE', 'Yemen');
const _bh = RegistryCountry('BH', 'Bahrain');
const _bn = RegistryCountry('BN', 'Brunei');
const _ae = RegistryCountry('AE', 'United Arab Emirates');
const _pg = RegistryCountry('PG', 'Papua New Guinea');
const _tw = RegistryCountry('TW', 'Taiwan');
const _id = RegistryCountry('ID', 'Indonesia');
const _us = RegistryCountry('US', 'United States');
const _ca = RegistryCountry('CA', 'Canada');
const _nz = RegistryCountry('NZ', 'New Zealand');
const _fj = RegistryCountry('FJ', 'Fiji');
const _ar = RegistryCountry('AR', 'Argentina');
const _br = RegistryCountry('BR', 'Brazil');
const _cl = RegistryCountry('CL', 'Chile');
const _ec = RegistryCountry('EC', 'Ecuador');
const _py = RegistryCountry('PY', 'Paraguay');
const _pe = RegistryCountry('PE', 'Peru');
const _uy = RegistryCountry('UY', 'Uruguay');
const _bo = RegistryCountry('BO', 'Bolivia');
const _hk = RegistryCountry('HK', 'Hong Kong');
const _mo = RegistryCountry('MO', 'Macau');
const _am = RegistryCountry('AM', 'Armenia');
const _tm = RegistryCountry('TM', 'Turkmenistan');
const _uz = RegistryCountry('UZ', 'Uzbekistan');

// ponytail: covers the larger civil registries (ICAO Annex 10 Vol III,
// Part I, Ch. 9 appendix); small states fall back to the registration
// prefix. Add blocks here when an aircraft shows no country.
const _blocks = <_Block>[
  _Block(0x008000, 0x00FFFF, _za),
  _Block(0x010000, 0x017FFF, _eg),
  _Block(0x020000, 0x027FFF, _ma),
  _Block(0x028000, 0x02FFFF, _tn),
  _Block(0x040000, 0x040FFF, _et),
  _Block(0x04C000, 0x04CFFF, _ke),
  _Block(0x064000, 0x064FFF, _ng),
  _Block(0x06A000, 0x06A3FF, _qa),
  _Block(0x0A0000, 0x0A7FFF, _dz),
  _Block(0x0AC000, 0x0ACFFF, _co),
  _Block(0x0B0000, 0x0B0FFF, _cu),
  _Block(0x0D0000, 0x0D7FFF, _mx),
  _Block(0x0D8000, 0x0DFFFF, _ve),
  _Block(0x100000, 0x1FFFFF, _ru),
  _Block(0x300000, 0x33FFFF, _it),
  _Block(0x340000, 0x37FFFF, _es),
  _Block(0x380000, 0x3BFFFF, _fr),
  _Block(0x3C0000, 0x3FFFFF, _de),
  _Block(0x400000, 0x43FFFF, _gb),
  _Block(0x440000, 0x447FFF, _at),
  _Block(0x448000, 0x44FFFF, _be),
  _Block(0x450000, 0x457FFF, _bg),
  _Block(0x458000, 0x45FFFF, _dk),
  _Block(0x460000, 0x467FFF, _fi),
  _Block(0x468000, 0x46FFFF, _gr),
  _Block(0x470000, 0x477FFF, _hu),
  _Block(0x478000, 0x47FFFF, _no),
  _Block(0x480000, 0x487FFF, _nl),
  _Block(0x488000, 0x48FFFF, _pl),
  _Block(0x490000, 0x497FFF, _pt),
  _Block(0x498000, 0x49FFFF, _cz),
  _Block(0x4A0000, 0x4A7FFF, _ro),
  _Block(0x4A8000, 0x4AFFFF, _se),
  _Block(0x4B0000, 0x4B7FFF, _ch),
  _Block(0x4B8000, 0x4BFFFF, _tr),
  _Block(0x4C0000, 0x4C7FFF, _rs),
  _Block(0x4C8000, 0x4C83FF, _cy),
  _Block(0x4CA000, 0x4CAFFF, _ie),
  _Block(0x4CC000, 0x4CCFFF, _is),
  _Block(0x4D0000, 0x4D03FF, _lu),
  _Block(0x4D2000, 0x4D23FF, _mt),
  _Block(0x501C00, 0x501FFF, _hr),
  _Block(0x502C00, 0x502FFF, _lv),
  _Block(0x503C00, 0x503FFF, _lt),
  _Block(0x505C00, 0x505FFF, _sk),
  _Block(0x506C00, 0x506FFF, _si),
  _Block(0x508000, 0x50FFFF, _ua),
  _Block(0x510000, 0x5103FF, _by),
  _Block(0x511000, 0x5113FF, _ee),
  _Block(0x600800, 0x600BFF, _az),
  _Block(0x601800, 0x601BFF, _tm),
  _Block(0x683000, 0x6833FF, _kz),
  _Block(0x700000, 0x700FFF, _af),
  _Block(0x702000, 0x702FFF, _bd),
  _Block(0x704000, 0x704FFF, _mm),
  _Block(0x706000, 0x706FFF, _kw),
  _Block(0x708000, 0x708FFF, _la),
  _Block(0x70A000, 0x70AFFF, _np),
  _Block(0x70C000, 0x70C3FF, _om),
  _Block(0x70E000, 0x70EFFF, _kh),
  _Block(0x710000, 0x717FFF, _sa),
  _Block(0x718000, 0x71FFFF, _kr),
  _Block(0x720000, 0x727FFF, _kp),
  _Block(0x728000, 0x72FFFF, _iq),
  _Block(0x730000, 0x737FFF, _ir),
  _Block(0x738000, 0x73FFFF, _il),
  _Block(0x740000, 0x747FFF, _jo),
  _Block(0x748000, 0x74FFFF, _lb),
  _Block(0x750000, 0x757FFF, _my),
  _Block(0x758000, 0x75FFFF, _ph),
  _Block(0x760000, 0x767FFF, _pk),
  _Block(0x768000, 0x76FFFF, _sg),
  _Block(0x770000, 0x777FFF, _lk),
  _Block(0x778000, 0x77FFFF, _sy),
  _Block(0x780000, 0x7BFFFF, _cn),
  _Block(0x7C0000, 0x7FFFFF, _au),
  _Block(0x800000, 0x83FFFF, _in),
  _Block(0x840000, 0x87FFFF, _jp),
  _Block(0x880000, 0x887FFF, _th),
  _Block(0x888000, 0x88FFFF, _vn),
  _Block(0x890000, 0x890FFF, _ye),
  _Block(0x894000, 0x894FFF, _bh),
  _Block(0x895000, 0x8953FF, _bn),
  _Block(0x896000, 0x896FFF, _ae),
  _Block(0x898000, 0x898FFF, _pg),
  _Block(0x899000, 0x8993FF, _tw),
  _Block(0x8A0000, 0x8A7FFF, _id),
  _Block(0xA00000, 0xAFFFFF, _us),
  _Block(0xC00000, 0xC3FFFF, _ca),
  _Block(0xC80000, 0xC87FFF, _nz),
  _Block(0xC88000, 0xC88FFF, _fj),
  _Block(0xE00000, 0xE3FFFF, _ar),
  _Block(0xE40000, 0xE7FFFF, _br),
  _Block(0xE80000, 0xE80FFF, _cl),
  _Block(0xE84000, 0xE84FFF, _ec),
  _Block(0xE88000, 0xE88FFF, _py),
  _Block(0xE8C000, 0xE8CFFF, _pe),
  _Block(0xE90000, 0xE90FFF, _uy),
  _Block(0xE94000, 0xE94FFF, _bo),
];

RegistryCountry? countryFromHex(String? hex) {
  if (hex == null || !RegExp(r'^[0-9a-fA-F]{6}$').hasMatch(hex.trim())) {
    return null;
  }
  final v = int.parse(hex.trim(), radix: 16);
  for (final b in _blocks) {
    if (v >= b.start && v <= b.end) return b.country;
  }
  return null;
}

// Nationality marks. Checked in order: put more specific patterns first
// (B-H before B-, 5-digit B- for Taiwan).
final _prefixes = <(RegExp, RegistryCountry)>[
  (RegExp(r'^B-H'), _hk),
  (RegExp(r'^B-M'), _mo),
  (RegExp(r'^B-\d{5}$'), _tw),
  (RegExp(r'^B-'), _cn),
  (RegExp(r'^N\d'), _us),
  (RegExp(r'^JA\d'), _jp),
  (RegExp(r'^HL\d'), _kr),
  (RegExp(r'^C-[FGI]'), _ca),
  (RegExp(r'^A9C-'), _bh),
  (RegExp(r'^A4O-'), _om),
  for (final (p, c) in [
    ('G-', _gb),
    ('D-', _de),
    ('F-', _fr),
    ('I-', _it),
    ('EC-', _es),
    ('PH-', _nl),
    ('OO-', _be),
    ('OE-', _at),
    ('HB-', _ch),
    ('SE-', _se),
    ('OY-', _dk),
    ('LN-', _no),
    ('OH-', _fi),
    ('EI-', _ie),
    ('TF-', _is),
    ('SX-', _gr),
    ('CS-', _pt),
    ('SP-', _pl),
    ('OK-', _cz),
    ('OM-', _sk),
    ('HA-', _hu),
    ('YR-', _ro),
    ('LZ-', _bg),
    ('9A-', _hr),
    ('S5-', _si),
    ('YU-', _rs),
    ('TC-', _tr),
    ('UR-', _ua),
    ('EW-', _by),
    ('ES-', _ee),
    ('YL-', _lv),
    ('LY-', _lt),
    ('RA-', _ru),
    ('LX-', _lu),
    ('9H-', _mt),
    ('5B-', _cy),
    ('4X-', _il),
    ('A6-', _ae),
    ('A7-', _qa),
    ('9K-', _kw),
    ('HZ-', _sa),
    ('AP-', _pk),
    ('VT-', _in),
    ('4R-', _lk),
    ('S2-', _bd),
    ('9N-', _np),
    ('HS-', _th),
    ('VN-', _vn),
    ('9M-', _my),
    ('9V-', _sg),
    ('PK-', _id),
    ('RP-', _ph),
    ('VH-', _au),
    ('ZK-', _nz),
    ('ET-', _et),
    ('5Y-', _ke),
    ('5N-', _ng),
    ('ZS-', _za),
    ('SU-', _eg),
    ('CN-', _ma),
    ('7T-', _dz),
    ('TS-', _tn),
    ('XA-', _mx),
    ('XB-', _mx),
    ('XC-', _mx),
    ('PP-', _br),
    ('PR-', _br),
    ('PS-', _br),
    ('PT-', _br),
    ('LV-', _ar),
    ('CC-', _cl),
    ('HK-', _co),
    ('OB-', _pe),
    ('YV-', _ve),
    ('EP-', _ir),
    ('YI-', _iq),
    ('JY-', _jo),
    ('OD-', _lb),
    ('EK-', _am),
    ('4K-', _az),
    ('UP-', _kz),
    ('EZ-', _tm),
    ('UK-', _uz),
    ('P2-', _pg),
    ('DQ-', _fj),
    ('HC-', _ec),
    ('ZP-', _py),
    ('CX-', _uy),
    ('CP-', _bo),
    ('CU-', _cu),
  ])
    (RegExp('^${RegExp.escape(p)}'), c),
];

RegistryCountry? countryFromRegistration(String? reg) {
  if (reg == null) return null;
  final r = reg.trim().toUpperCase();
  for (final (re, c) in _prefixes) {
    if (re.hasMatch(r)) return c;
  }
  return null;
}

/// Hex block first (authoritative), registration prefix as fallback.
RegistryCountry? registryCountry({String? hex, String? reg}) =>
    countryFromHex(hex) ?? countryFromRegistration(reg);

/// Regional-indicator flag for an ISO 3166-1 alpha-2 code.
String flagEmoji(String iso2) => String.fromCharCodes(
    iso2.toUpperCase().codeUnits.map((c) => 0x1F1E6 + c - 0x41));
