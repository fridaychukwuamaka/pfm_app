enum PaymentMode {
  cash,
  transfer,
  creditCard,
  debitCard,
}

extension PaymetModeExtension on PaymentMode {
  String get value {
    switch (this) {
      case PaymentMode.cash:
        return 'Cash';
      case PaymentMode.transfer:
        return 'Transfer';
      case PaymentMode.creditCard:
        return 'Credit Card';
      case PaymentMode.debitCard:
        return 'Debit Card';
    }
  }
}

PaymentMode? toPaymentMode(String val) {
  switch (val) {
    case 'Cash':
      return PaymentMode.cash;
    case 'Transfer':
      return PaymentMode.transfer;
    case 'Credit Card':
      return PaymentMode.creditCard;
    case 'Debit Card':
      return PaymentMode.debitCard;
    default:
      return null;
  }
}
