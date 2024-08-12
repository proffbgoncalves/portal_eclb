import 'package:get_it/get_it.dart';
import 'package:portal_eclb/model/patrimony/news/patrimony_news.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/news/patrimony_news_data_mapper.dart';

abstract class AbstractPatrimonyNewsDataMapper implements PatrimonyNewsDataMapper {

  @override
  List generateDeleteStatement(Object id) {
    throwIf(!(id is int), new Exception("Não é possível gerar statement SQL. O parâmetro id não é um int."));

    List statement = ["DELETE FROM PATRIMONYNEWS WHERE ID = ?", [id]];
    return statement;
  }

  @override
  List generateFindAllStatement([int limit = 0, int offset = 0]) {
    if (offset > 0 && limit > 0) {
      return ["SELECT * FROM PATRIMONYNEWS LIMIT ? OFFSET ?", [limit, offset]];
    } else if (offset == 0 && limit == 0) {
      return ["SELECT * FROM PATRIMONYNEWS"];
    } else {
      throw new Exception("Não é possível gerar statement SQL. Parâmetros limit e offset são inválidos.");
    }
  }

  @override
  List generateFindByIdStatement(Object id) {
    throwIf(!(id is int), new Exception("Não é possível gerar statement SQL. O parâmetro id não é um int."));

    List statement = ["SELECT * FROM PATRIMONYNEWS WHERE ID = ?", [id]];
    return statement;
  }

  @override
  List generateInsertStatement(Object dto) {
    throwIf(!(dto is PatrimonyNews), new Exception("Não é possível gerar statement SQL. DTO não é uma instância de PatrimonyNews."));

    PatrimonyNews news = dto as PatrimonyNews;

    throwIf(news.title == "", new Exception("Não é possível gerar statement SQL. Atributo title não pode ser vazio"));
    throwIf(news.description == "", new Exception("Não é possível gerar statement SQL. Atributo description não pode ser vazio"));
    throwIf(news.patrimonyId == null, new Exception("Não é possível gerar statement SQL. Atributo patrimonyId não pode ser nulo"));
    throwIf(news.typeOfPatrimonyNewsId == null, new Exception("Não é possível gerar statement SQL. Atributo typeOfPatrimonyNewsId não pode ser nulo"));

    List statement = ["INSERT INTO PATRIMONYNEWS (TITLE, DESCRIPTION, PATRIMONYID, TYPEOFPATRIMONYNEWSID) VALUES (?, ?, ?, ?)",
      [news.title, news.description, news.patrimonyId, news.typeOfPatrimonyNewsId]];

    return statement;
  }

  @override
  List generateUpdateStatement(Object dto) {
    throwIf(!(dto is PatrimonyNews), new Exception("DTO não é uma instância de PatrimonyNews."));

    PatrimonyNews news = (dto as PatrimonyNews);
    throwIf(news.id == null, new Exception("DTO não possui um valor id válido."));
    throwIf(news.title == "", new Exception("DTO possui um valor title inválido."));
    throwIf(news.description == "", new Exception("DTO possui um valor description inválido."));
    throwIf(news.patrimonyId == null, new Exception("DTO possui um valor patrimonyId inválido."));
    throwIf(news.typeOfPatrimonyNewsId == null, new Exception("DTO possui um valor typeOfPatrimonyNewsId inválido."));

    List statement = ["UPDATE PATRIMONYNEWS SET TITLE = ?, DESCRIPTION = ?, PATRIMONYID = ?, TYPEOFPATRIMONYNEWSID = ? WHERE ID = ?",
      [news.title, news.description, news.patrimonyId, news.typeOfPatrimonyNewsId, news.id]];

    return statement;
  }

  @override
  List generateFindByTitleStatement(String title) {
    throwIf(title == "", new Exception("Parâmetro title não pode ser vazio."));

    List statement = ["SELECT * FROM PATRIMONYNEWS WHERE TITLE LIKE ?", ["%"+title+"%"]];
    return statement;
  }

  @override
  List generateFindByDescriptionStatement(String description) {
    throwIf(description == "", new Exception("Parâmetro description não pode ser vazio."));

    List statement = ["SELECT * FROM PATRIMONYNEWS WHERE DESCRIPTION LIKE ?", ["%"+description+"%"]];
    return statement;
  }

  @override
  List generateCountStatement() {
    List statement = ["SELECT COUNT(ID) FROM PATRIMONYNEWS"];
    return statement;
  }
}
