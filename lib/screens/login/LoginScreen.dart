import 'package:flutter/material.dart';
import 'package:flutter_project2/blocs/UserBloc.dart';
import 'package:flutter_project2/screens/login/background.dart';
import 'package:flutter_project2/screens/signup/SignUpScreen.dart';
import 'package:flutter_project2/shared/Empty.dart';
import 'package:flutter_project2/shared/already_have_an_account_acheck.dart';
import 'package:flutter_project2/shared/rounded_button.dart';
import 'package:flutter_project2/shared/rounded_input_field.dart';
import 'package:flutter_project2/shared/rounded_password_field.dart';
import 'package:flutter_project2/utility/String.dart';
import 'package:flutter_project2/utility/Utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const ROUTE_LOGIN = "/Login";

  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<UserBloc>(
      create: (context) => UserBloc(),
      child: LoginScreenUI(),
      dispose: (ctx, userBloc) => userBloc.dispose(),
    );
  }
}

class LoginScreenUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bloc = Provider.of<UserBloc>(context);

    bloc.listen();
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                TXT_LOGIN,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              StreamBuilder<String>(
                  stream: bloc.userEmail,
                  builder: (context, snapshot) {
                    return RoundedInputField(
                      hintText: HINT_EMAIL,
                      onChanged: bloc.changeUserEmail,
                      errorText:
                          snapshot.hasError ? snapshot.error as String : null,
                    );
                  }),
              StreamBuilder<String>(
                  stream: bloc.userPass,
                  builder: (context, snapshot) {
                    return RoundedPasswordField(
                      onChanged: bloc.changeUserPass,
                      errorText:
                          snapshot.hasError ? snapshot.error as String : null,
                    );
                  }),
              StreamBuilder<dynamic>(
                  stream: bloc.showToastStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Utils.showToast(snapshot.data);
                      bloc.showToastSink.add('');
                    }
                    return Empty();
                  }),
              StreamBuilder<bool>(
                  stream: bloc.userValid,
                  builder: (context, snapshot) {
                    return RoundedButton(
                      text: TXT_LOGIN,
                      isEnable: !snapshot.hasData ? false : snapshot.data!,
                      press: bloc.loginUser,
                    );
                  }),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
