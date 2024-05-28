import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/dependency/dependecy_injector.dart';
import 'package:portal_eclb/resource/dao/dao_factory.dart';
import 'package:portal_eclb/resource/dao/mariadb/mariadb_dao_factory.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("DependencyInjectorTest", () {

    test("testGetInstance", () {

      DependencyInjector dependencyInjector1 = DependencyInjector.getInstance();
      DependencyInjector dependencyInjector2 = DependencyInjector.getInstance();

      expect(dependencyInjector1, equals(dependencyInjector2));
    });

    test("testRegisterAndGetDAOFactoryInstances", () async {

      DependencyInjector dependencyInjector = DependencyInjector.getInstance();

      MariaDBDAOFactory factory1 = new MariaDBDAOFactory(await EnvironmentConfiguration.fromFile(".env_dev"));

      dependencyInjector.registerDAOFactory("MARIADB", factory1);

      DAOFactory factory2 = dependencyInjector.getDAOFactory("MARIADB");

      expect(factory1, equals(factory2));

    });

  });
}