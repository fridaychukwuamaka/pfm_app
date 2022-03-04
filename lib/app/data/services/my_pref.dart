import 'package:get_storage/get_storage.dart';

class MyPref {
 static GetStorage storage =  GetStorage('MyPref');
  static final _box = () => storage;

  static final enableBiometric = ReadWriteValue<bool>('enable_biometric', false, _box);


  static Future<void> clearBoxes() async {
    await _box().erase();
  }
}
