import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 100, color: Colors.white,),
        const SizedBox(height: 16,),
        Text(title, style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w400, color: Colors.white),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}


