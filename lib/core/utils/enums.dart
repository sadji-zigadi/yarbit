enum OrderStatus {
  pending,
  done,
  rejected,
  hold,
}

extension OrderStatusParsing on OrderStatus {
  String get value {
    return switch (this) {
      OrderStatus.pending => 'pending',
      OrderStatus.done => 'accepted',
      OrderStatus.rejected => 'rejected',
      OrderStatus.hold => 'hold',
    };
  }

  static OrderStatus fromValue(String value) {
    switch (value) {
      case 'pending':
        return OrderStatus.pending;
      case 'accepted':
        return OrderStatus.done;
      case 'rejected':
        return OrderStatus.rejected;
      case 'hold':
        return OrderStatus.hold;
      default:
        throw Exception('Invalid value');
    }
  }
}
