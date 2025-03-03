import 'package:bookworm/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // auth bloc
    final authBloc = context.read<AuthBloc>();

    void _onLogoutPressed() {
      authBloc.add(AuthLogoutRequested());
    }

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: TextButton(onPressed: _onLogoutPressed, child: Text('logout')),
      ),
    );
  }
}
