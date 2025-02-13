class Expense {
  final int? id;
  final String title;
  final double amount;
  final DateTime date;
  final String time;  // ✅ Store time as a string
  final String description;

  Expense({this.id, required this.title, required this.amount, required this.date, required this.time, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'time': time,  // ✅ Save formatted time
      'description': description,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      time: map['time'],  // ✅ Retrieve time
      description: map['description'],
    );
  }
}
