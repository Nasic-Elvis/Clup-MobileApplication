import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: (28/ 375.0)* MediaQuery.of(context).size.height,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.greenAccent,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: (20/ 375.0)* MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}