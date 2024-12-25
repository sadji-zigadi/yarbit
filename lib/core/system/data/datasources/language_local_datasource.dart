import '../../../utils/hive_functions.dart';
import 'package:hive/hive.dart';

abstract class LanguageLocalDatasource {
  Future<void> saveLanguage(String languageCode);
  Future<String> loadLanguage();
}

class LanguageLocalDatasourceImpl implements LanguageLocalDatasource {
  final HiveInterface hive;

  LanguageLocalDatasourceImpl(this.hive);

  @override
  Future<void> saveLanguage(String languageCode) async {
    await withBox(
      hive: hive,
      boxName: 'system',
      operation: (box) async {
        await box.put('language', languageCode);
      },
    );
  }

  @override
  Future<String> loadLanguage() async {
    return await withBox(
      hive: hive,
      boxName: 'system',
      operation: (box) async {
        return box.get('language', defaultValue: 'en') as String;
      },
    );
  }
}
