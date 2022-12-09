import 'package:final_frontend/components/round_image.dart';
import 'package:final_frontend/data/model/device.dart';
import 'package:flutter/material.dart';

class DeviceView extends StatelessWidget {
  const DeviceView({Key? key, required this.data, this.onTap})
      : super(key: key);
  final Device data;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(
              data.image,
              width: 60,
              height: 60,
              radius: 10,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: Colors.amber,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: const <Widget>[
                Text("location",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.amber)),
                SizedBox(
                  height: 10,
                ),
                // FavoriteBox(
                //   iconSize: 13,
                //   isFavorited: data["is_favorited"],
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
