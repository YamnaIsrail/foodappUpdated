import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? titleColor;
  final Color? backgroundColor;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onLeadingPressed;
  final VoidCallback? onTrailingPressed;
  final List<Widget>? actions;

  SimpleAppBar({
    this.title,
    this.titleColor,
    this.backgroundColor,
    this.leadingIcon,
    this.trailingIcon,
    this.onLeadingPressed,
    this.onTrailingPressed,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: titleColor ?? Colors.white),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: primaryGradient,
        ),
      ),
      leading: leadingIcon != null
          ? IconButton(
        icon: Icon(leadingIcon),
        onPressed: onLeadingPressed,
      )
          : null,
      actions: [
        if (trailingIcon != null)
          IconButton(
            icon: Icon(trailingIcon),
            onPressed: onTrailingPressed,
          ),
        ...(actions ?? []),
      ],
      centerTitle: true,
      title: Text(
        title ?? "",
        style: TextStyle(fontSize: 45.0, letterSpacing: 3, color: titleColor ?? Colors.white, fontFamily: "Signatra"),
      ),
    );
  }
}