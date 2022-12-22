import 'dart:io';

import 'package:final_frontend/const/image_asset.dart';
import 'package:final_frontend/data/client/notification_service.dart';
import 'package:final_frontend/data/model/notification.dart';
import 'package:final_frontend/screens/home/notification/notification_model.dart';
import 'package:final_frontend/screens/util/base_state_less_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class NotificationPage extends BaseStatelessWidget<NotificationModel> {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  NotificationModel createProvider(BuildContext context) {
    NotificationService service = GetIt.I.get();
    return NotificationModel(service);
  }

  _onWillPoped(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("通知"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _onWillPoped(context),
          ),
          backgroundColor: const Color(0xFF67B984),
        ),
        body: _buildList(context));
  }

  Widget _buildList(BuildContext context) {
    List<NotificationData>? notifications =
        context.watch<NotificationModel>().notifications;
    if (notifications == null || notifications.isEmpty) {
      return _buildContainerEmptyBulletinBoard(context);
    }

    return ListView.separated(
      padding: EdgeInsets.only(top: 20),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return _AnnouncementTile(
          time: notifications[index].time,
          title: notifications[index].title,
          text: notifications[index].content,
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
        );
      },
    );
  }

  Widget _buildContainerEmptyBulletinBoard(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAsset.notificationIcon),
          alignment: Alignment.center,
          fit: BoxFit.contain,
        ),
      ),
      child: const Center(
        child: Text(
          "沒有通知",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _AnnouncementTile extends StatelessWidget {
  final String time;
  final String title;
  final String text;

  const _AnnouncementTile(
      {Key? key, required this.time, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF3D5656),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications_active,
                          color: Color(0xFFFED048)),
                      Text('  $title',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                trailing:
                    Text(time, style: const TextStyle(color: Colors.white)),
                subtitle: Text('  $text',
                    style: const TextStyle(color: Colors.white))),
          ),
        ),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AnnouncementPage(
          //       startAt: startAt,
          //       icon: leadingIcon,
          //       title: title,
          //       text: text,
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
