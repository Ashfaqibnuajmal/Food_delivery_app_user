import 'package:flutter/material.dart';
import 'package:mera_app/core/theme/text_style.dart';

class isUserSignin extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onPressed;

  const isUserSignin({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questionText,
            style: anyColorTextStyle.copyWith(color: Colors.black),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(actionText, style: orangeTextStyle),
          ),
        ],
      ),
    );
  }
}
