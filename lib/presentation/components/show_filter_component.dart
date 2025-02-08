import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';
import 'package:telescope_phone_v2/core/styles/color_constants.dart';

void showFilterDialog(BuildContext context, {required Function(String?, String?) onApply}) {
  String? selectedPositive;
  String? selectedType;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(context.trans("Filters")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedPositive,
              onChanged: (value) => selectedPositive = value,
              decoration: InputDecoration(labelText: context.trans("Direction")),
              items: [
                DropdownMenuItem(value: 'positive', child: Text(context.trans("Positive Direction"))),
                DropdownMenuItem(value: 'negative', child: Text(context.trans("Negative Direction"))),
                DropdownMenuItem(value: 'any', child: Text(context.trans("Both Direction"))),
              ],
            ),
            DropdownButtonFormField<String>(
              value: selectedType,
              onChanged: (value) => selectedType = value,
              decoration: InputDecoration(labelText: context.trans("Type")),
              items: [
                DropdownMenuItem(value: 'numeric', child: Text(context.trans("Numeric"))),
                DropdownMenuItem(value: 'percentage', child: Text(context.trans("Percentage"))),
                DropdownMenuItem(value: 'money', child: Text(context.trans("Money"))),
                DropdownMenuItem(value: 'other', child: Text(context.trans("Other"))),
                DropdownMenuItem(value: 'all', child: Text(context.trans("All"))),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(

            onPressed: () {
              onApply(selectedPositive, selectedType);
              Navigator.pop(context);
            },
            child: Text(context.trans("Apply"), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      );
    },
  );
}