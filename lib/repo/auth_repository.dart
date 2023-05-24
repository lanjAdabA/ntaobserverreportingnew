// // import 'dart:convert';
// import 'dart:developer';
// import 'package:appntaproject/listener/auth_login_listener.dart';
// import 'package:appntaproject/models/login.model.dart';

// import 'package:http/http.dart' as http;

// class AuthRepository {
//   Future 
//   // <NtaLoginModel?>
//   login(
//       {required String email,
//       required String password,
//       required AuthLoginListener authLoginListener}) async {
//     authLoginListener.loading();
//     // const uri = 'https://cbtc.nta.ac.in/api/login';
//     var map = <String, dynamic>{};

//     map['email'] = email;
//     map['password'] = password;

//     final response = await http
//         .post(Uri.parse('https://cbtc.nta.ac.in/api/login'), body: map);

//     if (response.statusCode == 200) {
//  final data = ntaLoginModelFromJson(response.body);
 
     

//       authLoginListener.loaded(alldata: data);
//       log('Successfully post Data');
//       // return data;

//     } else {
//       log('Failed to PostData.');
//       authLoginListener.error();
//       log(response.statusCode.toString());
//       // return null;
//     }
//   }
// }
