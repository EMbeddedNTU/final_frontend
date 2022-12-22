enum GestureType {
  left,
  right,
  backward,
  forward,
  down,
  up,
}

extension GestureTypeExt on GestureType {
  String getText() {
    switch (this) {
      case GestureType.left:
        return "手往左移動";
      case GestureType.right:
        return "手往右移動";
      case GestureType.backward:
        return "手往後移動";
      case GestureType.forward:
        return "手往前移動";
      case GestureType.down:
        return "手往下移動";
      case GestureType.up:
        return "手往上移動";
      default:
        return '';
    }
  }
}
