import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';
import '../../data/cubits/search_cubit/search_bar_cubit.dart';
import '../styles/searchBar_style.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const CustomSearchBar({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            context.read<SearchBarCubit>().clearSearch();
            context.read<SearchBarCubit>().hide();
          },
          child: const Icon(Icons.close),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        focusedBorder: searchBarStyle,
        enabledBorder: searchBarStyle,
        hintText: (context).trans('Search...'),
        border: searchBarStyle,
        filled: true,
      ),
      onChanged: (query) {
        context.read<SearchBarCubit>().updateSearchQuery(query);
      },
    );
  }
}
