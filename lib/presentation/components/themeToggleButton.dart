import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/cubits/theme_cubit/theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return Switch(
          value: theme.brightness == Brightness.dark,
          // True if dark theme is active
          onChanged: (value) {
            context
                .read<ThemeCubit>()
                .toggleTheme(); // Toggle theme when switched
          },
        );
      },
    );
  }
}
