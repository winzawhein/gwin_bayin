import 'package:flutter/material.dart';

class CustomThemeSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomThemeSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomThemeSwitch> createState() => _CustomThemeSwitchState();
}

class _CustomThemeSwitchState extends State<CustomThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    // Dimensions matched to the screenshot aspect ratio
    const double width = 70.0;
    const double height = 40.0;
    const double handleSize = 37.0;
    const double padding = 1.0;
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          // Dark track color matching the image background
          color:!widget.value?Colors.grey: surfaceColor,
        ),
        padding: const EdgeInsets.all(padding),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: widget.value
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            width: handleSize,
            height: handleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Crimson red handle color from the image
              color: !widget.value ? Colors.white24 : Color(0XFFE63E46),
            ),
            child: Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                // Show the moon icon when active (true)
                opacity: 1,
                // widget.value ? 1.0 : 0.0,
                child: Icon(
                  !widget.value
                      ? Icons.sunny
                      : Icons.dark_mode, // Yields a clean crescent moon shape
                  color: Color(0XFFFCD14D), // Sun/Moon yellow hex code
                  size: 26,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
