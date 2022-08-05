import 'package:dio/dio.dart';

import '../model/search_result.dart';

const _accessKey = 'HggGIBjZ5iO7ZDS1gGtj3-AIYfwnv8tlcbayFEws1vo';

class PhotoService {
  Future<SearchResult> search(String searchTerm, int page) async {
    try {
      final response = await Dio().get(
        'https://api.unsplash.com/search/photos',
        queryParameters: {
          'query': searchTerm,
          'page': page,
        },
        options: Options(
          headers: {
            'Accept-Version': 'v1',
            'Authorization': 'Client-ID $_accessKey',
          },
        ),
      );
      return SearchResult.from(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }
}
