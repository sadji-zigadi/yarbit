import 'package:hive/hive.dart';

Future<dynamic> withBox({
  required HiveInterface hive,
  required String boxName,
  required Future<dynamic> Function(Box box) operation,
}) async {
  Box box = await _openBox(hive, boxName);

  try {
    return await operation(box);
  } finally {
    await _closeBox(hive, boxName);
  }
}

Future<Box> _openBox(HiveInterface hive, String boxName) async {
  if (!hive.isBoxOpen(boxName)) {
    return await hive.openBox(boxName);
  }
  return hive.box(boxName);
}

Future<void> _closeBox(HiveInterface hive, String boxName) async {
  if (hive.isBoxOpen(boxName)) {
    await hive.box(boxName).close();
  }
}
