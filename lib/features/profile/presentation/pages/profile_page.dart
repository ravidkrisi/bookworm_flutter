import 'dart:io';
import 'dart:typed_data';
import 'package:bookworm/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:bookworm/features/auth/presentation/blocs/auth_event.dart';
import 'package:bookworm/features/auth/presentation/components/my_button.dart';
import 'package:bookworm/features/books/presentation/components/books_list.dart';
import 'package:bookworm/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:bookworm/features/profile/presentation/blocs/profile_event.dart';
import 'package:bookworm/features/profile/presentation/blocs/profile_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? selectedImage;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(
      ProfileFetchUserPorfileRequested(uid: widget.uid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileErrors) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is ProfileLoaded) {
          return Scaffold(
            appBar: AppBar(title: Text(state.user.name ?? '')),
            body: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // profile image
                  profileImage(state.user.profileImageUrl ?? ''),

                  SizedBox(height: 20),

                  // email
                  Text(state.user.email),

                  SizedBox(height: 20),

                  // books list
                  Text(
                    'My Books',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  state.user.books != null
                      ? BooksList(books: state.user.books!, showStatus: true)
                      : Text('No Books'),

                  // logout btn
                  SizedBox(
                    width: 120,
                    child: MyButton(
                      text: 'Logout',
                      onPressed:
                          () => context.read<AuthBloc>().add(
                            AuthLogoutRequested(),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  SizedBox profileImage(String imageUrl) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          selectedImage != null
              ? CircleAvatar(
                radius: 100,
                backgroundImage: MemoryImage(selectedImage!),
              )
              : CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                errorWidget:
                    (context, url, error) => CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 100,
                      child: Icon(Icons.person, size: 75),
                    ),
                placeholder:
                    (context, url) =>
                        Center(child: CircularProgressIndicator()),
                imageBuilder:
                    (context, imageProvider) => CircleAvatar(
                      radius: 100,
                      backgroundImage: imageProvider,
                    ),
              ),
          RawMaterialButton(
            onPressed: onEditImagePressed,
            fillColor: Theme.of(context).colorScheme.primary,
            shape: CircleBorder(),
            padding: EdgeInsets.all(8),
            child: Icon(FontAwesomeIcons.camera),
          ),
        ],
      ),
    );
  }

  void onEditImagePressed() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      Uint8List bytes = await File(image.path).readAsBytes();
      setState(() {
        selectedImage = bytes;
      });

      context.read<ProfileBloc>().add(
        ProfileUpdateProfileImageRequested(uid: widget.uid, imagePath: bytes),
      );
    }
  }
}
