///Esta interface define o contrato padrão para um CRUD, utilizando o padrão de
///projeto Data Access Object. O Data Access Object é um padrão de projeto que
///encapsula o acesso aos dados em uma camada separada, permitindo que a
///lógica de negócios não tenha conhecimento direto das operações de acesso aos
///dados. Isso significa que a lógica do negócio permanece agnóstica em relação
///ao tipo de banco de dados ou a tecnologia de persistência usada.
abstract interface class DAO {

  ///Este método executa a operação de inserção de uma nova linha em uma tabela de um
  ///esquema de banco de dados. Ele recebe um objeto Data Transfer Object,
  ///contendo os valores que serão gravados em cada uma das colunas da tabela.
  ///Ao final da operação, ele retorna true, confirmando que a execução da
  ///operação foi bem sucedida. Caso contrário, ele levatará uma exceção.
  Future<bool> insert(Object dto);

  ///Este método executa a operação de atualização de uma linha existente em uma
  ///tabela de um esquema de banco de dados. Para tanto, ele recebe um objeto
  ///Data Transfer Object, contendo os valores que serão gravados em cada uma
  ///das colunas da tabela. Ao final da operação, ele retorna true, confirmando
  ///que a execução da operação foi bem sucedida. Caso contrário, ele levantará
  ///uma exceção.
  Future<bool> update(Object dto);

  ///Este método executa a operação de deleção de uma linha existente em uma
  ///tabela de um esquema de banco de dados. Para tanto, ele recebe um objeto id,
  ///contendo a chave primária. Ao final da operação, ele retorna true,
  ///confirmando que a execução da operação foi bem sucedida. Caso contrário,
  ///ele levantará uma exceção.
  Future<bool> delete(Object id);

  ///Este método executa a operação de recuperar uma linha utilizando a chave
  ///primária. Ele retorna um objeto contendo todos os valores recuperados a
  ///partir da linha retornado por uma consulta à tabela de banco de dados. Caso
  ///nenhuma linha seja retornada, ele levantará uma exceção.
  Future<Object?> findById(Object id);

  ///Este método executa a recuperação de todas as linhas de uma tabela, caso
  ///os parâmetros offset e limit não sejam informados. Quando informados,
  ///O método recupera apenas uma quantidade linhas, conforme os valores definidos
  ///neste parâmetro.
  Future<List> findAll([int limit, int offset]);

  Future<int> count();
}