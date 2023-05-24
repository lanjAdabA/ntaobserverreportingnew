// abstract class AuthLoginListener {
//   void loading();
//   void loaded();
//   void error();
// }
import 'package:appntaproject/models/login.model.dart';

abstract class AuthLoginListener { void loading(); void loaded({required NtaLoginModel alldata}); void error(); }