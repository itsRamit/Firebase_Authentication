import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  String title;
  bool loading;
  VoidCallback onPressed;
  RoundButton({super.key, required this.title, required this.onPressed,this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 175,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
        ),
        child:!loading?Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ):CircularProgressIndicator(color:Colors.white,)
      ),
    );
  }
}
