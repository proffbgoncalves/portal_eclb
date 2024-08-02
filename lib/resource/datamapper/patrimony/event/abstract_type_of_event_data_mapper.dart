import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/patrimony/event/type_of_event.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/event/type_of_event_data_mapper.dart';

///Esta classe abstrata implementa parcialmente a interface TypeOfEventDataMapper.
///Neste caso, esta classe implementa somente:
///- Geração de código SQL para insersão de dados;
///- Geração de código SQL para deleção de dados;
///- Geração de código SQL para atualização de dados;
///- Geração de código SQL para localizar pela chave primária;
///- Geração de código SQL para listar os registros;
///
/// Os demais métodos deverá ser implementados em uma classe concreta.
abstract class AbstractTypeOfEventDataMapper implements TypeOfEventDataMapper {

  @override
  List generateCountStatement() {
    // TODO: implement generateCountStatement
    throw UnimplementedError();
  }

  @override
  List generateDeleteStatement(Object id) {
    throwIf(id is String, new Exception("Parâmetro id não é um int."));
    int idValue = id as int;

    List statement = ["DELETE FROM TYPESOFEVENTS WHERE ID = ?", [idValue]];
    return statement;
  }

  @override
  List generateFindAllStatement([int limit = 0, int offset = 0]) {
    // TODO: implement generateFindAllStatement
    throw UnimplementedError();
  }

  @override
  List generateFindByIdStatement(Object id) {
    // TODO: implement generateFindByIdStatement
    throw UnimplementedError();
  }

  @override
  List generateInsertStatement(Object dto) {
    ///Se a classe do objeto de transferência de dados não for filha de TypeOfEvent,
    ///um erro será gerado.
    throwIf(!(dto is TypeOfEvent), new Exception("O DTO não é uma instância de TypeOfEvent"));

    ///Converte o dto em TypeOfEvent.
    TypeOfEvent typeOfEvent = dto as TypeOfEvent;

    throwIf(typeOfEvent.description == null, new Exception("O atributo description não pode ser nulo."));
    throwIf(typeOfEvent.description == "", new Exception("O atributo description não pode ser vazio."));

    ///Lista contendo a código SQL e os valores para preenchimento;
    List statement = ["INSERT INTO TYPESOFEVENTS (DESCRIPTION) VALUES (?)", [dto.description]];
    ///Retorna a lista.
    return statement;
  }

  @override
  List generateUpdateStatement(Object dto) {
    // TODO: implement generateUpdateStatement
    throw UnimplementedError();
  }

}