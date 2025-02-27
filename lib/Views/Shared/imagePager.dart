import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vetdrugegy/Models/Constants.dart';
import 'package:vetdrugegy/Views/Shared/Loader.dart';

class ImagePager extends StatefulWidget {
  final String? screenname;

  ImagePager({this.screenname});
  @override
  _ImagePagerState createState() => _ImagePagerState();
}

class _ImagePagerState extends State<ImagePager> {
 late List<String> carouselData;

  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
       carouselData = [


    'https://backend.vetdrugegy.com/imgCarousel/'+widget.screenname!+'1.jpg',
    'https://backend.vetdrugegy.com/imgCarousel/'+widget.screenname!+'2.jpg',
    'https://backend.vetdrugegy.com/imgCarousel/'+widget.screenname!+'3.jpg',
    'https://backend.vetdrugegy.com/imgCarousel/'+widget.screenname!+'4.jpg',
    'https://backend.vetdrugegy.com/imgCarousel/'+widget.screenname!+'5.jpg',
    'https://backend.vetdrugegy.com/imgCarousel/'+widget.screenname!+'6.jpg',
    'https://backend.vetdrugegy.com/imgCarousel/'+widget.screenname!+'7.jpg',
    'https://backend.vetdrugegy.com/imgCarousel/'+widget.screenname!+'8.jpg',
    'https://backend.vetdrugegy.com/imgCarousel/'+widget.screenname!+'9.jpg'
  ];

      _startAutoScroll();
 

  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }
  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < carouselData.length-1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Stack(

      children: [
        Container(

          height:  270,
          child: PageView(
            allowImplicitScrolling: true,
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children:  
            carouselData.map(
                    (url) => GestureDetector(
                    child: Image.network(
                      fit: BoxFit.fill,
                              url,
                               errorBuilder: (context, error, stackTrace) => Image.asset("images/applogo.png",fit: BoxFit.fill,),)
                 
                )).toList(),
          ),
        ),

        // Container(
        //   padding: EdgeInsets.symmetric(vertical:5 ),
        //   alignment: Alignment.bottomCenter,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: List<Widget>.generate(widget.imageUrls?.length ?? carouselData.length, (int index) {
        //       return Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 4.0),
        //         child: Container(
        //           width: 8.0,
        //           height: 8.0,
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: _currentPage == index ? Colors.white : Colors.grey,
        //           ),
        //         ),
        //       );
        //     }),
        //   ),
        // ),
      ],
    );
  }
}
