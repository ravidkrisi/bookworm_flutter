import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Icon? prefixIcon;
  final String text;
  final void Function()? onPressed;
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon
              prefixIcon != null
                  ? Row(children: [prefixIcon!, SizedBox(width: 10)])
                  : Container(),

              // text
              Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
