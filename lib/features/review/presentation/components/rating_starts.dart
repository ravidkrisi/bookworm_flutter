import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RatingStarts extends StatelessWidget {
  final int rating;
  const RatingStarts({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Icon(
          FontAwesomeIcons.star,
          size: 16,
          color: index < rating ? Colors.yellow : Colors.grey,
        ),
      ),
    );
  }
}
