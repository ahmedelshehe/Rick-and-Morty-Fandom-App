import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class DetailTile extends StatelessWidget {
  const DetailTile({
    Key? key, required this.title, required this.text,
  }) : super(key: key);
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: myYellow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: Text(title,
                style: TextStyle(
                  color: myBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          Flexible(
            flex: 2,
            child: Text(text,
                style: TextStyle(
                  color: myBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis
                )),
          ),
        ],
      ),
    );
  }
}