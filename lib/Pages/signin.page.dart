import 'dart:developer';

import 'package:appntaproject/Pages/loggedin.page.dart';
import 'package:appntaproject/logic/loginCubit/cubit/login_cubit.dart';
import 'package:appntaproject/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

//? hide keyboard when not in focus
FocusNode _focusNodeEmail = FocusNode();
FocusNode _focusNodePassword = FocusNode();

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  void togglePasswordObscure() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        switch (state.status) {
          case Status.initial:
            log('STATE@INITIAL');

            break;

          case Status.loading:
            log('STATE@LOADING');
            EasyLoading.show(
                maskType: EasyLoadingMaskType.black, status: 'Loading...');
            break;

          case Status.loaded:
            log("STATE@LOADED");
            log("${state.alldata!.data.name}-from_signin.page.dart");

            EasyLoading.dismiss();

            CustomSnackBar(
                context,
                const Center(
                  child: Text(
                    'Login Successful',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Colors.green);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoggedInPage(alldata: state.alldata!)),
            );
            userNameController.clear();
            passwordController.clear();
            break;

          case Status.error:
            log("STATUS@ERROR");
            EasyLoading.dismiss();

            CustomSnackBar(
                context,
                const Center(
                  child: Text(
                    'Invalid Username or Password ! ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const Color.fromARGB(255, 201, 28, 16));
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: GestureDetector(
                onTap: () {
                  _focusNodePassword.unfocus();
                  _focusNodeEmail.unfocus();
                },
                child: Container(
                  color: const Color.fromARGB(255, 219, 221, 220),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                      ),
                      //! nta logo image
                      const Center(
                        child: SizedBox(
                          height: 300,
                          child: Opacity(
                            opacity: 1,
                            child: Image(image: AssetImage("assets/logo.png")),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height / 42,
                      ),
                      //! username field
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30, bottom: 10),
                              child: Card(
                                elevation: 4,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FocusScope(
                                    child: TextFormField(
                                      // autovalidateMode:
                                      //     AutovalidateMode.onUserInteraction,
                                      focusNode: _focusNodeEmail,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          log("_email_cannot_be_empty");
                                          return 'Email cannot be empty';
                                        }
                                        return null;
                                      },
                                      controller: userNameController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.account_circle),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    255, 181, 216, 245)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    255, 213, 246, 230)),
                                          ),

                                          //! dg@nta.ac.in
                                          hintText: '   User name'),
                                      showCursor: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //! password field
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Card(
                                elevation: 4,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FocusScope(
                                    child: TextFormField(
                                      // autovalidateMode:
                                      //     AutovalidateMode.onUserInteraction,
                                      focusNode: _focusNodePassword,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          log("_password_cannot_be_empty");
                                          return 'Password cannot be empty';
                                        }
                                        return null;
                                      },

                                      //!

                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: passwordController,
                                      obscureText: obscurePassword,
                                      decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                              onTap: togglePasswordObscure,
                                              child: Icon(obscurePassword
                                                  ? Icons.visibility_off_sharp
                                                  : Icons.visibility_sharp)),
                                          prefixIcon: const Icon(Icons.lock),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(255, 181,
                                                    216, 245)), //<-- SEE HERE
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(255, 213,
                                                    246, 230)), //<-- SEE HERE
                                          ),
                                          //! dg@nta.ac.in
                                          //! NTA@2022
                                          hintText: '   Enter Password'),
                                      showCursor: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: height / 24,
                      ),
                      //* login button
                      Column(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                height: 54, width: 160),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 5,
                                shadowColor:
                                    const Color.fromARGB(255, 213, 246, 230),
                                backgroundColor: Colors.blue[300],
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                log("_pressed Login button");

                                //? newmethod of validation check, common key is checked for validation instead of individual key
                                if (formkey.currentState!.validate()) {
                                  context.read<LoginCubit>().loginUser(
                                      email: userNameController.text,
                                      password: passwordController.text);
                                }
                                //? else part -to show alertdialog showing login error message
                                else {
                                  log("_login_error_empty field/fields");
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Login Error'),
                                        content: const Text(
                                            'All fields are required'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('Login'),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: height / 12,
                      ),
                      const Center(
                        child: Text(
                          "NTA observer reporting Login Page",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "[ N.B. Please provide the required credentials ]",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
