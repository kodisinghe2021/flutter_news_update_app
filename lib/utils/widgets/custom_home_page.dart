import 'package:flutter/material.dart';
import 'package:news_update_3_0_0_app/model/articles.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.articles,
    required this.screenSize,
    required this.index,
  }) : super(key: key);

  final List<Article>? articles;
  final Size screenSize;
  final int index;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //this text for main title
          Text(
            articles![index].title.toString(),
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 37, 59, 71)),
          ),
          // this is for image
          SizedBox(
            width: screenSize.width,
            height: screenSize.height / 4,
            child: Image.network(
              articles![index].urlToImage.toString(),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            articles![index].description.toString(),
            style: const TextStyle(
                fontSize: 10, color: Color.fromARGB(255, 37, 59, 71)),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                articles![index].publishedAt.toString(),
                style: const TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 37, 59, 71)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
