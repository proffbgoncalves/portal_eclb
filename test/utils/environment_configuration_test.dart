import 'package:flutter_test/flutter_test.dart';
import 'package:portal_eclb/utils/environment_configuration.dart';

void main() {

  group("EnvironmentConfigurarionTest", () {

    test("testLoadProductionEnvironmentConfiguration", () async {
      EnvironmentConfiguration configuration = await EnvironmentConfiguration.fromFile(".env");
      expect(configuration, isNotNull);

      expect(configuration.get<String>("host"), equals("localhost"));
      expect(configuration.get<int>("port"), equals(8080));
      expect(configuration.get<String>("db"), equals("eclb_prod"));
      expect(configuration.get<String>("user"), equals("root"));
      expect(configuration.get<String>("password"), equals("aluno"));

    });

    test("testLoadDevelopmentEnvironmentConfiguration", () async {
      EnvironmentConfiguration configuration = await EnvironmentConfiguration.fromFile(".env_dev");
      expect(configuration, isNotNull);

      expect(configuration.get<String>("host"), equals("localhost"));
      expect(configuration.get<int>("port"), equals(8080));
      expect(configuration.get<String>("db"), equals("eclb_dev"));
      expect(configuration.get<String>("user"), equals("root"));
      expect(configuration.get<String>("password"), equals("aluno"));

    });

  });
}