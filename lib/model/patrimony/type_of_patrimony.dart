///Esta interface define o contrato para manipular os dados de objetos TypeOfPatrimony (
///Tipo de Patrimônio).
abstract interface class TypeOfPatrimony {

  ///Este método é utilizado para recuperar o valor do identificador de um
  ///objeto TypeOfPatrimony.
  int? get id;

  ///Este método é utilizado para definir o valor do identificador de um objeto TypeOfPatrimony.
  void set id(int? int);

  ///Este método é utilizado para definir o valor da descrição de um objeto TypeOfPatrimony.
  void set description(String? description);

  ///Este método é utilizado para recuperar o valor da descrição de um
  ///objeto TypeOfPatrimony.
  String? get description;

}