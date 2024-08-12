import 'package:portal_eclb/model/patrimony/media/media.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/media/media_data_mapper.dart';

abstract class AbstractMediaDataMapper implements MediaDataMapper {

  @override
  List generateFindAllByNameStatement(String name) {
    if (name == null) {
      throw new Exception("Name parameter is null.");
    } else if (name.isEmpty) {
      throw new Exception("Name parameter cannot be empty.");
    }
    return ["SELECT * FROM MEDIA WHERE NAME = ?", [name]];
  }

  @override
  List generateFindAllByExtensionStatement(String extension) {
    if (extension == null) {
      throw new Exception("Extension parameter is null.");
    } else if (extension.isEmpty) {
      throw new Exception("Extension parameter cannot be empty.");
    }
    return ["SELECT * FROM MEDIA WHERE EXTENSION = ?", [extension]];
  }

  @override
  List generateFindAllByDescriptionStatement(String description) {
    if (description == null) {
      throw new Exception("Description parameter is null.");
    } else if (description.isEmpty) {
      throw new Exception("Description parameter cannot be empty.");
    }
    return ["SELECT * FROM MEDIA WHERE DESCRIPTION = ?", [description]];
  }

  @override
  List generateFindAllByPatrimonyId(int patrimonyId) {
    if (patrimonyId <= 0) {
      throw new Exception("Patrimony ID must be greater than zero.");
    }
    return ["SELECT * FROM MEDIA WHERE PATRIMONYID = ?", [patrimonyId]];
  }

  List generateDeleteStatement(Object id) {
    if (id == null) {
      throw new Exception("Id parameter is null.");
    }
    return ["DELETE FROM MEDIA WHERE ID = ?", [id]];
  }

  List<Object> generateFindAllStatement([int limit = 0, int offset = 0]) {
    if (offset >= 0 && limit > 0) {
      return ["SELECT * FROM MEDIA LIMIT ? OFFSET ?", [limit, offset]];
    } else if (offset == 0 && limit == 0) {
      return ["SELECT * FROM MEDIA"];
    } else {
      throw new Exception("Invalid parameter for generateFindAllStatements method.");
    }
  }

  List generateFindByIdStatement(Object id) {
    if (id == null) {
      throw new Exception("Id parameter is null.");
    }
    return ["SELECT * FROM MEDIA WHERE ID = ?", [id]];
  }

  List generateInsertStatement(Object dto) {
    if (dto == null) {
      throw new Exception("DTO parameter is null.");
    }

    Media media = dto as Media;

    if (media.name!.isEmpty || media.extension!.isEmpty) {
      throw new Exception("Name and Extension fields cannot be empty.");
    }
    return ["INSERT INTO MEDIA (NAME, EXTENSION, DESCRIPTION, PATRIMONYID, TYPESOFMEDIAID) VALUES (?, ?, ?, ?, ?)",
      [media.name, media.extension, media.description, media.patrimonyId, media.typesOfMediaId]];
  }

  List generateUpdateStatement(Object dto) {
    if (dto == null) {
      throw new Exception("DTO parameter is null.");
    } else if ((dto as Media).id! <= 0) {
      throw new Exception("DTO has an invalid id value.");
    }
    Media media = dto as Media;
    return ["UPDATE MEDIA SET NAME = ?, EXTENSION = ?, DESCRIPTION = ?, PATRIMONYID = ?, TYPESOFMEDIAID = ? WHERE ID = ?",
      [media.name, media.extension, media.description, media.patrimonyId, media.typesOfMediaId, media.id]];
  }
}
