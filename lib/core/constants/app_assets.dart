/// Central asset paths (include file extensions).
class AppAssets {
  AppAssets._();

  static const String _imagesRoot = 'assets/images';

  /// Default placeholder image for home events, carousel, and profile.
  static const String dummyImage = '$_imagesRoot/dummy.jpeg';

  /// Official YouPass brand logo used on splash / launch screens.
  static const String youpassLogo = '$_imagesRoot/youpass_logo.png';

  /// Home header pill shown when Party Mode is off.
  static const String youpassPartyModeOffPill =
      '$_imagesRoot/youpass_party_mode_off_pill.png';

  /// Home header pill shown when Party Mode is on.
  static const String youpassPartyModeOnPill =
      '$_imagesRoot/youpass_party_mode_on_pill.png';
}
