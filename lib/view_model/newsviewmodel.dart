import 'package:gossip/api_repository/news_repository.dart';
import 'package:gossip/models/news_category_model.dart';
import 'package:gossip/models/news_headlines_model.dart';

class NewsViewModel{
    final _repo = NewsRepository();

    Future<NewsHeadlinesModel> fetchHeadlineApi(String channelName) async{
        final response = await _repo.fetchNewChannelHeadlinesApi(channelName);
        return response ;
    }


    Future<NewsCategoryModel>fetchNewChannelcategory(String category) async{
        final response = await _repo.fetchNewsChannelcategory(category);
        return response ;
    }

    }
