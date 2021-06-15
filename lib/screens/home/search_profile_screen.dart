import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loctio_booker/components/person_item.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/screens/chat/chat_screen.dart';
import 'dart:convert' as convert;
import 'components/custom_profile_not_found.dart';
import 'components/custom_profile_search.dart';
import '../../constants.dart';

class SearchProfileScreen extends StatefulWidget {
  static String id = 'search_profile_screen';

  @override
  _SearchProfileScreenState createState() => _SearchProfileScreenState();
}

class _SearchProfileScreenState extends State<SearchProfileScreen> {
  TextEditingController searchController;
  String url = '$mainUrl/api/account/properties/all';
  String addChatUrl = '$mainUrl/api/chat/add/';
  String getChatUrl = '$mainUrl/api/chat/show/';
  User user;
  Map args;
  Size size;

  List<String> currentUsersList = [];
  List<Map> currentUsersMapList = [];

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    size = MediaQuery.of(context).size;
    user = args['user'];
    // print('$url${(searchController.text.length != 0) ? '?search=${searchController.text}' : ''}');
    print(
        '$url?search=${(searchController.text.length != 0) ? searchController.text : null}');
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: PreferredSize(
        child: Container(
          margin: EdgeInsets.only(
            top: 40,
          ),
          color: Colors.lightBlue,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        cursorWidth: 1,
                        style: TextStyle(),
                        cursorColor: Colors.black,
                        decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: 'Who do you want to search for?',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: searchController.text.isNotEmpty,
                      child: IconButton(
                        color: Colors.grey,
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size(size.height, 80),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              http.Response response = snapshot.data;
              // print(response.statusCode);
              // print(response.body);
              var jsonResponse = convert.jsonDecode(response.body);
              List<User> mapList = [];
              int count = 0;
              for (Map map in jsonResponse) {
                count++;
                User user = User.fromJson(map);
                mapList.add(user);
              }
              if (count == 0 &&
                  '$url?search=${(searchController.text.length != 0) ? searchController.text : null}'
                      .endsWith('null')) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: CustomProfileSearch(),
                  ),
                );
              }
              if (count == 0) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: CustomProfileNotFound(),
                  ),
                );
              }
              if (response.statusCode < 400) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return itemBuilder(mapList[index], !(index == count - 1));
                  },
                  itemCount: count,
                );
              } else {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('An Error happened'),
                  ),
                );
              }
            } else {
              return Container(
                color: Colors.white,
                child: Center(
                  child: kMyProgressIndicator,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget itemBuilder(User user, bool isVisible) {
    return PersonItem(
      user,
      size,
      isVisible,
      () {
        onChatPressed(user);
      },
    );
  }

  getChats(User user) async {
    http.Response response = await http.get(
      Uri.parse(
        getChatUrl,
      ),
      headers: {
        HttpHeaders.authorizationHeader: user.token,
      },
    );
    print('----------------------------------------------');
    print(response.statusCode);
    print(response.body);
    print('----------------------------------------------');
    var jsonResponse = convert.json.decode(response.body);
    List mapList = jsonResponse['data'];
    for (Map each in mapList) {
      currentUsersList.add('${each['first_name']} ${each['last_name']}');
      currentUsersMapList.add(each);
    }
  }

  getUsers() async {
    http.Response response = await http.get(
      Uri.parse(
          '$url?search=${(searchController.text.length != 0) ? searchController.text : null}'),
      headers: {
        HttpHeaders.authorizationHeader: user.token,
      },
    );
    // print(response.body);
    getChats(user);

    return response;
  }

  onChatPressed(User user) async {
    String currentUsername = '${user.firstName} ${user.lastName}';
    int index;
    if (currentUsersList.contains(currentUsername)) {
      index = currentUsersList.indexOf(currentUsername);
    } //
    else {
      http.Response response = await http.post(
        Uri.parse(addChatUrl),
        headers: {
          HttpHeaders.authorizationHeader: user.token,
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: convert.json.encode(
          {
            // todo
          },
        ),
      );
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return ChatScreen(user: user, chatRoomId: chatRoomId, otherUser: otherUser, otherUserImageUrl: otherUserImageUrl)
    //     },
    //   ),
    // );

  }
}
