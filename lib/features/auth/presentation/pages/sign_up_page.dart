import 'package:bookworm/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_event.dart';
import 'package:bookworm/features/auth/presentation/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  final void Function()? togglePages;
  const SignUpPage({super.key, this.togglePages});

  @override
  Widget build(BuildContext context) {
    // controllers
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final pwdController = TextEditingController();

    // bloc
    final authBloc = context.read<AuthBloc>();

    // on sign in pressed
    void _onSignUpPressed() {
      // validate email & pwd & name
      final email = emailController.text;
      final pwd = pwdController.text;
      final name = pwdController.text;
      if (email.isNotEmpty && pwd.isNotEmpty && name.isNotEmpty) {
        authBloc.add(
          AuthSignUpWithEmailAndPwdRequested(
            email: email,
            pwd: pwd,
            name: name,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Column(
        children: [
          // name text field
          MyTextField(
            controller: nameController,
            hintText: 'Name',
            obscureText: false,
          ),

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
          TextButton(onPressed: _onSignUpPressed, child: Text('Sign Up')),

          //navigator -> log in pag
          TextButton(
            onPressed: togglePages,
            child: Text('already have user? sign in'),
          ),
        ],
      ),
    );
  }
}
