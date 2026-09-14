class Certificate {
  final String id;
  final String title;
  final String issuer;
  final String category;
  final String priority;
  final String format; // 'image' or 'pdf'
  final String filePath;
  final String? year;

  Certificate({
    required this.id,
    required this.title,
    required this.issuer,
    required this.category,
    required this.priority,
    required this.format,
    required this.filePath,
    this.year,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      issuer: json['issuer'] ?? '',
      category: json['category'] ?? 'Other',
      priority: json['priority'] ?? 'medium',
      format: json['format'] ?? 'image',
      filePath: json['filePath'] ?? '',
      year: json['year'],
    );
  }
}
