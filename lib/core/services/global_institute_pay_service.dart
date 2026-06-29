import 'dart:async';
import 'package:app_links/app_links.dart';

/// =======================================================
/// PAYMENT CALLBACK MODEL
/// =======================================================

class PaymentCallbackData {
  final String status;
  final String? reference;
  final String? transactionId;

  const PaymentCallbackData({
    required this.status,
    this.reference,
    this.transactionId,
  });

  bool get isSuccess => status == 'success';
}

/// =======================================================
/// GLOBAL INSTITUTE PAY SERVICE
/// =======================================================

class GlobalInstitutePayService {
  /// Singleton
  static final GlobalInstitutePayService _instance =
      GlobalInstitutePayService._();

  factory GlobalInstitutePayService() => _instance;

  GlobalInstitutePayService._();

  /// Broadcast Stream
  final StreamController<PaymentCallbackData> _callbackController =
      StreamController<PaymentCallbackData>.broadcast();

  Stream<PaymentCallbackData> get onCallback => _callbackController.stream;

  /// Cold Start Callback
  PaymentCallbackData? _pendingCallback;

  PaymentCallbackData? consumePendingCallback() {
    final data = _pendingCallback;
    _pendingCallback = null;
    return data;
  }

  /// =======================================================
  /// INIT
  /// =======================================================

  Future<void> init() async {
    final appLinks = AppLinks();

    // KASUS 1: App dibuka oleh deeplink (cold start)
    try {
      final uri = await appLinks.getInitialLink();
      if (uri != null) _handleUri(uri, isColdStart: true);
    } catch (_) {}

    // KASUS 2: Deeplink masuk saat app sudah berjalan
    appLinks.uriLinkStream.listen(_handleUri);
  }

  /// =======================================================
  /// HANDLE URI
  /// =======================================================

  void _handleUri(Uri uri, {bool isColdStart = false}) {
    if (uri.scheme == 'pasarmalam' && uri.host == 'payment-callback') {
      final data = PaymentCallbackData(
        status: uri.queryParameters['status'] ?? 'unknown',
        reference: uri.queryParameters['reference'],
        transactionId: uri.queryParameters['transaction_id'],
      );

      if (isColdStart) _pendingCallback = data;

      _callbackController.add(data);
    }
  }

  /// =======================================================
  /// BUILD DEEPLINK
  /// =======================================================

  static String buildDeeplinkUrl({
    required int orderId,
    required double amount,
    String? description,
  }) {
    final uri = Uri(
      scheme: 'dompetkampus',
      host: 'pay',
      queryParameters: {
        'merchant_id': 'MCH_PASAR_MALAM',

        'merchant_name': 'Pasar Malam',

        'amount': amount.toInt().toString(),

        'description': (description != null && description.isNotEmpty)
            ? description
            : 'Order #$orderId',

        'reference': 'INV-$orderId',

        'callback': 'pasarmalam://payment-callback',
      },
    );

    return uri.toString();
  }
}
