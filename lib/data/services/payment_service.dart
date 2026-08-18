import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();

  factory PaymentService() {
    return _instance;
  }

  PaymentService._internal();

  late Razorpay _razorpay;
  Function(dynamic)? _onPaymentSuccess;
  Function(dynamic)? _onPaymentError;
  Function(dynamic)? _onExternalWalletSelected;

  /// Initialize Razorpay
  void initialize({
    required Function(dynamic) onSuccess,
    required Function(dynamic) onError,
    required Function(dynamic) onExternalWallet,
  }) {
    _razorpay = Razorpay();
    _onPaymentSuccess = onSuccess;
    _onPaymentError = onError;
    _onExternalWalletSelected = onExternalWallet;

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  /// Create Razorpay Order
  void createOrder({
    required String orderId,
    required double amount, // Amount in paise (₹100 = 10000 paise)
    required String userName,
    required String userEmail,
    required String userPhone,
    Map<String, String>? notes,
  }) {
    try {
      var options = {
        'key': 'YOUR_RAZORPAY_KEY_ID', // Set this in config
        'amount': (amount * 100).toInt(),
        'currency': 'INR',
        'order_id': orderId,
        'name': 'AxiovaX',
        'description': 'Add Money to Wallet',
        'prefill': {
          'contact': userPhone,
          'email': userEmail,
          'name': userName,
        },
        'notes': notes ?? {},
        'theme': {
          'color': '#6366F1',
        },
        'method': {
          'upi': true,
          'card': true,
          'netbanking': true,
          'wallet': true,
        },
      };

      _razorpay.open(options);
    } catch (e) {
      print('Error opening Razorpay: $e');
      _onPaymentError?.call({'error': e.toString()});
    }
  }

  /// Handle Payment Success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment Success: ${response.paymentId}');
    _onPaymentSuccess?.call({
      'paymentId': response.paymentId,
      'orderId': response.orderId,
      'signature': response.signature,
    });
  }

  /// Handle Payment Error
  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.message}');
    _onPaymentError?.call({
      'error': response.message,
      'code': response.code,
    });
  }

  /// Handle External Wallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
    _onExternalWalletSelected?.call({
      'wallet': response.walletName,
    });
  }

  /// Dispose Razorpay
  void dispose() {
    _razorpay.clear();
  }
}
