import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_robinhood/styles/styles.dart';

class FreeStockButton extends StatelessWidget {
  const FreeStockButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: 130,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: Styles.color_positiveAccent,
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.gift,
            color: Styles.color_positive,
            size: 16,
          ),
          SizedBox(width: 4.0),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text("Free Stock",
                style: TextStyle(
                  color: Styles.color_positive,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ],
      ),
    );
  }
}
