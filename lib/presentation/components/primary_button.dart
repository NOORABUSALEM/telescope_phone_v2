import 'package:flutter/material.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';

class PrimaryButton extends StatelessWidget{
   PrimaryButton({super.key, required this.label, required this.onPressed});

  final String label;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text((context).trans(label)),
      ),
    );
  }

}