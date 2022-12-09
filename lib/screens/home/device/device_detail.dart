import 'package:final_frontend/data/model/device.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  final Device product;

  ItemPage(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProductPageView(width, height),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildName(context),
                    const SizedBox(height: 10),
                    const SizedBox(height: 30),
                    buildDescription(context),
                    const SizedBox(height: 20),
                    buildButtonAdd()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildProductPageView(double width, double height) {
    return Container(
      height: height * 0.42,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFE5E6E8),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(200),
          bottomLeft: Radius.circular(200),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.32,
            child: FittedBox(
              fit: BoxFit.none,
              child: Image.asset(
                product.image,
                scale: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text buildName(BuildContext context) {
    return Text(
      product.name,
      style: Theme.of(context).textTheme.headline2,
    );
  }

  SizedBox buildButtonAdd() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text("Add to cart"),
        onPressed: product.on ? () => {} : null,
      ),
    );
  }

  Widget buildDescription(BuildContext context) {
    return Column(children: [
      Text(
        "About",
        style: Theme.of(context).textTheme.headline4,
      ),
      const SizedBox(height: 10),
      Text(product.about)
    ]);
  }
}