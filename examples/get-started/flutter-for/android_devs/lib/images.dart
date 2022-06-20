import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
        image:
            // #docregion AssetImage
            AssetImage('images/my_icon.jpeg')
        // #enddocregion AssetImage
        );
  }
}

class ImageExample extends StatelessWidget {
  const ImageExample({Key? key}) : super(key: key);

  // #docregion Imageasset
  @override
  Widget build(BuildContext context) {
    return Image.asset('images/my_image.png');
  }
  // #enddocregion Imageasset
}
