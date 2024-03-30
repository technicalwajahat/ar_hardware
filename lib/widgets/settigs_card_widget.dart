import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  const SettingCard(
      {super.key,
      required this.title,
      required this.leading,
      required this.onTap});

  final String title;
  final IconData leading;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: AutoSizeText(title),
        leading: Icon(leading),
        onTap: onTap,
      ),
    );
  }
}
