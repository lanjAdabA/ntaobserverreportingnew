// import 'package:appntaproject/models/login.model.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:http/http.dart' as http;

// part 'del_state.dart';

// class DelCubit extends Cubit<DelState> {
//   DelCubit(Status initial) : super(const DelState(status: Status.initial));
//   bool get isloading => Status.loading == state.status;

//   void delUser({required String email, required String password}) async {
//     if (isloading) return;
//     emit(const DelState(status: Status.loading));
//     var map = <String, dynamic>{};
//     map["email"] = email;
//     map["password"] = password;
//     final response = http.post(Uri.parse("uri_link"), body: map);
//  if (response.statusCode == 200) {
//       final data = ntaLoginModelFromJson(response.body);
//       emit(del(status: Status.loaded, alldata: data));
//       log('Successfully post Data');
//       log("${state.alldata!.data.name}-from_login_cubit.dart");
// //
//       // return data;
//     } else {
//       log('Failed to PostData.');
//       emit(const LoginState(status: Status.error));
//       log(response.statusCode.toString());
//       // return null;
//     }
//   }
// }
