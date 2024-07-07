import 'package:portal_eclb/model/patrimony/event/type_of_event.dart';

///Classe DTO (Data Transfer Object, ou Objeto de Transferência de Dados) para
///transferir dados entre as camadas da aplicação. Os objetos dessa classe
///transferem dados da interface gráfica com o usuário para a tabela TYPESOFEVENTS
///no banco de dados e vice-versa.
///
/// Além disso, esta classe implementa completamente o contrato de métodos definido
/// em TypeOfEvent.
final class TypeOfEventDTO implements TypeOfEvent {

  ///Atributo privado (_ é o símbolo para visibilidade privada) id. Este atributo
  ///admite valores null, devido ao uso do operador (?) na definição de tipo.
  int? _id;

  ///Atributo privado (_ é o símbolo para visibilidade privada) description.
  ///Este atributo admite valores null, devido ao uso do operador (?) na
  ///definição de tipo.
  String? _description;

  ///Método construtor com parâmetros opicionais nomedados. Verificar a aula
  ///de Membros e Sobrecarga de Métodos. O motivo de usar parâmetros opcionais
  ///nomeados no construtor é oferecer uma liberdade da instanciação da classe.
  ///de acordo com o cenário de uso dentro aplicação.
  TypeOfEventDTO({int? id, String? description}) {
    this._id = id;
    this._description = description;
  }

  ///Implementação do método get definido na interface TypeOfEvent.
  String? get description => this._description;

  ///Implementação do método set definido na interface TypeOfEvent.
  set description(String? value) {
    this._description = value;
  }

  ///Implementação do método get definido na interface TypeOfEvent.
  int? get id => this._id;

  ///Implementação do método set definido na interface TypeOfEvent.
  set id(int? value) {
    this._id = value;
  }
}