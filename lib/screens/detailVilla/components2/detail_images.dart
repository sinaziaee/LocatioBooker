import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loctio_booker/constants.dart';

class DetailImages extends StatelessWidget {
  final List<String> imagesList;
  final Size size;

  DetailImages({@required this.imagesList, this.size});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imagesList.length,
      itemBuilder: (BuildContext context, int index, int item) => Container(
        child: ClipRRect(
          child: FadeInImage(
            image: NetworkImage('$mainUrl${imagesList[index]}'),
            placeholder: AssetImage('assets/images/home_image_def.jpg'),
            fit: BoxFit.cover,
            width: size.width,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      options: CarouselOptions(
        height: 250,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {},
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
