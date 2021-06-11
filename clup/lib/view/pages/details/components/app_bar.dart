import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final double rating;
  CustomAppBar({@required this.rating});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01),
        child: Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.30,
              width: MediaQuery.of(context).size.width * 0.1,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child:
                      SizedBox() /*SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 20,
                ),*/
                  ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    "$rating",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  //SvgPicture.asset("assets/icons/Star Icon.svg", height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
