import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.facebook_outlined),
    );
  }
}

class MyImageButton extends StatelessWidget {
  const MyImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(40),
      splashColor: Colors.grey.shade600,
      child: const ImageIcon(
        AssetImage('assets/images/twitterOLd.png'),
        // size: 1,
      ),
    );
  }
}
