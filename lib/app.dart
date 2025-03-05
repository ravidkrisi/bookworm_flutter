import 'package:bookworm/features/auth/data/firebase_auth_repo.dart';
import 'package:bookworm/features/home/presentation/pages/home_page.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_state.dart';
import 'package:bookworm/features/auth/presentation/pages/auth_page.dart';
import 'package:bookworm/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  // auth firebase repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(repo: firebaseAuthRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            // authenticated
            if (state is AuthAuthenticated) {
              return HomePage();
            }
            // unauthenticated
            else if (state is AuthUnauthenticated) {
              return AuthPage();
            }
            // loading..
            else if (state is AuthLoading) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            // default
            else {
              return Scaffold(body: Container());
            }
          },
          listener: (context, state) {
            print(state);
            if (state is AuthErrors) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
