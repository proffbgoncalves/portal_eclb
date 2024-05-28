///Esta interface define o contrato de métodos de um Entity Object. Entity
///Objects são um tipo específico de domain object que têm uma identidade
///distinta que perdura ao longo do tempo e das diferentes operações realizadas
///sobre eles. As características principais das entidades incluem:
///
/// * **Identidade:** Cada entidade possui uma identidade única que a diferencia
/// de outras entidades, geralmente representada por um identificador, como uma
/// chave primária no banco de dados.
/// * **Ciclo de Vida:** Entidades podem mudar seu estado ao longo do tempo,
/// mas sua identidade permanece a mesma.
/// * **Persistência:** Entidades são geralmente persistidas em um banco de dados,
/// e suas identidades permitem que sejam recuperadas e atualizadas.
abstract interface class EntityObject {

  ///Este método persiste um EntityObject em uma tabela de m esquema de banco de
  ///dados. Ele cria uma linha em na tabela relacionada ao EntityObject.
  Future<bool> insert();

  ///Este método exclui o EntityObject. Isso é feito excluindo a linha
  ///de uma tabela em um esquema de banco de dados.
  Future<bool> delete();

  ///Este método atualizada os dados mantidos pelo EntityObject. Isso é feito
  ///atualizando a linha de uma tabela em um esquema de banco de dados.
  Future<bool> update();

}