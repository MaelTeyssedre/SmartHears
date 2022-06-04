import 'package:smarthears_mobile/helpers/http_helpers.dart';
import 'package:smarthears_mobile/models/content_page.dart';

class ContentPageRepository {
  ContentPage? _page;
  late String apiUrl;

  ContentPageRepository(this.apiUrl);

  Future<ContentPage?> getPage({bool forceReload = false}) async {
    if (_page != null && !forceReload) return _page;

    final response = await HttpHelpers().get(path: 'tmp');
    _page = ContentPage.fromJson(response);
    return _page;
  }

  Future<SoundPacks> searchSoundPack(String name) async {
    try {
      final response = await HttpHelpers().get(path: 'tmp');
      return SoundPacks.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  Future<SoundPacks> findSoundPack(String id) async =>
      SoundPacks.fromJson(await HttpHelpers().get(path: 'tmp'));

  Future<String> getSoundPack(String id) async =>
      await HttpHelpers().get(path: 'tmp', toDecode: false);

  Future<bool> checkCode(String code, String id) async =>
      (await HttpHelpers().get(path: 'tmp'))['password'] as bool;
}
