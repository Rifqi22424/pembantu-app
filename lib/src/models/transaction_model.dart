class Transaction {
  final int id;
  final String nominal;
  final String transactionType;
  final int bankId;
  final int walletId;
  final int receiverId;
  final int senderId;
  final String orderId;
  final int statusPembayaran;

  Transaction({
    required this.id,
    required this.nominal,
    required this.transactionType,
    required this.bankId,
    required this.walletId,
    required this.receiverId,
    required this.senderId,
    required this.orderId,
    required this.statusPembayaran,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int,
      nominal: json['nominal'] as String,
      transactionType: json['transaction_type'] as String,
      bankId: json['bank_id'] as int,
      walletId: json['wallet_id'] as int,
      receiverId: json['receiver_id'] as int,
      senderId: json['sender_id'] as int,
      orderId: json['order_id'] as String,
      statusPembayaran: json['status_pembayaran'] as int,
    );
  }
}
