import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gossip/models/news_headlines_model.dart';
import 'package:gossip/view/category%20screen.dart';
import 'package:gossip/view_model/newsviewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../models/news_category_model.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}
enum filterlist {TOI,recode,Science,infomoney,espn}
class _HomescreenState extends State<Homescreen> {

  filterlist? selectedmenu;
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM,dd,yyyy');
  String name='new-scientist' ;
  String Categories = "General";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Categoryscreen()));
          },
          icon: Image.asset(
            'images/menu download.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<filterlist>(
            onSelected: (filterlist item){
              if (item == filterlist.espn) {
                name = "espn";
              } else if (item == filterlist.Science) {
                name = "new-scientist";
              } else if (item == filterlist.recode) {
                name = "recode";
              } else if (item == filterlist.TOI) {
                name = "the-times-of-india";
              } else if (item == filterlist.infomoney) {
                name = "info-money";
              }

              setState(() {
                selectedmenu = item;
              });
          },
            icon: Icon(Icons.more_vert,color: Colors.black,),
              initialValue: selectedmenu,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<filterlist>> [
                PopupMenuItem<filterlist>(
                    value: filterlist.espn,
                    child: Text('Sport')),
                PopupMenuItem<filterlist>(
                    value: filterlist.Science,
                    child: Text('Science')),
                PopupMenuItem<filterlist>(
                    value: filterlist.recode,
                    child: Text('Tech')),
                PopupMenuItem<filterlist>(
                    value: filterlist.TOI,
                    child: Text('General')),
                PopupMenuItem<filterlist>(
                    value: filterlist.infomoney,
                    child: Text('Buisness')),

              ]
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.55,
              width: width,
              child: FutureBuilder<NewsHeadlinesModel>(
                  future: newsViewModel.fetchHeadlineApi(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitWave(
                          color: Colors.lightBlueAccent,
                          size: 50,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime datetime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return SizedBox(
                              child: Stack(children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * 0.9,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: SpinKitFadingCircle(
                                          color: Colors.amber,
                                          size: 50,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(38.0),
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        padding: const EdgeInsets.all(16),
                                        height: 220,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * 0.6,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                              snapshot.data!.articles![index].source?.name ??toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text(format.format(datetime),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            );
                          });
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: FutureBuilder<NewsCategoryModel>(
                    future: newsViewModel.fetchNewChannelcategory(Categories),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitChasingDots(
                            color: Colors.lightBlueAccent,
                            size: 50,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context, index) {
                              DateTime datetime = DateTime.parse(snapshot
                                  .data!.articles![index].publishedAt
                                  .toString());
                              return Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: height * 0.18,
                                          width: width * 0.3,
                                          placeholder: (context, url) =>
                                              Container(
                                                child: SpinKitFadingCircle(
                                                  color: Colors.amber,
                                                  size: 50,
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                                Icons.error_outline,
                                                color: Colors.red,
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                            height: height * 0.18,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 15),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    snapshot.data!.articles![index]
                                                        .title
                                                        .toString(),
                                                    maxLines: 3,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        color: Colors.black,fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  SizedBox(height: 30,),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .articles![index]
                                                            .source!
                                                            .name
                                                            .toString(),
                                                        maxLines: 3,
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 15,
                                                            color: Colors.black54,fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Expanded(
                                                        child: Text(
                                                          format.format(datetime),
                                                          maxLines: 3,
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 12,fontWeight: FontWeight.bold,
                                                            color: Colors.black54,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
