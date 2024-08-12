import 'package:portal_eclb/model/patrimony/simple/patrimony_movimentation.dart';
import 'package:portal_eclb/resource/datamapper/patrimony/simple/patrimony_movimentation_data_mapper.dart';

abstract class AbstractPatrimonyMovimentationDataMapper implements PatrimonyMovimentationDataMapper {

  @override
  List generateFindAllByDateStatement(DateTime date) {
    if (date == null) {
      throw new Exception("Date parameter is null.");
    }
    return ["SELECT * FROM PATRIMONYMOVIMENTATION WHERE DATE = ?", [date.toIso8601String()]];
  }

  @override
  List generateFindAllByOriginStatement(String origin) {
    if (origin == null) {
      throw new Exception("Origin parameter is null.");
    } else if (origin.isEmpty) {
      throw new Exception("Origin parameter cannot be empty.");
    }
    return ["SELECT * FROM PATRIMONYMOVIMENTATION WHERE ORIGIN = ?", [origin]];
  }

  @override
  List generateFindAllByDestinationStatement(String destination) {
    if (destination == null) {
      throw new Exception("Destination parameter is null.");
    } else if (destination.isEmpty) {
      throw new Exception("Destination parameter cannot be empty.");
    }
    return ["SELECT * FROM PATRIMONYMOVIMENTATION WHERE DESTINATION = ?", [destination]];
  }

  @override
  List generateFindAllByDescriptionStatement(String description) {
    if (description == null) {
      throw new Exception("Description parameter is null.");
    } else if (description.isEmpty) {
      throw new Exception("Description parameter cannot be empty.");
    }
    return ["SELECT * FROM PATRIMONYMOVIMENTATION WHERE DESCRIPTION = ?", [description]];
  }

  List generateDeleteStatement(Object id) {
    if (id == null) {
      throw new Exception("Id parameter is null.");
    }
    return ["DELETE FROM PATRIMONYMOVIMENTATION WHERE ID = ?", [id]];
  }

  List<Object> generateFindAllStatement([int limit = 0, int offset = 0]) {
    if (offset >= 0 && limit > 0) {
      return ["SELECT * FROM PATRIMONYMOVIMENTATION LIMIT ? OFFSET ?", [limit, offset]];
    } else if (offset == 0 && limit == 0) {
      return ["SELECT * FROM PATRIMONYMOVIMENTATION"];
    } else {
      throw new Exception("Invalid parameter for generateFindAllStatements method.");
    }
  }

  List generateFindByIdStatement(Object id) {
    if (id == null) {
      throw new Exception("Id parameter is null.");
    }
    return ["SELECT * FROM PATRIMONYMOVIMENTATION WHERE ID = ?", [id]];
  }

  List generateInsertStatement(Object dto) {
    if (dto == null) {
      throw new Exception("DTO parameter is null.");
    }

    PatrimonyMovimentation movimentation = dto as PatrimonyMovimentation;

    if (movimentation.origin!.isEmpty || movimentation.destination!.isEmpty) {
      throw new Exception("Origin and Destination fields cannot be empty.");
    }
    return ["INSERT INTO PATRIMONYMOVIMENTATION (DATE, ORIGIN, DESTINATION, DESCRIPTION, SIMPLEPATRIMONYID) VALUES (?, ?, ?, ?, ?)",
      [movimentation.date!.toIso8601String(), movimentation.origin, movimentation.destination, movimentation.description, movimentation.simplePatrimonyId]];
  }

  List generateUpdateStatement(Object dto) {
    if (dto == null) {
      throw new Exception("DTO parameter is null.");
    } else if ((dto as PatrimonyMovimentation).id! <= 0) {
      throw new Exception("DTO has an invalid id value.");
    }
    PatrimonyMovimentation movimentation = dto;
    return ["UPDATE PATRIMONYMOVIMENTATION SET DATE = ?, ORIGIN = ?, DESTINATION = ?, DESCRIPTION = ?, SIMPLEPATRIMONYID = ? WHERE ID = ?",
      [movimentation.date!.toIso8601String(), movimentation.origin, movimentation.destination, movimentation.description, movimentation.simplePatrimonyId, movimentation.id]];
  }
}
