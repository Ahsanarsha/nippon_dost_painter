import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveId(String? id) async {
    final storage = GetStorage();
    await storage.write(CacheManagerId.ID.toString(), id);
    return true;
  }

  String? getId() {
    final storage = GetStorage();
    return storage.read(CacheManagerId.ID.toString());
  }

  Future<bool> removeId() async {
    final storage = GetStorage();
    await storage.remove(CacheManagerId.ID.toString());
    return true;
  }

  Future<bool> saveNumber(String? num) async {
    final storage = GetStorage();
    await storage.write(CacheManagerNumber.NUM.toString(), num);
    return true;
  }

  Future<bool> saveFCM(String? fcm) async {
    final storage = GetStorage();
    await storage.write(CacheManagerFCM.FCM.toString(), fcm);
    return true;
  }

  String? getFCM() {
    final storage = GetStorage();
    return storage.read(CacheManagerFCM.FCM.toString());
  }

  //Save selected language
  Future<bool> saveLanguage(String? language) async {
    final storage = GetStorage();
    await storage.write(CacheManagerLanguage.LANGUAGE.toString(), language);
    return true;
  }

  String? getLanguage() {
    final storage = GetStorage();
    return storage.read(CacheManagerLanguage.LANGUAGE.toString());
  }

  String? getNumber() {
    final storage = GetStorage();
    return storage.read(CacheManagerNumber.NUM.toString());
  }

  Future<bool> removeNumber() async {
    final storage = GetStorage();
    await storage.remove(CacheManagerNumber.NUM.toString());
    return true;
  }

  Future<bool> saveToken(String? token) async {
    final storage = GetStorage();
    await storage.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final storage = GetStorage();
    return storage.read(CacheManagerKey.TOKEN.toString());
  }

  Future<bool> removeToken() async {
    final storage = GetStorage();
    await storage.remove(CacheManagerKey.TOKEN.toString());
    return true;
  }
}

enum CacheManagerId { ID }
enum CacheManagerLanguage { LANGUAGE }
enum CacheManagerNumber { NUM }
enum CacheManagerKey { TOKEN }
enum CacheManagerFCM { FCM }

