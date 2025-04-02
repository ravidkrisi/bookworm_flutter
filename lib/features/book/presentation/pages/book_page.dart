import 'package:bookworm/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_state.dart';
import 'package:bookworm/features/book/presentation/bloc/book_bloc.dart';
import 'package:bookworm/features/book/presentation/bloc/book_event.dart';
import 'package:bookworm/features/book/presentation/bloc/book_states.dart';
import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:bookworm/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:bookworm/features/profile/presentation/blocs/profile_event.dart';
import 'package:bookworm/features/review/presentation/bloc/review_bloc.dart';
import 'package:bookworm/features/review/presentation/bloc/review_event.dart';
import 'package:bookworm/features/review/presentation/bloc/review_state.dart';
import 'package:bookworm/features/review/presentation/components/rating_starts.dart';
import 'package:bookworm/features/review/presentation/components/review_tile.dart';
import 'package:bookworm/features/review/presentation/pages/add_review_page.dart';
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
  late ReviewBloc reviewBloc;

  BookStatus? selectedValue;

  @override
  void initState() {
    super.initState();
    print(widget.book.coverUrl);
    // Ensure the context has access to the Bloc
    authBloc = BlocProvider.of<AuthBloc>(context);
    bookBloc = BlocProvider.of<BookBloc>(context);
    reviewBloc = BlocProvider.of<ReviewBloc>(context);

    fetchCurrUser();
    fetchReviews();
  }

  void fetchReviews() {
    reviewBloc.add(ReviewGetReviewsByBookId(bookId: widget.book.id));
  }

  void fetchCurrUser() {
    final state = authBloc.state;
    if (state is AuthAuthenticated) {
      userId = state.user.uid;
      bookBloc.add(GetUserBook(userId: userId, bookId: widget.book.id));
    }
  }

  void deleteBook(BuildContext context) {
    bookBloc.add(DeleteUserBook(userId: userId, bookId: widget.book.id));
    context.read<ProfileBloc>().add(ProfileBookRemoved(bookId: widget.book.id));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // delete btn
          BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state is BookLoaded) {
                return state.book?.status != null
                    ? IconButton(
                      onPressed: () => deleteBook(context),
                      icon: Icon(Icons.delete),
                    )
                    : Container();
              }
              return Container();
            },
          ),
        ],
      ),
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
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            // author
            Text(
              widget.book.author,
              textAlign: TextAlign.center,
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

            bookStatus(),

            SizedBox(height: 10),

            // book rating
            reviewsSection(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<ReviewBloc, ReviewState> reviewsSection() {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        // loading
        if (state is ReviewLoading) {
          return Center(child: CircularProgressIndicator());
        }
        // loaded
        if (state is ReviewLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // rating section
                RatingStarts(rating: state.rating.toInt()),

                SizedBox(height: 20),

                // reviews section
                Align(
                  child: Text(
                    'Reviews',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  alignment: Alignment.topLeft,
                ),

                SizedBox(height: 10),

                state.reviews.isEmpty
                    ?
                    // no reviews
                    Text('no reviews yet')
                    :
                    // reviews list
                    ListView.separated(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: state.reviews.length,
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10),
                      itemBuilder:
                          (context, index) =>
                              ReviewTile(review: state.reviews[index]),
                    ),
              ],
            ),
          );
        }
        // default
        return Container();
      },
    );
  }

  BlocConsumer<BookBloc, BookState> bookStatus() {
    return BlocConsumer<BookBloc, BookState>(
      builder: (context, state) {
        // loading
        if (state is BookLoading) {
          return Center(child: CircularProgressIndicator());
        }

        // loaded
        if (state is BookLoaded) {
          selectedValue = state.book?.status;
          return Column(
            children: [
              // book status drop down menu
              DropdownButton<BookStatus>(
                hint: Text('Add To List'),
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
                      final updatedBook = widget.book.copyWith(status: value);

                      bookBloc.add(
                        UpdateBookStatus(userId: userId, book: updatedBook),
                      );

                      // update UI
                      selectedValue = value;
                    });
                  }
                },
              ),

              // status read & no review -> show add review to navigate add review page
              (state.book?.status == BookStatus.read)
                  ? (state.book?.reviewId == null)
                      ? ElevatedButton(
                        onPressed:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AddReviewPage(
                                      book: widget.book,
                                      userId: userId,
                                    ),
                              ),
                            ),
                        child: Text('Add Review'),
                      )
                      : Container()
                  : Container(),
            ],
          );
        }

        // default
        return Container();
      },
      listener: (context, state) {
        if (state is BookError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
    );
  }
}
