import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gossip/models/news_category_model.dart';
import 'package:intl/intl.dart';

import '../view_model/newsviewmodel.dart';
import 'homescreen.dart';

class Categoryscreen extends StatefulWidget {
  const Categoryscreen({super.key});

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {
  filterlist? selectedmenu;
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM,dd,yyyy');
  String Categories = "General";

  List<String> Categorieslist = [
    'General',
    'Sports',
    'Health',
    'Technoogy',
    'Entertainnment',
    'Buisness'
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Text('Explore',style: GoogleFonts.palanquinDark(),),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Categorieslist.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Categories = Categorieslist[index];
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Categories == Categorieslist[index]
                                    ? Colors.lightBlueAccent
                                    : Colors.black12,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Center(
                                  child: Text(
                                Categorieslist[index].toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              )),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
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
                            scrollDirection: Axis.vertical,
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
                                              SizedBox(height: 50,),
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
            ],
          )),
    );
  }
}
