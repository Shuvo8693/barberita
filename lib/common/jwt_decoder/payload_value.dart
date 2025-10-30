import 'package:barberita/common/prefs_helper/prefs_helpers.dart';

import 'jwt_decoder.dart';

Future<Map<String, dynamic>> getPayloadValue()async{
  final token = await PrefsHelper.getString('token');

  final payloads = decodeJWT(token);
  String id = payloads['id'] ?? '';
  String role = payloads['role'] ?? '';
  String phone = payloads['phone'] ?? '';
  bool isLogin = payloads['isLogin'] ?? false;

  return {
    'userId' : id,
    'userRole' : role,
    'userPhone' : phone,
    'isLogin' : isLogin,
  };

/// ======= payload response ==========
//   {
//     "header" : {
//   "alg" : "HS256",
//   "typ" : "JWT"
// },
//   "payload" : {
//   "id" : "68e5fc8c77f9973c84781f8c",
//   "role" : "customer",
//   "phone" : "1093995839",
//   "isLogin" : true,
//   "iat" : 1761461700,
//   "exp" : 1762066500
// },
//   "signature" : "MHUiFQY3FFmzIO0xi2-IimRGEP3fRh7dr10SOU5AKpA"
// }

}
