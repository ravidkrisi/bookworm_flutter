import 'package:bookworm/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_state.dart';
import 'package:bookworm/features/book/presentation/bloc/book_bloc.dart';
import 'package:bookworm/features/book/presentation/bloc/book_event.dart';
import 'package:bookworm/features/book/presentation/bloc/book_states.dart';
import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookPage extends StatefulWidget {
  final Book book;
  const BookPage({super.key, required this.book});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late String userId;

  // blocs
  late BookBloc bookBloc;
  late AuthBloc authBloc;

  BookStatus selectedValue = BookStatus.unknown;

  @override
  void initState() {
    super.initState();
    // Ensure the context has access to the Bloc
    authBloc = BlocProvider.of<AuthBloc>(context);
    bookBloc = BlocProvider.of<BookBloc>(context);

    fetchCurrUser();
    // fetchUserBook();
  }

  void fetchCurrUser() {
    final state = authBloc.state;
    if (state is AuthAuthenticated) {
      userId = state.user.uid;
      print(userId);
      print(widget.book.id);
      bookBloc.add(GetUserBook(userId: userId, bookId: widget.book.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            // cover image
            Container(
              height: 220,
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.book.coverUrl,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                  imageBuilder:
                      (context, imageProvider) =>
                          Image(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
            ),

            SizedBox(height: 10),

            // book title
            Text(
              widget.book.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            // author
            Text(
              widget.book.author,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            // first publish yaer
            Text(
              widget.book.firstPublishYear.toString(),
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            BlocConsumer<BookBloc, BookState>(
              builder: (context, state) {
                // loading
                if (state is BookLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                // loaded
                if (state is BookLoaded) {
                  print('status:${state.book?.status.name ?? 'nothing'}');
                  selectedValue = state.book?.status ?? BookStatus.unknown;
                  return DropdownButton<BookStatus>(
                    value: selectedValue,
                    items:
                        BookStatus.values.map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Text(status.displayName),
                          );
                        }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          // chagne status in backend
                          final updatedBook = widget.book.copyWith(
                            status: value,
                          );
                          print('im here2');

                          bookBloc.add(
                            UpdateBookStatus(userId: userId, book: updatedBook),
                          );

                          // update UI
                          selectedValue = value;
                        });
                      }
                    },
                  );
                }

                // default
                return Container();
              },
              listener: (context, state) {
                if (state is BookError) {
                  print(state.message);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
