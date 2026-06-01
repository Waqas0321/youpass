class CountryCode {
  const CountryCode({
    required this.name,
    required this.isoCode,
    required this.dialCode,
    required this.flagEmoji,
    required this.phoneHint,
  });

  final String name;
  final String isoCode;
  final String dialCode;
  final String flagEmoji;
  final String phoneHint;

  String get displayDialCode => '+$dialCode';
}
