import 'package:flutter/material.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}
