import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/type_of_patrimony_data_mapper.dart';

///Esta classe abstrata implementar parciamento o contrato de métodos definidos por
///TypeOdPatrimonyDataMapper. Somente os seguintes métodos foram implementados:
///
///* generateDeleteStatement;
///* generateFindAllStatement;
///* generateFindByIdStatement;
///* generateInsertStatement;
///* generateUpdateStatement;
///* generateFindByDescriptionStatement.
abstract class AbstractTypeOfPatrimonyDataMapper implements TypeOfPatrimonyDataMapper {

  ///Implementação padrão para geração de um statement SQL para deleção de uma linha
  ///em uma tabela de um esquema de banco de dados.
  List generateDeleteStatement(Object id) {
    List statement = ["DELETE FROM TYPESOFPATRIMONIES WHERE ID = ?", [id]];
    return statement;
  }

  ///Implementação padrão para geração de um statement SQL para recuperação de todas
  ///ou parte das linhas de uma tabela de um esquema de banco de dados.
  List<Object> generateFindAllStatement([int limit = 0, int offset = 0]) {
    if (offset >= 0 && limit > 0) {
      return ["SELECT * FROM TYPESOFPATRIMONIES LIMIT ? OFFSET ?", [limit, offset]];
    } else if (offset == 0 && limit == 0) {
      return ["SELECT * FROM TYPESOFPATRIMONIES"];
    } else {
      throw new Exception("Não é possível gerar statement SQL. Parâmetros limit e offset são inválidos");
    }
  }

  ///Implementação padrão para geração de um statement SQL para recuperação de uma
  ///linha utilizando uma chave primária.
  List generateFindByIdStatement(Object id) {
    List statement = ["SELECT * FROM TYPESOFPATRIMONIES WHERE ID = ?", [id]];
    return statement;
  }

  ///Implementação padrão para geração de um statement SQL para inserção de uma linha
  ///em uma tabela de um esquema de banco de dados.
  List generateInsertStatement(Object dto) {
    TypeOfPatrimony patrimony = dto as TypeOfPatrimony;

    if (patrimony.description == "") {
      throw new Exception("Não é possível gerar statement SQL. Atributo description não pode ser vazio.");
    }
    List <Object> statement = ["INSERT INTO TYPESOFPATRIMONIES (DESCRIPTION) VALUES (?)", [patrimony.description]];
    return statement;
  }

  ///Implementação padrão para geração de um statement SQL para atualização de uma linha
  ///em uma tabela de um esquema de banco de dados.
  List generateUpdateStatement(Object dto) {
    throwIf((dto as TypeOfPatrimony).id! <= 0, new Exception("Não é possível gerar statement SQL. Atributo id possui valor inválido."));

    TypeOfPatrimony typeOfPatrimony = dto as TypeOfPatrimony;
    List statement = ["UPDATE TYPESOFPATRIMONIES SET DESCRIPTION = ? WHERE ID = ?", [typeOfPatrimony.description, typeOfPatrimony.id]];
    return statement;
  }

  ///Implementação padrão para geração de um statement SQL para recuperação de uma
  ///linha utilizando uma descrição.
  List generateFindByDescriptionStatement(String name) {
    throwIf(name == "", new Exception("Não é possível gerar statement SQL. Parâmetro name não pode ser vazio."));

    List statement = ["SELECT * FROM TYPESOFPATRIMONIES WHERE DESCRIPTION = ?", [name]];
    return statement;
  }

  List generateCountStatement() {
    List statement =["SELECT COUNT(ID) FROM TYPESOFPATRIMONIES"];
    return statement;
  }
  
}