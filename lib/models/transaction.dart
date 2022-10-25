class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    required this.id,
    required this.date,
    required this.title,
    required this.value,
  });
}
