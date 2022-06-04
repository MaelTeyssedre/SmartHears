import 'package:smarthears_mobile/helpers/http_helpers.dart';

class NotificationRepository {
  late String apiUrl;

  NotificationRepository(this.apiUrl);

  Future<void> markNotifAsRead(String notifId) async =>
      await HttpHelpers().put(path: 'tmp');

  // Future<List<ExparienceNotification>> getNotifications(
  //         String deviceId) async =>
  //     ((await HttpHelpers().get(path: ApiPath.getNotifications(deviceId)))
  //             as List)
  //         .map((e) => ExparienceNotification.fromJson(e))
  //         .toList();

  Future<int> getBadge(String deviceId) async =>
      int.parse(await HttpHelpers().get(path: 'tmp'));

  Future<void> deleteNotification(String id) async =>
      await HttpHelpers().delete(path: 'tmp');

  Future<void> undeleteNotification(String id) async =>
      await HttpHelpers().put(path: 'tmp');
}
