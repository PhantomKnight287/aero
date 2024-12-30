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
  toJson() => _$UserToJson(this);
}

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User? build() {
    return null;
  }

  Future<void> login(String id, String name) async {
    state = User(
      name: name,
      id: id,
    );
  }

  Future<void> logout() async {
    state = null;
  }
}
