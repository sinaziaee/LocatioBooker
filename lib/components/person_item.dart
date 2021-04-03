import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';

class PersonItem extends StatelessWidget {
  final String assetUrl = 'assets/images/unknown_person.png';
  final User user;
  final Size size;
  final bool isVisible;
  PersonItem(this.user, this.size, this.isVisible);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          child: ListTile(
            leading: CircleAvatar(
              radius: 21,
              backgroundColor: Colors.red,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: (user.image != null)
                    ? NetworkImage(user.image)
                    : AssetImage(assetUrl),
              ),
            ),
            title: Text(
              '${user.firstName} ${user.lastName}',
              style: kHeaderTextStyle,
            ),
            subtitle: Text(
              user.email,
              style: kBodyTextStyle,
            ),
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Container(
            height: 0.5,
            color: Colors.grey,
            margin: EdgeInsets.only(
              left: size.width * 0.17,
              right: size.width * 0.03
            ),
          ),
        ),
      ],
    );
  }
}
