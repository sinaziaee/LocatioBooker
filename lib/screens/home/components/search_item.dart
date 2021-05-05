import 'package:flutter/material.dart';
import '../../../models/search_model.dart';

class SearchComponent extends StatelessWidget {
  final Size size;
  final SearchModel searchModel;
  final Function onPressed;
  final bool last;

  SearchComponent({this.size, this.searchModel, this.onPressed, this.last});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 70,
              margin: EdgeInsets.only(),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 3,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // Container(
                        //   height: 50,
                        //   width: 50,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('assets/images/home_def.jpg'),
                            image: (searchModel.url != null)
                                ? NetworkImage(searchModel.url)
                                : AssetImage('assets/images/home_def.jpg'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(
                              flex: 2,
                            ),
                            SizedBox(
                              width: size.width - 100,
                              child: Text(
                                searchModel.name,
                                // textWidthBasis: TextWidthBasis.parent,
                                style: TextStyle(
                                  // color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 4,
                            ),
                            Text(
                              // 'hormozgan, kish',
                              '${searchModel.country} ${searchModel.city}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Visibility(
          visible: !last,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            height: 0.5,
            color: Colors.grey,
            width: size.width,
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
