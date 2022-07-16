import 'package:flutter/material.dart';

// #docregion CustomButton
class CustomButton extends StatelessWidget {
  const CustomButton(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}
// #enddocregion CustomButton

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  // #docregion UseCustomButton
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomButton('Hello'),
    );
  }
  // #enddocregion UseCustomButton
}
