import 'dart:async';
import 'package:smarthears_mobile/helpers/http_helpers.dart';
import 'package:smarthears_mobile/models/notification.dart';

class SubscriptionRepository {
  late String apiUrl;
  Subscription? mySubscription;

  SubscriptionRepository(String url) {
    apiUrl = url;
  }

  Future<Subscription?> getMySubscription(int userId, bool force) async {
    if (mySubscription == null || force) {
      var response = await HttpHelpers().get(path: 'tmp');
      mySubscription = Subscription.fromJson(response);
    }
    return mySubscription;
  }

  Future<void> subscribeToExparience(String id, int userId) async {
    await HttpHelpers().put(path: 'tmp');
    await getMySubscription(userId, true);
  }

  Future<void> unsubscribeToExparience(String id, int userId) async {
    await HttpHelpers().delete(path: 'tmp');
    await getMySubscription(userId, true);
  }
}
