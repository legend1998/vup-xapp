import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class BannerUrls {
  @HiveField(0)
  String url;

  BannerUrls({this.url});
}
