enum DeviceLocation { other, porch, door, livingRoom, diningRoom, bedroom }

class Device {
  String name;
  bool on;
  String image;
  String about;
  DeviceLocation location;

  Device(
      {required this.name,
      required this.on,
      required this.image,
      required this.about,
      required this.location});
}
