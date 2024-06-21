import 'package:get_it/get_it.dart';
import 'package:mysql1/mysql1.dart';
import 'package:portal_eclb/model/patrimony/type_of_patrimony.dart';
import 'package:portal_eclb/resource/dao/abstract_dao.dart';
import 'package:portal_eclb/resource/dao/patrimony/type_of_patrimony_dao.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/type_of_patrimony_data_mapper.dart';
import 'package:portal_eclb/transferency/dto/patrimony/type_of_patrimony_dto.dart';

///Esta classe implementa um DAO concreto capaz de acessor e manupular dados na
///tabela TYPESOFPATRIMONIES. Esta tabela é parte de um esquema de banco de dados
///gerenciado pelo SGBDR MariaDB.
final class MariaDBTypeOfPatrimonyDAO extends AbstractDAO implements TypeOfPatrimonyDAO {

  ///Método construtor respeitando o método construtor da superclasse AbstractDAO.
  MariaDBTypeOfPatrimonyDAO(super.sessionManager, super.dataMapper);

  ///Este método sobrescreve o método definido na superclasse. Aqui, após a operação
  ///de inserção de um novo objeto TypeOfPatrimony, o método recupera o valor da chave
  ///primária gerado automaticamente e, em seguida, define o valor do atributo id
  ///do Data Transfer Object passado como parâmetro.
  Future<bool> insert(Object dto) async {
    try {
      bool insertResult = await super.insert(dto);

      Results? results = (await super.sessionManager.executeQuery("SELECT LAST_INSERT_ID()")) as Results;

      TypeOfPatrimonyDTO typeOfPatrimonyDTO = dto as TypeOfPatrimonyDTO;
      typeOfPatrimonyDTO.id = results.first[0];

      return insertResult;
    } catch (e) {
      rethrow;
    }
  }

  ///Implementação do método abstrato definido pela interface TypeOfPatrimonyDAO.
  Future<TypeOfPatrimony> findByDescription(String description) async {
    if (!this.sessionManager.isOpened) {
      throw new Exception("Database session is not opened.");
    }
    if (description == null) {
      throw new Exception("Description parameter is null.");
    } else if (description == "") {
      throw new Exception("Description can not be empty");
    }
    List statement = (this.dataMapper as TypeOfPatrimonyDataMapper).generateFindByDescriptionStatement(description);
    Results results = (await this.sessionManager.executeQuery(statement[0], statement[1])) as Results;
    if (results.length == 0) {
      throw new Exception("Type of patrimony was not found.");
    }
    TypeOfPatrimony dto = new TypeOfPatrimonyDTO(id: results.first[0], description: results.first[1]);
    return dto;
  }

  @override
  Future<int> count() async {
    throwIf(this.sessionManager.isOpened == false, new Exception("Database session is not opened."));

    List statement = this.dataMapper!.generateCountStatement();
    Results? results = (await this.sessionManager.executeQuery(statement[0])) as Results;

    return results.first[0];
  }

}