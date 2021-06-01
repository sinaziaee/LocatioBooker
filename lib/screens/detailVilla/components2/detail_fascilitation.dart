import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/facilitation.dart';

class DetailFacilitation extends StatelessWidget {
  final List facilitationItems;
  final Size size;
  int count = 0;

  DetailFacilitation({this.facilitationItems, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Accommodation facilities',
              style: kBody1TextStyle.copyWith(
                fontSize: 18,
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          for (int i = 0; i < facilitationItems.length; i++) ...[
            if (i <= 4) ...[
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: itemBuilder(facilitationItems[i]),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  if (i + 1 < facilitationItems.length) ...[
                    Flexible(
                      flex: 1,
                      child: itemBuilder(facilitationItems[++i]),
                    ),
                  ] else ...[
                    Flexible(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ] else ...[
              if (++count == 1) ...[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'All facilities'
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              content: Container(
                                height: 400,
                                width: 300,
                                child: Expanded(
                                  child: ListView.builder(
                                    itemCount: facilitationItems.length,
                                    itemBuilder: (context, index) {
                                      return itemBuilder(facilitationItems[index]);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Center(
                          child: Text(
                            'See All facilities (${facilitationItems.length} items)',
                            style: kBody1TextStyle.copyWith(
                              color: Colors.blueGrey[700],
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ],
        ],
      ),
    );
  }

  itemBuilder(String text) {
    return Row(
      children: [
        Text(text),
        Spacer(),
        Image.asset(
          Facilitation.getImage(text),
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        )
      ],
    );
  }
}
