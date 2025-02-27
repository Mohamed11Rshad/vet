
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:vetdrugegy/Controllers/UserController.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/Constants.dart';
import 'package:vetdrugegy/Models/Podcasts.dart';
import 'package:vetdrugegy/Views/Shared/BaseAppBar.dart';
import 'package:vetdrugegy/Views/VideoPlayerView.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';


class CourseDetailsView extends StatefulWidget {

  const CourseDetailsView(
      {Key? key})
      : super(key: key);

  @override
  CourseDetailsViewState createState() => CourseDetailsViewState();
}

class CourseDetailsViewState extends State<CourseDetailsView> {
  late List<Podcasts>? _userModel = [];
  late List<String>? lecturesUrls = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData() async {
    // From Advanced Search

    _userModel = (await UserController().GetPodcasts());
    setState(() {

    });
 }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
    appBar: BaseAppBar(
          appBar: AppBar(), widgetContext: context, showBackButton: true),
      body:
         LiquidPullToRefresh(
        onRefresh: getData,
        child: ListView.builder(
          shrinkWrap: true,
          cacheExtent: 1500,
          itemCount: _userModel!.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 200.0,
                child: FadeInAnimation(
                  child: Card(
                      margin: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          print("${_userModel![index].toJson()} ===============");
                          /* context.navigateTo(
                                      DetailsView(ad: _userModel![index]));*/
                        },
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  //apply padding to all four sides
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "https://img.youtube.com/vi/"+_userModel![index].url!+"/0.jpg",

                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    height: context.screenHeight * 0.17,
                                  )),
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth:
                                              context.screenWidth *
                                                  0.5),
                                          child: Text(
                                            _userModel![index]
                                                .name
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black),
                                            textAlign: TextAlign.start,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(

                                            /*  _userModel![index]
                                                  .ContentPrice
                                                  ==0 ? "محتوى مجاني" : ""*/
                                              ""
                                              ,
                                              style: TextStyle(
                                                  color: Colors.deepOrange),
                                              textAlign: TextAlign.start,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [

                                        SizedBox(width: 10),
                                        Container(
                                          width: context.screenWidth*.3,
                                          child: TextButton(
                                              child: Text(
                                                  "مشاهدة".toUpperCase(),
                                                  style: TextStyle(fontSize: 12)
                                              ),
                                              style: ButtonStyle(
                                                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                                                  foregroundColor: MaterialStateProperty.all<Color>(appDesign.colorPrimary),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                          side: BorderSide(color: appDesign.colorPrimary)
                                                      )
                                                  )
                                              ),
                                              onPressed: () =>
                                              {
                                             
                                                  context.navigateTo(
                                                      VideoPlayerView(videoUrl:_userModel![index]!.url!))}
                                                 

                                              
                                          ),
                                        )
                                      ]
                                  )


                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            );

          },
        ),
      ),


    );
  }
}