// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_alert_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAlertDto extends CreateAlertDto {
  @override
  final String flightId;
  @override
  final String playerId;

  factory _$CreateAlertDto([void Function(CreateAlertDtoBuilder)? updates]) =>
      (CreateAlertDtoBuilder()..update(updates))._build();

  _$CreateAlertDto._({required this.flightId, required this.playerId})
      : super._();
  @override
  CreateAlertDto rebuild(void Function(CreateAlertDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateAlertDtoBuilder toBuilder() => CreateAlertDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAlertDto &&
        flightId == other.flightId &&
        playerId == other.playerId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, flightId.hashCode);
    _$hash = $jc(_$hash, playerId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAlertDto')
          ..add('flightId', flightId)
          ..add('playerId', playerId))
        .toString();
  }
}

class CreateAlertDtoBuilder
    implements Builder<CreateAlertDto, CreateAlertDtoBuilder> {
  _$CreateAlertDto? _$v;

  String? _flightId;
  String? get flightId => _$this._flightId;
  set flightId(String? flightId) => _$this._flightId = flightId;

  String? _playerId;
  String? get playerId => _$this._playerId;
  set playerId(String? playerId) => _$this._playerId = playerId;

  CreateAlertDtoBuilder() {
    CreateAlertDto._defaults(this);
  }

  CreateAlertDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _flightId = $v.flightId;
      _playerId = $v.playerId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAlertDto other) {
    _$v = other as _$CreateAlertDto;
  }

  @override
  void update(void Function(CreateAlertDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAlertDto build() => _build();

  _$CreateAlertDto _build() {
    final _$result = _$v ??
        _$CreateAlertDto._(
          flightId: BuiltValueNullFieldError.checkNotNull(
              flightId, r'CreateAlertDto', 'flightId'),
          playerId: BuiltValueNullFieldError.checkNotNull(
              playerId, r'CreateAlertDto', 'playerId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
