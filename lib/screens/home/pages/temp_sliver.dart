import 'package:flutter/material.dart';

class TempSliver extends StatefulWidget {
  @override
  _TempSliverState createState() => _TempSliverState();
}

class _TempSliverState extends State<TempSliver> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 50.0, minHeight: 50.0),
              child: Center(child: Text('Child 1')),
            ),
            SizedBox(
              height: 200.0,
              child: PageView(
                children: <Widget>[
                  Container(
                      color: Colors.green,
                      child: Center(child: Text("Page 1"))),
                  Container(
                      color: Colors.red,
                      child: Center(child: Text("Page 2"))),
                  Container(
                      color: Colors.indigo,
                      child: Center(child: Text("Page 3"))),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
