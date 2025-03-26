import 'package:bookworm/features/auth/data/firebase_auth_repo.dart';
import 'package:bookworm/features/book/data/firebase_books_repo.dart';
import 'package:bookworm/features/book/domain/book_repo.dart';
import 'package:bookworm/features/book/presentation/bloc/book_bloc.dart';
import 'package:bookworm/features/books/data/repos/datasources/books_remote_data_source.dart';
import 'package:bookworm/features/books/data/repos/books_repo_impl.dart';
import 'package:bookworm/features/books/presentation/bloc/books_bloc.dart';
import 'package:bookworm/features/home/presentation/pages/home_page.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_state.dart';
import 'package:bookworm/features/auth/presentation/pages/auth_page.dart';
import 'package:bookworm/features/profile/data/firebase_profile_repo.dart';
import 'package:bookworm/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:bookworm/features/review/data/firebase_review_repo.dart';
import 'package:bookworm/features/review/presentation/bloc/review_bloc.dart';
import 'package:bookworm/features/search/data/search_repo_impl.dart';
import 'package:bookworm/features/search/presentation/blocs/search_bloc.dart';
import 'package:bookworm/features/storage/data/firebase_storage_repo.dart';
import 'package:bookworm/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  // auth firebase repo
  final firebaseAuthRepo = FirebaseAuthRepo();
  // profile firebase repo
  final firebaseProfileRepo = FirebaseProfileRepo(
    storageRepo: FirebaseStorageRepo(),
  );
  // books repo
  final booksRepo = BooksRepoImpl(db: BooksRemoteDataSourceImpl());
  // book repo
  final bookRepo = BookRepoImpl(firebaseBookRepo: FirebaseBookRepoImpl());
  // search repo
  final searchRepo = SearchRepoImpl(db: BooksRemoteDataSourceImpl());
  // reviews repo
  final reviewsRepo = FirebaseReviewRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // AUTH BLOC
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(repo: firebaseAuthRepo),
        ),

        // PROFILE BLOC
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(repo: firebaseProfileRepo),
        ),

        // BOOKS BLOC
        BlocProvider<BooksBloc>(
          create: (context) => BooksBloc(repo: booksRepo),
        ),

        // BOOK BLOC
        BlocProvider<BookBloc>(create: (context) => BookBloc(repo: bookRepo)),

        // SEARCH BLOC
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(repo: searchRepo),
        ),

        // REVIEWS BLOC
        BlocProvider<ReviewBloc>(
          create: (context) => ReviewBloc(repo: reviewsRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            // authenticated
            if (state is AuthAuthenticated) {
              return HomePage(currUid: state.user.uid);
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
