import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class detailVillaScreen extends StatefulWidget {
  static String id = 'detail_Villa_Screen';
  final String ownerName;
  final int price;
  final String images;
  final int capacity;

  const detailVillaScreen
      ({Key key, this.ownerName, this.price, this.images, this.capacity}) : super(key: key);




  @override
  _detailVillaScreenState createState() => _detailVillaScreenState();
}

class _detailVillaScreenState extends State<detailVillaScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  ListView _imagesListView(data){
    return ListView.builder(
        itemBuilder:  (context , index){
          return _tile(data[index].position , data[index].image);
        },
        itemCount: data.length,

    );
  }

  ListTile _tile() => ListTile(

  );

   _fetchImages(int id) async{
    final url = 'https://softcheetahs.herokuapp.com/api/villa/user/?villa_id=$id';
    final response = await http.get(url);



    if(response.statusCode == 200){

      print(response.body.toString());

    }

    else{
      throw exception('Exception');
    }



  }


}
