import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService{
  void favorite(String photoId){
    FirebaseAnalytics.instance.logEvent(
        name: 'favorite_photo',
        parameters: {
          "id" : photoId,
        },
    );
  }

  void search(String searchTerm){
    FirebaseAnalytics.instance.logSearch(searchTerm: searchTerm);
  }

  void viewOriginal (String photoId){
    FirebaseAnalytics.instance.logEvent(
        name: 'view_original_photo',
        parameters: {
          'id':photoId,
        },
    );
  }
}