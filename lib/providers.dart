import 'package:my_photo/service/analytics_service.dart';
import 'package:my_photo/service/photo_service.dart';

AnalyticsService? _analyticsService;

PhotoService? _photoService;

AnalyticsService analyticsService() =>_analyticsService ??= AnalyticsService();

PhotoService photoService() => _photoService ??= PhotoService();
