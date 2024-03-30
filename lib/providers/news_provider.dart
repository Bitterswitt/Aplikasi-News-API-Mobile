import 'package:flutter/material.dart';
import 'package:uas/helpers/api.dart';
import 'package:uas/models/topNewsModel.dart';
import 'package:uas/utils/const.dart';

class NewsProvider with ChangeNotifier {
  bool isDataEmpty = true;
  bool isLoading = true;
  bool isLoadingSearch = true;
  TopNewsModel? resNews;
  TopNewsModel? resSearch;
  bool imageReady = false;

  setLoading(data) {
    isLoading = data;
    notifyListeners();
  }

  getTopNews() async {
    // memanggil api get news
    final res = await api(
        '${baseUrl}everything?q=apple&from=2024-01-13&to=2024-01-13&sortBy=popularity&apiKey=$apiKey');

    if (res.statusCode == 200) {
      resNews = TopNewsModel.fromJson(res.data);
    } else {
      resNews = TopNewsModel();
    }
    isLoading = false;
    notifyListeners();
  }

  search(String search) async {
    isDataEmpty = false;
    isLoadingSearch = true;
    notifyListeners();

    final res = await api('${baseUrl}everything?q=${search}&apiKey=$apiKey');

    if (res.statusCode == 200) {
      resSearch = TopNewsModel.fromJson(res.data);
    } else {
      resSearch = TopNewsModel();
    }

    isLoadingSearch = false;
    notifyListeners();
  }
}
