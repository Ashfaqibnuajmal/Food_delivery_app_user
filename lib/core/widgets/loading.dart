import 'package:flutter/material.dart';

class CustomoLoadingIndicator extends StatelessWidget {
  const CustomoLoadingIndicator({super.key, this.label});
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black45),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 4.0,
              ),
              if (label != null) ...[
                const SizedBox(height: 16),
                Text(
                  label!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ]
            ],
          ),
        )
      ],
    );
  }
}
