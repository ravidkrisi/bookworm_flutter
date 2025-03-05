import 'package:bookworm/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_event.dart';
import 'package:bookworm/features/auth/presentation/components/my_button.dart';
import 'package:bookworm/features/auth/presentation/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // name text field
            MyTextField(
              controller: nameController,
              hintText: 'Name',
              obscureText: false,
              prefixIcon: Icon(
                FontAwesomeIcons.person,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),

            SizedBox(height: 20),

            // email text field
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
              prefixIcon: Icon(
                FontAwesomeIcons.envelope,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),

            SizedBox(height: 20),

            // password text field
            MyTextField(
              controller: pwdController,
              hintText: 'Password',
              obscureText: true,
              prefixIcon: Icon(
                FontAwesomeIcons.lock,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),

            SizedBox(height: 50),

            // sign up btn
            MyButton(text: 'Sign Up', onPressed: _onSignUpPressed),

            //navigator -> sign in page
            TextButton(
              onPressed: togglePages,
              child: Text(
                'already have user? sign in',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
