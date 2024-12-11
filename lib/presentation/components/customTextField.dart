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

  CustomTextField({
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.label,
    this.suffix,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
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
        Text(
          (context).trans(widget.label!),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Gap(5),
        TextField(
          obscureText: _obscureText,
          style: const TextStyle(fontSize: 16),
          controller: widget.controller,
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
            border: textFieldStyle,
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
