extension StringExtension on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  bool get isValidPhoneNumber {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  String get removeSpaces {
    return replaceAll(' ', '');
  }

  String get onlyNumbers {
    return replaceAll(RegExp(r'[^0-9]'), '');
  }

  String get onlyLetters {
    return replaceAll(RegExp(r'[^a-zA-Z]'), '');
  }

  String truncate(int maxLength, [String suffix = '...']) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  String get initials {
    if (isEmpty) return '';
    final words = trim().split(' ');
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return '${words[0].substring(0, 1)}${words[1].substring(0, 1)}'.toUpperCase();
  }

  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  String? get nullIfEmpty {
    return isEmpty ? null : this;
  }

  String formatPhoneNumber() {
    final numbers = onlyNumbers;
    if (numbers.length == 10) {
      return '(${numbers.substring(0, 3)}) ${numbers.substring(3, 6)}-${numbers.substring(6)}';
    }
    return this;
  }

  String maskEmail() {
    if (!isValidEmail) return this;
    final parts = split('@');
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) return this;
    
    final maskedUsername = '${username.substring(0, 2)}${'*' * (username.length - 2)}';
    return '$maskedUsername@$domain';
  }
}
