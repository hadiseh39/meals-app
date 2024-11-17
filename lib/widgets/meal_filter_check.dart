import 'package:flutter/material.dart';

class FilterCheck extends StatelessWidget {
  const FilterCheck({super.key, required this.filter, required this.text});

  final bool filter;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: filter
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : const Icon(
              Icons.close,
              color: Colors.red,
            ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 15),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
