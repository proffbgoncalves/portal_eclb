///Esta interface define o contrato de métodos para um tipo de evento (TypeOfEvent).
///Aqui são definidos somente métodos abstratos de acesso, ou seja, somente setters e
///getters. Esta interface também é importante para criação de outras classes e
///interfaces no projeto.
abstract interface class TypeOfEvent {

  ///Método get para obtenção do valor do id de um tipo de evento. Esse id é o
  ///valor da chave primária de uma linha na tabela TYPESOFEVENTS no banco de dados.
  int? get id;

  ///Método set para definição do valor do id de um tipo de evento. Esse id é o
  ///valor da chave primária de uma linha na tabela TYPESOFEVENTS no banco de dados.
  void set id (int? id);

  ///Método get para obtenção do valor da descrição de um tipo de evento. A descrição
  ///define o nome de um tipo de evento.
  String? get description;

  ///Método set para a definição do valor da descrição de um tipo de evento.
  void set description(String? description);

}