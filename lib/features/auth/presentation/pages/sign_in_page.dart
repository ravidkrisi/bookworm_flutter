import 'package:bookworm/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_event.dart';
import 'package:bookworm/features/auth/presentation/components/my_button.dart';
import 'package:bookworm/features/auth/presentation/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      // appBar: AppBar(title: Text('Sign In')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Weclome to',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                'Bookworm',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Spacer(),

              Container(
                height: 400,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
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

                    SizedBox(height: 20),

                    MyButton(text: 'Sign In', onPressed: onSignInPressed),

                    SizedBox(height: 10),

                    // google sign in btn
                    MyButton(
                      text: 'Sign In With Google',
                      prefixIcon: Icon(FontAwesomeIcons.google),
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthSignInWithGoogle());
                      },
                    ),

                    //navigator -> sign up page
                    TextButton(
                      onPressed: togglePages,
                      child: Text(
                        'Sign Up With Email And Password',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
