import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Gradient? Gradientcolor;
  final Color? backColor;

  final VoidCallback onPressed;
  final double height;
  final TextStyle? textStyle; // Add textStyle parameter
  final FontWeight fontWeight; // Add fontWeight parameter

  const CustomActionButton({
    required this.text,
    this.icon,
    required this.onPressed,
    this.Gradientcolor,
    this.backColor,
    required this.height,
    this.textStyle, // Allow textStyle to be nullable
    this.fontWeight = FontWeight.normal, // Default fontWeight to normal
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: MediaQuery.of(context).size.height * height,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: backColor,
            gradient: Gradientcolor, // Use the provided gradient
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            // Center both icon and text or just text based on icon presence
            mainAxisAlignment: icon != null
                ? MainAxisAlignment.center // Center when icon is present
                : MainAxisAlignment.center, // Space evenly when no icon

            children: [
              // Conditionally display the icon if provided
              if (icon != null)
                Icon(
                  icon,
                  color: Colors.white,
                ),
              if (icon != null)
                SizedBox(width: 8.0), // Spacing between icon and text
              Text(text, style: textStyle)
            ],
          ),
        ),
      ),
    );
  }
}
