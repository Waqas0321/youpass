class CountryCode {
  const CountryCode({
    required this.name,
    required this.isoCode,
    required this.dialCode,
    required this.flagEmoji,
    required this.phoneHint,
    this.defaultLanguage = 'es',
    this.defaultCurrency = 'CLP',
    this.timezone = 'America/Santiago',
    this.paymentGateway = 'klap',
    this.currencyDecimals = 0,
    this.currencySymbol = r'$',
  });

  final String name;
  final String isoCode;
  final String dialCode;
  final String flagEmoji;
  final String phoneHint;
  final String defaultLanguage;
  final String defaultCurrency;
  final String timezone;
  final String paymentGateway;
  final int currencyDecimals;
  final String currencySymbol;

  String get displayDialCode => '+$dialCode';
}
