import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/villa.dart';
import '../../../models/search_model.dart';

class HostPlaceItem extends StatelessWidget {
  final Size size;
  final Villa villa;
  final Function onPressed, onHidePressed;
  final bool last;

  HostPlaceItem({
    this.size,
    this.villa,
    this.onPressed,
    this.last,
    this.onHidePressed,
  });

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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            height: 60,
                            width: 50,
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('assets/images/home_def.jpg'),
                            image: (villa.images != null)
                                ? NetworkImage('$mainUrl${villa.images[0]}')
                                : AssetImage('assets/images/home_def.jpg'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              SizedBox(
                                width: size.width - 180,
                                child: Text(
                                  villa.name,
                                  // textWidthBasis: TextWidthBasis.parent,
                                  style: TextStyle(
                                    // color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                '${villa.country}, ${villa.city}',
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
                        ),
                        Container(
                          // width: 200,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: onHidePressed,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text(
                                    villa.isVisible ? 'hide ' : 'unhide ',
                                    style: kBody3TextStyle.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Icon(
                                    villa.isVisible
                                        ? Icons.check_circle
                                        : Icons.remove_circle,
                                    color: (villa.isVisible)
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
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
