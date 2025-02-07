import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';

import '../styles/textField_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';

import '../styles/textField_style.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final Widget? suffix;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Color? borderColor;

  CustomTextField({
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.label,
    this.borderColor,
    this.suffix,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    // Initialize the obscureText state
    _obscureText = widget.obscureText;

    // Assign default values based on the label
    _internalController = widget.controller ?? TextEditingController();

    if (widget.label == "email") {
      _internalController.text = "omarabusalem@gmail.com";
    } else if (widget.label == "password") {
      _internalController.text = "12345678";
    }
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            (context).trans(widget.label!),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        const Gap(5),
        TextField(

          obscureText: _obscureText,
          style: const TextStyle(fontSize: 16),
          controller: _internalController,
          decoration: InputDecoration(
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : widget.suffix,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            focusedBorder: textFieldStyle,
            enabledBorder: textFieldStyle,
            border: textFieldStyle.copyWith(
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
              ),
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}