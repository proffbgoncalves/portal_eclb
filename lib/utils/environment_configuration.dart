import 'dart:io';
import 'string_extension.dart';

///Classe utilitária para carregar a configuração do ambiente onde a aplicação
///executará.
final class EnvironmentConfiguration {

  ///Atributo para armazenar os parâmetros de configuração da aplicação.
  Map<String, String> _params = {};

  ///Este construtor é privado e, por isso, ele não pode ser chamado de outra classe além de
  ///EnvironmentConfiguration pode acessá-lo. Neste caso, o construtor privado
  ///só pode ser chamado dentro da corpo da classe EnvironmentConfiguration.
  EnvironmentConfiguration._();

  ///Este método estático atua como um factory método. Ele é responsável por
  ///instanciar EnvironmentConfiguration usando o path do arquivo de configuração.
  static Future<EnvironmentConfiguration> fromFile(String filename, {bool onTestEnvironment = true}) async {
    EnvironmentConfiguration instance = new EnvironmentConfiguration._();

    String lines = await instance._readFile(filename, onTestEnvironment);
    instance._load(lines);

    return instance;
  }

  ///Recebe o path do arquivo e o lê. Após isso, retorna todo o conteúdo do
  ///arquivo em uma única String.
  Future<String> _readFile(String filename, bool onTestEnvironment) async {
    String loadedString = "";

    // if (!onTestEnvironment) {
    //   WidgetsFlutterBinding.ensureInitialized();
    //
    //   loadedString = await rootBundle.loadString(filename);
    // } else {
      File file = new File(filename);
      loadedString = await file.readAsString();
    //}
    return loadedString;
  }

  ///Carrega os paâmetros da aplicação no atributo paramns. Este método deve
  ///recebe uma String contendo todas as linhas do arquivo.
  void _load(String str) {
    List<String> lines = str.split("\n");

    for (String line in lines) {
      if (line == "") {
        break;
      }
      List<String> stringValues = line.split("=");

      String parameterKey = stringValues[0];
      String parameterValue = stringValues[1].replaceAll("\r", "");

      this._params[parameterKey] = parameterValue;
    }
  }

  ///Retorna o valor de um parâmetro. Para tanto, é necessário configurar o
  ///generic Type do método, de modo que ele possa converter o valor do parâmetro
  ///no tipo esperado. O parâmetro deve existir no arquivo de configuração.
  ///Caso o parâmetro não exista, uma exceção será levantada.
  Type get<Type>(String parameterKey) {
    if (!this._params.containsKey(parameterKey)) {
      throw new Exception(parameterKey + " is not a configuration parameter.");
    }
    return this._params[parameterKey]!.toType(Type);
  }
}