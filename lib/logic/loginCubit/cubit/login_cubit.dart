import 'dart:developer';
import 'package:appntaproject/models/login.model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(Status initial) : super(const LoginState(status: Status.initial));
  bool get isLoading => Status.loading == state.status;
  void loginUser({required String email, required String password}) async {
    if (isLoading) return;
    emit(const LoginState(status: Status.loading));
    var map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    final response = await http
        .post(Uri.parse('https://cbtc.nta.ac.in/api/login'), body: map);
    if (response.statusCode == 200) {
      final data = ntaLoginModelFromJson(response.body);
      emit(LoginState(status: Status.loaded, alldata: data));
      log('Successfully post Data');
      log("${state.alldata!.data.name}-from_login_cubit.dart");
//
      // return data;
    } else {
      log('Failed to PostData.');
      emit(const LoginState(status: Status.error));
      log(response.statusCode.toString());
      // return null;
    }
  }
}
