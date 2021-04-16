import 'package:flutter/material.dart';

class FacilitateItem extends StatelessWidget {
  final String text;
  final int count;
  final Function onIncrease, onDecrease;

  FacilitateItem({this.text, this.count, this.onDecrease, this.onIncrease});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(text ?? 'text'),
          Spacer(),
          // MaterialButton(
          //   color: Colors.blueGrey,
          //   onPressed: onIncrease,
          //   shape: CircleBorder(),
          //   child: Center(
          //     child: Icon(Icons.add),
          //   ),
          // ),
          IconButton(icon: Icon(Icons.add), onPressed: onIncrease),
          Text(count.toString() ?? 'text'),
          // MaterialButton(
          //   onPressed: onDecrease,
          //   shape: CircleBorder(),
          //   child: Center(
          //     child: Text('-', style: TextStyle(fontSize: 40),),
          //   ),
          // ),
          IconButton(icon: Icon(Icons.minimize), onPressed: onDecrease)
        ],
      ),
    );
  }
}
