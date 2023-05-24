part of 'login_cubit.dart';

enum Status { initial, loading, loaded, error }

class LoginState extends Equatable {
  final Status status;
  final NtaLoginModel? alldata;
  const LoginState({this.alldata, required this.status});

  @override
  List get props => [status, alldata];
}
