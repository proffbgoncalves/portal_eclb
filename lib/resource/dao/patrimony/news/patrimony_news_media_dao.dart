import 'package:portal_eclb/model/patrimony/news/patrimony_news_media.dart';
import 'package:portal_eclb/resource/dao/dao.dart';

abstract interface class PatrimonyNewsMediaDAO implements DAO{
  Future<PatrimonyNewsMedia> findByDescription(String description);


}