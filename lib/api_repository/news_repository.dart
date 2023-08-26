import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gossip/models/news_category_model.dart';
import 'package:http/http.dart'as  http;
import 'package:gossip/models/news_headlines_model.dart';

class NewsRepository{

  Future<NewsHeadlinesModel> fetchNewChannelHeadlinesApi(String channelName)async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=d75fe0368d684773b5dae83d02f21470' ;
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
  Future<NewsCategoryModel> fetchNewsChannelcategory(String category) async {
    if (category.isNotEmpty) {
      String apiKey = 'd75fe0368d684773b5dae83d02f21470';
      String url =
          'https://newsapi.org/v2/everything?q=$category&apiKey=$apiKey';
      print(url);
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return NewsCategoryModel.fromJson(body);
      }
      throw Exception('Error');
    } else {
      throw Exception('Category is empty');
    }
  }

}
