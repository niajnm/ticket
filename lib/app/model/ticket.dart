class Ticket {
  final String id;
  final String subject;
  final String status;
  final String priority;
  final String customerName;
  final DateTime date;
  final String brand;
  final List<String> tags;

  Ticket({
    required this.id,
    required this.subject,
    required this.status,
    required this.priority,
    required this.customerName,
    required this.date,
    required this.brand,
    required this.tags,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json["id"],
      subject: json["subject"],
      status: json["status"],
      priority: json["priority"],
      customerName: json["customerName"],
      date: DateTime.parse(json["date"].replaceAll(" ", "T")),
      brand: json["brand"],
      tags: List<String>.from(json["tags"]),
    );
  }
}
