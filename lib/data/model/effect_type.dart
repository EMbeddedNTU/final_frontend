enum EffectType {
  local,
  // specific,
  global,
}

extension EffectTypeExt on EffectType {
  String getText() {
    switch (this) {
      case EffectType.local:
        return "針對鄰近裝置";
      case EffectType.global:
        return "針對特定裝置";
      // case EffectType.specific:
      //   return "";
      default:
        return '';
    }
  }
}
