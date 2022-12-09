import 'package:final_frontend/data/model/device.dart';
import 'package:final_frontend/screens/home/cart/empty_cart.dart';
import 'package:flutter/material.dart';

// final ProductController controller = Get.put(ProductController());

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  // TODO:
  final bool is_empty = true;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("not finish yet"));
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Expanded(
    //       flex: 10,
    //       child: is_empty ? buildCartListView() : const EmptyCart(),
    //     ),
    //     buildBottomBarTitle(),
    //     buildBottomBarButton()
    //   ],
    // );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "My cart",
        // TODO:
        // style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  //TODO:
  final List<Device> productList = [
    Device(
        name: "name",
        about: "about",
        on: true,
        image: "",
        location: DeviceLocation.livingRoom),
    Device(
        name: "name",
        about: "about",
        on: true,
        image: "",
        location: DeviceLocation.diningRoom),
  ];

  Widget buildCartListView() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemCount: productList.length,
      itemBuilder: (_, index) {
        Device product = productList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(15),
          height: 120,
          decoration: BoxDecoration(
              color: Colors.grey[200]?.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      product.image,
                      width: 70,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Text(
                      //TODO:
                      "20",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "location",
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 23),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: 10.0,
                      onPressed: () => {}, //TODO:
                      icon: const Icon(
                        Icons.remove,
                        color: Color(0xFFEC6813),
                      ),
                    ),
                    // GetBuilder<ProductController>(
                    //   builder: (ProductController controller) {
                    //     return AnimatedSwitcherWrapper(
                    //       child: Text(
                    //         '${controller.cartProducts[index].quantity}',
                    //         key: ValueKey<int>(
                    //             controller.cartProducts[index].quantity),
                    //         style: const TextStyle(
                    //             fontSize: 18, fontWeight: FontWeight.w700),
                    //       ),
                    //     );
                    //   },
                    // ),
                    IconButton(
                      splashRadius: 10.0,
                      onPressed: () => {}, // TODO:
                      icon: const Icon(
                        Icons.add,
                        color: Color(0xFFEC6813),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildBottomBarTitle() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }

  Widget buildBottomBarButton() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: ElevatedButton(
            child: const Text("blahblah"),
            onPressed: is_empty ? null : () {},
          ),
        ),
      ),
    );
  }
}
