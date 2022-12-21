import 'package:final_frontend/components/device_view.dart';
import 'package:final_frontend/components/text_box.dart';
import 'package:final_frontend/data/model/device.dart';
import 'package:final_frontend/screens/home/components/notification.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AgentSettingPage extends StatelessWidget {
  AgentSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.clear_all_rounded,
                      size: 28,
                    ))),
            const NotificationBox(
              number: 1,
            )
          ],
        ),
      ),
      body: buildMain(context),
    );
  }

  Widget buildMain(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: const Text(
              "Find Device",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: CustomTextBox(
                  hint: "Search",
                  prefix: const Icon(Icons.search, color: Colors.black),
                  suffix: const Icon(Icons.filter_list_outlined,
                      color: Colors.black))),
          const SizedBox(
            height: 25,
          ),
          // Container(
          //   margin: EdgeInsets.only(left: 15, right: 15),
          //   height: 150,
          //   decoration: BoxDecoration(
          //       color: Colors.grey,
          //       borderRadius: BorderRadius.circular(15),
          //       image: DecorationImage(
          //           fit: BoxFit.cover,
          //           image: NetworkImage(
          //             "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
          //           ))),
          // ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: const Text(
              "Your Devices",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: listFeatured(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  final List<Device> devices = [
    Device(
        name: "name",
        about: "about",
        on: true,
        image:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png",
        location: DeviceLocation.bedroom),
  ];

  listFeatured(BuildContext context) {
    return Column(
      children: List.generate(
          devices.length,
          (index) => DeviceView(
                data: devices[index],
                onTap: () async {
                  print("send http");
                  final url = Uri.parse('http://linux9.csie.ntu.edu.tw:13751');
                  try {
                    final response = await http.get(url);
                    print(response);
                    print(response.body);
                  } catch (e) {
                    print(e.runtimeType);
                  }
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => ItemPage(productList[0]),
                  //   ),
                  // );
                },
              )),
    );
  }
}
