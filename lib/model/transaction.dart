class Transaction {
  final int? id;
  final int amount;
  final String date;

  Transaction({this.id, required this.amount, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      amount: map['amount'],
      date: map['date'],
    );
  }
}
