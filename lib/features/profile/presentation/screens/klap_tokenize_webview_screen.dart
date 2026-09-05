import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/webview_platform_init.dart';
import 'package:youpass/core/widgets/youpass_branded_app_bar_widget.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_data_model.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class KlapTokenizeWebViewScreen extends StatefulWidget {
  const KlapTokenizeWebViewScreen({
    super.key,
    required this.session,
  });

  final ProfileWalletTokenizeSessionModel session;

  @override
  State<KlapTokenizeWebViewScreen> createState() =>
      _KlapTokenizeWebViewScreenState();
}

class _KlapTokenizeWebViewScreenState extends State<KlapTokenizeWebViewScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  WebViewController? controller;
  bool isLoading = true;
  bool platformReady = false;

  @override
  void initState() {
    super.initState();
    ensureWebViewPlatformInitialized();
    platformReady = isWebViewPlatformSupported;
    if (platformReady) {
      _initController();
    } else {
      isLoading = false;
    }
  }

  void _initController() {
    final webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              setState(() => isLoading = false);
            }
          },
          onNavigationRequest: (request) {
            final uri = Uri.tryParse(request.url);
            if (uri != null && _handleRedirect(uri)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.session.tokenizationUrl));

    controller = webController;
  }

  bool _handleRedirect(Uri uri) {
    final scheme = widget.session.successRedirectScheme;
    final expectedScheme = Uri.tryParse(scheme)?.scheme ?? 'youpass';

    if (uri.scheme != expectedScheme) {
      return false;
    }

    final request = PaymentMethodRequestEntity(
      paymentMethodId: uri.queryParameters['payment_method_id'],
      gateway: uri.queryParameters['gateway'] ?? widget.session.gateway,
      brand: uri.queryParameters['brand'] ?? 'visa',
      lastFour: uri.queryParameters['last_four'] ?? '0000',
      cardholderName: Uri.decodeComponent(
        uri.queryParameters['cardholder_name'] ?? 'Cardholder',
      ),
      expirationMonth: int.tryParse(
        uri.queryParameters['expiration_month'] ?? '',
      ),
      expirationYear: int.tryParse(
        uri.queryParameters['expiration_year'] ?? '',
      ),
      setAsDefault: true,
    );

    if (request.paymentMethodId == null ||
        request.paymentMethodId!.trim().isEmpty) {
      return false;
    }

    Navigator.of(context).pop(request);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ProfileTheme.of(context);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      backgroundColor: theme.screenBackground,
      appBar: YouPassBrandedAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        primaryColor: AppColors.homeAccentYellow,
        backgroundColor: theme.screenBackground,
      ),
      body: !platformReady || controller == null
          ? Center(
              child: Text(
                'WebView is not available on this device.',
                style: TextStyle(color: theme.labelText),
              ),
            )
          : Stack(
              children: [
                WebViewWidget(controller: controller!),
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: theme.primary,
                    ),
                  ),
              ],
            ),
    );
  }
}
