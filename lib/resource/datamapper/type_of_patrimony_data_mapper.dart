import 'package:portal_eclb/resource/datamapper/data_mapper.dart';

///Esta interface estende o contrato de métodos definido pela interface DataMapper.
///Aqui é definido um novo método cuja responsabilidade é gerar um statement SQL
///para recuperação de um TypeOdPatrimony, utilizando sua descrição.
abstract interface class TypeOfPatrimonyDataMapper implements DataMapper {

  ///Retorna uma lista contendo dois elementos. O primeiro é o statement de uma
  ///instrução SELECT contendo contendo coringas (sinal de ?). O segundo é a
  ///descrição de um TypeOfPatrimony.
  List generateFindByDescriptionStatement(String name);
}