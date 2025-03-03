import 'package:bookworm/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_event.dart';
import 'package:bookworm/features/auth/presentation/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  final void Function()? togglePages;
  const SignInPage({super.key, this.togglePages});

  @override
  Widget build(BuildContext context) {
    // controllers
    final emailController = TextEditingController();
    final pwdController = TextEditingController();

    // bloc
    final authBloc = context.read<AuthBloc>();

    // on sign in pressed
    void onSignInPressed() {
      // validate email & pwd
      final email = emailController.text;
      final pwd = pwdController.text;
      if (email.isNotEmpty && pwd.isNotEmpty) {
        authBloc.add(AuthLoginWithEmailPwdRequested(email: email, pwd: pwd));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: Column(
        children: [
          // email text field
          MyTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
          ),

          // password text field
          MyTextField(
            controller: pwdController,
            hintText: 'Password',
            obscureText: true,
          ),

          // log in btn
          TextButton(onPressed: onSignInPressed, child: Text('Sign In')),

          //navigator -> sign up page
          TextButton(
            onPressed: togglePages,
            child: Text('already have user? sign in'),
          ),
        ],
      ),
    );
  }
}
