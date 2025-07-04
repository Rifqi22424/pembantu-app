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
  final String namaLengkap;

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
    required this.namaLengkap,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? 0,
      nominal: json['nominal']?.toString() ?? '',
      transactionType: json['transaction_type']?.toString() ?? '',
      bankId: json['bank_id'] ?? 0,
      walletId: json['wallet_id'] ?? 0,
      receiverId: json['receiver_id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      orderId: json['order_id']?.toString() ?? '',
      statusPembayaran: json['status_pembayaran'] ?? 0,
      namaLengkap: json['nama_lengkap']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'Transaction('
        'id: $id, '
        'nominal: $nominal, '
        'transactionType: $transactionType, '
        'bankId: $bankId, '
        'walletId: $walletId, '
        'receiverId: $receiverId, '
        'senderId: $senderId, '
        'orderId: $orderId, '
        'statusPembayaran: $statusPembayaran, '
        'namaLengkap: $namaLengkap'
        ')';
  }
}
