// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_airline_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetAirlineDTO extends GetAirlineDTO {
  @override
  final String search;

  factory _$GetAirlineDTO([void Function(GetAirlineDTOBuilder)? updates]) =>
      (new GetAirlineDTOBuilder()..update(updates))._build();

  _$GetAirlineDTO._({required this.search}) : super._() {
    BuiltValueNullFieldError.checkNotNull(search, r'GetAirlineDTO', 'search');
  }

  @override
  GetAirlineDTO rebuild(void Function(GetAirlineDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetAirlineDTOBuilder toBuilder() => new GetAirlineDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAirlineDTO && search == other.search;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, search.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetAirlineDTO')
          ..add('search', search))
        .toString();
  }
}

class GetAirlineDTOBuilder
    implements Builder<GetAirlineDTO, GetAirlineDTOBuilder> {
  _$GetAirlineDTO? _$v;

  String? _search;
  String? get search => _$this._search;
  set search(String? search) => _$this._search = search;

  GetAirlineDTOBuilder() {
    GetAirlineDTO._defaults(this);
  }

  GetAirlineDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _search = $v.search;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetAirlineDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetAirlineDTO;
  }

  @override
  void update(void Function(GetAirlineDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetAirlineDTO build() => _build();

  _$GetAirlineDTO _build() {
    final _$result = _$v ??
        new _$GetAirlineDTO._(
          search: BuiltValueNullFieldError.checkNotNull(
              search, r'GetAirlineDTO', 'search'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
