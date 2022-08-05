import 'package:my_photo/model/photo.dart';

class SearchResult {
  final int total;
  
  final int totalPages;
  
  final List<Photo> results;
  
  SearchResult.from(dynamic source)
      : total = source['total'],
        totalPages = source['total_pages'],
        results =
        List.from(source['results']).map((e) => Photo.from(e)).toList(); //map -> 타입을 변환해줌
  const SearchResult(this.total, this.totalPages, this.results);
}
