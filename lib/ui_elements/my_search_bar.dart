import 'package:flutter/material.dart';

// A simple search bar
class MySearchBar extends StatelessWidget{
  final String hint;

  MySearchBar({
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 14, top: 8, right: 4),
            child: TextField(
              decoration: InputDecoration(
                hintText: hint,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onChanged: (value) {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 14),
          child: IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}