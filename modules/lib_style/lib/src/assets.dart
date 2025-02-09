import '../lib_style.dart';

class Assets {
  SvgPicture getSvgAsset(
    String assetIdentifier, {
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      assetIdentifier,
      width: width,
      height: height,
    );
  }
}
