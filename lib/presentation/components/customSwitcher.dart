import 'package:flutter/material.dart';
import '../../core/styles/color_constants.dart';

class CustomSwitcher extends StatefulWidget {
  final List<String> options;
  final ValueChanged<int> onSelectionChanged;

  const CustomSwitcher({
    Key? key,
    required this.options,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _CustomSwitcherState createState() => _CustomSwitcherState();
}

class _CustomSwitcherState extends State<CustomSwitcher> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.lightTextColor
            : AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.options.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onSelectionChanged(_selectedIndex);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ? Theme.of(context).brightness == Brightness.dark
                          ? AppColors.secondary
                          : AppColors.backgroundColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.options[index],
                  style: TextStyle(
                    color: _selectedIndex == index
                        ? Theme.of(context).brightness == Brightness.dark
                            ? AppColors.lightTextColor
                            : AppColors.darkBackgroundColor
                        : AppColors.greyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
