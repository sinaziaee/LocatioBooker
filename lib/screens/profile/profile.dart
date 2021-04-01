import 'package:flutter/cupertino.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/static_methods.dart';

class profile extends StatefulWidget {
  static String id = 'profile_page';

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {


  User user;
  _getPreferences() async{
    user = await StaticMethods.getPreferences();

    print(user.firstName);
  }


  @override
  void initState() {
    _getPreferences();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
