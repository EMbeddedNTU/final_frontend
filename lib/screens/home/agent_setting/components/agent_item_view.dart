import 'package:final_frontend/components/round_image.dart';
import 'package:final_frontend/data/model/agent_info.dart';
import 'package:flutter/material.dart';

class AgentItemView extends StatelessWidget {
  const AgentItemView({Key? key, required this.agentInfo, this.onTap})
      : super(key: key);

  final AgentInfo agentInfo;
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
            const CustomImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4h_8-BuOkHriAVFfjaxX4JanLHJ6xayqc5XiYultVP56NClOhYW3ZLGDgei_B5AZ3GtM&usqp=CAU",
              width: 60,
              height: 60,
              radius: 10,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(agentInfo.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(
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
              children: <Widget>[
                Text(agentInfo.location,
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
