import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String id;
  User({
    required this.name,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'User(name: $name, id: $id)'; // Added for debugging
}

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User? build() {
    print('UserNotifier build called, initial state: null');
    return null;
  }

  void login(String id, String name) {
    print('UserNotifier login called with id: $id, name: $name');
    state = User(
      name: name,
      id: id,
    );
    print('UserNotifier state after login: $state');
  }

  void logout() {
    print('UserNotifier logout called');
    state = null;
    print('UserNotifier state after logout: $state');
  }
}
