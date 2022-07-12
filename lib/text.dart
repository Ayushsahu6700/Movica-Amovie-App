import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class modified_text extends StatelessWidget {
  String text;
  Color color;
  double size;

  modified_text({required this.text, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.robotoCondensed(color: color, fontSize: size),
      overflow: TextOverflow.ellipsis,
    );
  }
}
