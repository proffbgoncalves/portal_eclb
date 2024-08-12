
abstract interface class Media {

  int? get id;
  void set id(int? id);

  String? get name;
  void set name(String? name);

  String? get description;
  void set description(String? description);

  /// Método get e set para obtenção/definição do valor do arquivo do objeto de mídia em formato binário longo.
  List<int>? get file;
  void set file(List<int>? file);

  String? get extension;
  void set extension(String? extension);

  int? get patrimonyId;
  void set patrimonyId(int? patrimonyId);

  int? get typesOfMediaId;
  void set typesOfMediaId(int? typesOfMediaId);
}
