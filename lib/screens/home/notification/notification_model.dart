import 'package:final_frontend/data/client/notification_service.dart';
import 'package:final_frontend/data/model/notification.dart';
import 'package:final_frontend/screens/util/base_model.dart';

class NotificationModel extends BaseModel {
  NotificationModel(this._notificationService) {
    getNotifications();
  }

  final NotificationService _notificationService;

  List<NotificationData> notifications = [];

  void getNotifications() {
    subscribe<List<NotificationData>>(
      _notificationService.getNotifications(),
      (response) {
        notifications = response;
        notifyListeners();
      },
    );
  }
}
