class Ticket {
  final String id;
  final String subject;
  final String status;
  final String priority;
  final String customerName;
  final DateTime date;
  final String brand;
  final List<String> tags;
  final String category;
  final String department;

  Ticket({
    required this.id,
    required this.subject,
    required this.status,
    required this.priority,
    required this.customerName,
    required this.date,
    required this.brand,
    required this.tags,
    required this.category,
    required this.department,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    DateTime parseDate(dynamic dateInput) {
      try {
        if (dateInput == null) return DateTime.now();

        String dateStr = dateInput.toString();
        // Handle format like "2023-12-23 15:43"
        if (dateStr.contains(' ') && !dateStr.contains('T')) {
          return DateTime.parse(dateStr.replaceAll(' ', 'T'));
        }
        return DateTime.parse(dateStr);
      } catch (e) {
        // Fallback to current time if parsing fails
        return DateTime.now();
      }
    }

    return Ticket(
      id: json['id']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      priority: json['priority']?.toString() ?? '',
      customerName: json['customerName']?.toString() ?? '',
      date: parseDate(json['date']),
      brand: json['brand']?.toString() ?? '',
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      category: json['category']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'status': status,
      'priority': priority,
      'customerName': customerName,
      'date': date.toIso8601String().replaceAll('T', ' ').substring(0, 19),
      'brand': brand,
      'tags': tags,
      'category': category,
      'department': department,
    };
  }
}
