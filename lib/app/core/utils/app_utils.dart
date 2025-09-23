class AppUtils {
  // Private constructor to prevent instantiation
  AppUtils._();

  /// Format date into readable format: "23 Dec 2023 03:43 pm"
  static String formatDate(dynamic dateInput) {
    DateTime dt;

    if (dateInput is DateTime) {
      dt = dateInput;
    } else if (dateInput is String) {
      try {
        // Handle format like "2023-12-23 15:43"
        if (dateInput.contains(' ') && !dateInput.contains('T')) {
          dt = DateTime.parse(dateInput.replaceAll(' ', 'T'));
        } else {
          dt = DateTime.parse(dateInput);
        }
      } catch (e) {
        // Fallback to current time if parsing fails
        dt = DateTime.now();
      }
    } else {
      dt = DateTime.now();
    }

    final month = _monthName(dt.month);
    final hour12 = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'pm' : 'am';
    return '${dt.day} $month ${dt.year} ${hour12.toString().padLeft(2, '0')}:$minute $ampm';
  }

  /// Get month name from int
  static String _monthName(int m) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[m - 1];
  }

  /// Example: capitalize first letter of a string
  static String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  /// Example: check if string is email
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }
}
