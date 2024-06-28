///Esta interface define o contrato de métodos capazes de realizar a geração de
///statements SQL, além de carregar um objeto com dados obtidos de colunas de
///uma tabela em um esquema de banco de dados. Também possui um método para
///construir uma coleção de objetos basedas nos dados recuperados por meio de
///consultas a uma tabela em um esquema de banco de dados.
abstract interface class DataMapper {

  ///Retorna uma lista contendo dois elementos. O primeiro é o statement de uma
  ///instrução INSERT contendo contendo coringas (sinal de ?). O segundo são os
  ///valores que preencherão os coringas do statement SQL.
  List generateInsertStatement(Object dto);

  ///Retorna uma lista contendo dois elementos. O primeiro é o statement de uma
  ///instrução UPDATE contendo contendo coringas (sinal de ?). O segundo são os
  ///valores que preencherão os coringas do statement SQL.
  List generateUpdateStatement(Object dto);

  ///Retorna uma lista contendo dois elementos. O primeiro é o statement de uma
  ///instrução DELETE contendo contendo coringas (sinal de ?). O segundo são os
  ///valores que preencherão os coringas do statement SQL.
  List generateDeleteStatement(Object id);

  ///Retorna uma lista contendo dois elementos. O primeiro é o statement de uma
  ///instrução SELECT contendo contendo coringas (sinal de ?). O segundo são os
  ///valores que preencherão os coringas do statement SQL.
  List generateFindByIdStatement(Object id);

  ///Retorna uma lista contendo dois elementos. O primeiro é o statement de uma
  ///instrução SELECT contendo contendo coringas (sinal de ?). O segundo são os
  ///valores que preencherão os coringas do statement SQL.
  List generateFindAllStatement([int limit, int offset]);

  ///Cria um Data Transfer Object baseado nos resultados obtidos de uma consulta SQL
  ///a uma tabela em um esquema de banco de dados.
  Object? generateObject(Iterable resultSet);

  ///Cria uma coleção contendo Data Transfer Objects baseada nos resultados de uma
  ///consulta SQL a uma tabela em um esquema de banco de dados.
  List generateList(Iterable resultSet);


  List generateCountStatement();
}