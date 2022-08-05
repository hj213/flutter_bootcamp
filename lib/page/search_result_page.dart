import 'package:flutter/material.dart';
import 'package:my_photo/model/photo.dart';
import 'package:my_photo/providers.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SearchResultPage extends StatefulWidget{

  static const routeName = '/photos';
  final String searchTerm ;

  const SearchResultPage(this.searchTerm, {Key? key}): super(key:key);

  @override
  State<StatefulWidget> createState() => _SearchResultPageState();

}

class _SearchResultPageState extends State<SearchResultPage> {

  final photos = <Photo>[];

  int currentPage = 1;

  int? totalPages;

  @override
  void initState() {
    super.initState();
    _fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchTerm),
      ),
      body: _buildList(),
    );
  }

  Widget _buildCard(Photo photo) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 500,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                      photo.userProfileImageUrl,
                      width: 36.0,
                      height: 36.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(photo.username),
                ),
              ),
              AspectRatio(
                aspectRatio: photo.width / photo.height,
                child: Image.network(photo.previewUrl),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        analyticsService().favorite(photo.id);
                      },
                      icon: const Icon(Icons.favorite_border),
                      label: Text('좋아요 ${photo.likes}개'),
                    ),
                    TextButton(
                      onPressed: () {
                        analyticsService().viewOriginal(photo.id);
                        launchUrlString(photo.downloadUrl);
                      },
                      child: const Text('원본 보기'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    final hasNextPage = totalPages != null && currentPage < totalPages!;
    return ListView.builder(
      itemCount: hasNextPage ? photos.length + 1 : photos.length,
      itemBuilder: (context, index) {
        if (index == photos.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ActionChip(
              backgroundColor: Theme.of(context).primaryColor,
              label: const Text(
                '더 많은 사진 보기',
                style: TextStyle(color: Colors.white),
              ),
              elevation: 12.0,
              onPressed: () {
                _fetchPhotos();
              },
            ),
          );
        }
        return _buildCard(photos[index]);
      },
    );
  }



  void _fetchPhotos(){
    photoService().search(widget.searchTerm, currentPage).then((result){
      setState((){
        currentPage ++;
        totalPages = result.totalPages;
        photos.addAll(result.results);
      });
    }, onError: (e){
     debugPrint(e.toString());
    });
  }
}