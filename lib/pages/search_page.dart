import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas/component/news.dart';
import 'package:uas/providers/news_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
        builder: (BuildContext context, news, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pencarian'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Pencarian Berita',
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          news.search(searchController.text);
                        },
                        icon: Icon(Icons.send))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                news.isDataEmpty
                    ? const SizedBox()
                    : news.isLoadingSearch
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              ...news.resSearch!.articles!.map(
                                (e) => News(
                                  title: e.title ?? '',
                                  image: e.urlToImage ?? '',
                                ),
                              )
                            ],
                          ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
