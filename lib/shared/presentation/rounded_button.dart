import 'package:flutter/material.dart';

import 'color_constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.primaryColorAccent),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(
                color: ColorConstants.whiteColor,
              ),
            ),
          );
  }
}
