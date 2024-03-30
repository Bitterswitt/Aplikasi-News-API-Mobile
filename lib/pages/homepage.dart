import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas/component/news.dart';
import 'package:uas/pages/search_page.dart';
import 'package:uas/providers/news_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getNews() {
    Provider.of<NewsProvider>(context, listen: false).getTopNews();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
        builder: (BuildContext context, news, Widget? child) {
      return RefreshIndicator(
        onRefresh: () async {
          news.setLoading(true);
          return await getNews();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('InterNews Daily'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()),
                      );
                    },
                    icon: Icon(Icons.search)),
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                news.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          ...news.resNews!.articles!.map(
                            (e) => News(
                              title: e.title ?? '',
                              image: e.urlToImage ?? '',
                            ),
                          )
                        ],
                      ),
              ],
            ),
          )),
        ),
      );
    });
  }
}
