/// Progressive name abbreviation for the home header greeting (Cases 1–5).
class HomeGreetingFormatter {
  HomeGreetingFormatter._();

  static const int maxDisplayLength = 18;

  /// Returns the name portion used in `Hello, {name}!` / `¡Hola, {name}!`.
  static String abbreviatedName(String fullName) {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) {
      return trimmed;
    }

    final parts = trimmed.split(RegExp(r'\s+'));
    final firstName = _capitalizeToken(parts.first);

    if (parts.length == 1) {
      return _resolveSingleName(firstName);
    }

    final surnameParts = parts.sublist(1);
    final firstSurname = _capitalizeToken(surnameParts.first);

    // Case 1: first name + full first surname (≤18 chars).
    final firstAndSurname = '$firstName $firstSurname';
    if (firstAndSurname.length <= maxDisplayLength) {
      return firstAndSurname;
    }

    // Case 3: first name + surname initial.
    final withInitial = '$firstName ${_surnameInitial(firstSurname)}';
    if (withInitial.length <= maxDisplayLength) {
      return withInitial;
    }

    // Case 4: first name only.
    if (firstName.length <= maxDisplayLength) {
      return firstName;
    }

    // Case 5: nickname.
    return _nickname(firstName);
  }

  static String _resolveSingleName(String firstName) {
    if (firstName.length <= maxDisplayLength) {
      if (firstName.length > 10) {
        return _nickname(firstName);
      }
      return firstName;
    }
    return _nickname(firstName);
  }

  static String _surnameInitial(String surname) {
    if (surname.isEmpty) {
      return '';
    }
    return '${surname[0].toUpperCase()}.';
  }

  static String _nickname(String firstName) {
    if (firstName.length <= 4) {
      return firstName;
    }
    final length = firstName.length > 10 ? 4 : 5;
    return _capitalizeToken(firstName.substring(0, length));
  }

  static String _capitalizeToken(String token) {
    if (token.isEmpty) {
      return token;
    }
    if (token.length == 1) {
      return token.toUpperCase();
    }
    return token[0].toUpperCase() + token.substring(1).toLowerCase();
  }
}
