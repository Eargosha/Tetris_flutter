// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
/// Author: Eargosha
import 'package:flutter/material.dart';

/// Каждый отдельный пиксель, что показывается на Grid
class Pixel extends StatelessWidget {
  // цвет пикселя
  var color;
  Pixel({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
      margin: const EdgeInsets.all(2),
    );
  }
}
