import 'package:flutter/material.dart';
import 'package:news_update_3_0_0_app/controllers/auth_controller.dart';
import 'package:news_update_3_0_0_app/model/articles.dart';
import 'package:news_update_3_0_0_app/services/api_connect.dart';
import 'package:news_update_3_0_0_app/utils/widgets/custom_home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  APIConnect client = APIConnect();
 // FirebaseAuth mAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // get screen size
    final screenSize = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Daily News Updates"),
          actions: [
            IconButton(
              onPressed: () {
                AuthController().userSignOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: FutureBuilder(
          future: client.getNews(),
          builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article>? articles = snapshot.data;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: articles!.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    elevation: 20,
                    color: Color.fromARGB(255, 219, 202, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewsCard(
                        articles: articles,
                        screenSize: screenSize,
                        index: index,
                      ),
                    ),
                  );
                },
              ); //Center(child: Text(articles[index].title!))
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ), //future builder
      ),
    );
  }
}

