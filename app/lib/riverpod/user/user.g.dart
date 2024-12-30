// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userNotifierHash() => r'3deaad7ba79cf3127a98db9a09e39db9e9335b60';

/// See also [UserNotifier].
@ProviderFor(UserNotifier)
final userNotifierProvider =
    AutoDisposeNotifierProvider<UserNotifier, User?>.internal(
  UserNotifier.new,
  name: r'userNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserNotifier = AutoDisposeNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
