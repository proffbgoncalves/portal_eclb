import 'package:portal_eclb/model/patrimony/exposition/exposition.dart';

class ExpositionDTO implements Exposition {
  int? _id;
  String? _name;
  String? _description;

  ExpositionDTO({
    int? id,
    String? name,
    String? description,
  })  : _id = id,
        _name = name,
        _description = description;


  int? get id => _id;

  set id(int? id) {
    _id = id;
  }



  String? get name => _name;

  set name(String? name) {
    _name = name;
  }


  String? get description => _description;

  set description(String? description) {
    _description = description;
  }
}
