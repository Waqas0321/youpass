class PartyDrinkCartQuantities {
  PartyDrinkCartQuantities._();

  static int read(Map<String, int> quantities, String drinkId) =>
      quantities[drinkId] ?? 0;

  static void adjust(Map<String, int> quantities, String drinkId, int delta) {
    final next = read(quantities, drinkId) + delta;
    if (next <= 0) {
      quantities.remove(drinkId);
      return;
    }
    quantities[drinkId] = next;
  }

  static Map<String, int> copy(Map<String, int> quantities) =>
      Map<String, int>.from(quantities);
}
