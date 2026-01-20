import 'package:barberita/common/jwt_decoder/payload_value.dart';

class UserData {
  static final UserData _instance = UserData._internal();
  factory UserData() => _instance;
  UserData._internal();

  String? userRole;
  Map<String, dynamic>? userData;

  Future<void> initialize() async {
    var result = await getPayloadValue();
    userRole = result["userRole"];
    userData = result;
  }
}

// Usage anywhere:
final myRole = UserData().userRole;