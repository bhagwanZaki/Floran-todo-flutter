import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Appbar extends StatelessWidget {
  const Appbar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Floran Todo".text.xl3.bold.color(context.theme.accentColor).make(),
      ],
    );
  }
}