import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_update_3_0_0_app/model/articles.dart';

class APIConnect {
  final newsUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=03a03e766dcc4d75a0ece81ad05a00a2';

  Future<List<Article>> getNews() async {
    // this method for sending response
    Response response = await http.get(Uri.parse(newsUrl));

// this is the list for getting response
    List<Article> articles = [];
// check the status code is 200(succes) or not
    if (response.statusCode == 200) {
      // the json body insert to th Map of <key = String, value = dynamic> map and its name json
      Map<String, dynamic> json = jsonDecode(response.body);

      //this list name is body and above Map have key = articles that value insert to this list
      List<dynamic> body = json['articles'];

    articles = body.map((dynamic item) => Article.fromJson(item)).toList();
    } else {
      print("Error");
    }

    return articles;
  }
}
