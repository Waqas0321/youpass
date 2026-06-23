class PartyDrinkMenuCategory {
  const PartyDrinkMenuCategory({
    required this.slug,
    required this.name,
    this.icon,
  });

  final String slug;
  final String name;
  final String? icon;

  static const allSlug = 'all';
}
