import 'dart:collection';

///Interface que define o contrato de métodos para um gerencidor de sessão com o
///Sistema Gerenciador de Banco de Dados Relacional (SGBDR).
abstract interface class DatabaseSessionManager {

  ///Abre uma sessão com o Sistema Gerenciador de Banco
  ///de Dados Relacional (SGBD). Este método deve ser invocado antes de se
  ///iniciar qualquer operação com o SGBD.
  Future<bool> open();

  ///Fecha a sessão aberta com o Sistema Gerenciador de Banco de Dados
  ///Relacional (SGBDR). Este método deve ser invocado ao final de operações com
  ///o banco de dados.
  Future close();

  ///Retorna o estado da sessão com o Sistema Gerenciador de Banco de Dados
  ///Relacional (SGBDR). Se retornar true, a sessão está aberta. Caso contrário,
  ///a sessão está fechada.
  bool get isOpened;

  ///Executa comandos SQL para modificar o estado do Sistema Gerenciador de
  ///Banco de Dados Relacional (SGBDR). Portanto, este método deve receber
  ///strings SQL contendo comandos como INSERT, UPDADE e DELETE. Também pode ser
  ///utilizado para executar procedimentos armazenados no SGBD.
  ///
  /// Retorna true se o comando foi executado com sucesso.
  Future<Object> execute(String sql, [List values]);

  ///Executa comandos SQL para recuperação de dados de tabelas e visões no
  ///Sistema Gerenciador de Banco de Dados (SGBDR).
  ///
  /// Retorna um objeto iterável contendo as linhas recuperadas por uma consulta
  /// às tabelas ou visões no (SGBDR).
  Future<Iterable?> executeQuery(String sql, [List<Object>? values]);

  ///Executa a operação de commit no Sistema Gerenciador de Banco de Dados. Este
  ///método deve ser executado ao final de qualquer transação. Caso não seja
  ///invocado, as alterações realizadas por comandos INSERT, UPDATE e DELETE, ou
  ///procedimentos armazenados não será gravadas pelo SGBDR.
  ///
  /// Retorna true se a operação foi bem sucedida.
  Future<bool> commit();

  ///Executa a operação de rollback no Sistema Gerenciador de Banco de Dados.
  ///Este método só deve ser invocado quando acontecer um erro durante a tentativa
  ///de execução da operação de commit.
  Future rollback();

  ///Retorna o tipo do DatabaseSessionManager.
  String getType();

  ///Inicia uma transacao com o Sistema Gereciador de Banco de Dados Relacional
  ///(SGBDR).
  Future startTransaction();

  ///Retarna true se a sessão possui uma transação aberta. Caso contrário,
  ///retorna falso.
  bool get isOnTransaction;
}