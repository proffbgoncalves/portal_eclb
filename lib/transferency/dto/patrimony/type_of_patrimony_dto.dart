import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';

///Esta classe concreta implementa o contrado definido pela interface TypeOfPatrimony,
///a fim de implementar o padrão de projeto DataTransferObject (DTO). Um DTO é um padrão
///de projeto de software usado para transferir dados entre subsistemas de um software.
///DTOs são frequentemente usados em conjunção com objetos de acesso a dados para
///obter dados de um banco de dados.
final class TypeOfPatrimonyDTO implements TypeOfPatrimony {

  ///Este atributo armazena o valor inteiro correspondete ao identificador de um
  ///objeto TypeOfPatrimony. Este valor é gerado por mecanismos de auto incrementos
  ///quando um DTO é inserido em uma tabela de banco de dados.
  int? _id;

  ///Este atributo armazena a descrição de um objeto TypeOfPatrimony.
  String? _description;

  ///Método construtor com parâmetros opcionais. Este construtor permite inicializar
  ///um objeto TypeOfPatrimonyDTO, conforme a necessidade da criação do objeto.
  TypeOfPatrimonyDTO({int? id, String? description}) {
    this._id = id;
    this._description = description!;
  }

  ///Retorna o valor correspondente à descrição de um objeto TypeOfPatrimonyDTO.
  String? get description => this._description;

  ///Define o valor da descrição de um objeto TypeOfPatrimonyDTO.
  void set description(String? value) {
    this._description = value;
  }

  ///Retorna o valor correspondente ao identificador de um objeto TypeOfPatrimonyDTO.
  int? get id => this._id;

  ///Define o valor do identificador de um objeto TypeOfPatrimonyDTO.
  void set id(int? id) {
    this._id = id;
  }
}