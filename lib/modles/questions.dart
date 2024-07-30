class Questions {
  final String id;
  final String title;
  final Map<String, int> options; // Updated to store scores as integers
  final double weight; // Added weight attribute

  Questions({
    required this.id,
    required this.title,
    required this.options,
    required this.weight,
  });

  @override
  String toString() {
    return 'Questions(id: $id, title: $title, options: $options, weight: $weight)';
  }
}
