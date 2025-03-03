import 'package:bookworm/features/auth/domain/repo/auth_repo.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_event.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo repo;

  AuthBloc({required this.repo}) : super(AuthInitial()) {
    // register event handlers
    on<AuthLoginWithEmailPwdRequested>(_onLogin);
    on<AuthCheckAuthRequested>(_onCheckAuth);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthSignUpWithEmailAndPwdRequested>(_onSignUp);

    // check for inital authenticaton
    add(AuthCheckAuthRequested());
  }

  void _onSignUp(
    AuthSignUpWithEmailAndPwdRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await repo.signUpWithEmailAndPwd(event.email, event.pwd, event.name);
      final user = await repo.getCurrentUser();

      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthErrors(message: 'error sign up: $e'));
      emit(AuthUnauthenticated());
    }
  }

  void _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await repo.logout();
    emit(AuthUnauthenticated());
  }

  void _onCheckAuth(
    AuthCheckAuthRequested event,
    Emitter<AuthState> emit,
  ) async {
    final user = await repo.getCurrentUser();

    // authenticated
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    }
    // unauthenticated
    else {
      emit(AuthUnauthenticated());
    }
  }

  void _onLogin(
    AuthLoginWithEmailPwdRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // log in
      await repo.signInWithEmailAndPwd(event.email, event.pwd);

      // fetch the user
      final user = await repo.getCurrentUser();

      // login success
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      }
      // login failed
      else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthErrors(message: 'error logging in: $e'));
      emit(AuthUnauthenticated());
    }
  }
}
