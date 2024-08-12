import 'package:portal_eclb/model/entity/entity_object.dart';
import 'package:portal_eclb/model/entity/patrimony/media/type_of_media_entity_object.dart';
import 'package:portal_eclb/model/patrimony/media/media.dart';

abstract interface class MediaEntityObject implements Media, EntityObject {

  /// O tipo de mídia associado ao objeto de mídia.
  ///Future<TypeOfMediaEntityObject?> get typeOfMedia;
}