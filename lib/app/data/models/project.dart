class Project {
  final int id;
  final String title;
  final String description;
  final String image;
  final List<String> techStack;
  final String? githubLink;
  final List<String>? modules;
  final String? duration;
  final String? type;
  final String? platform;
  final String? year;
  final String? about;
  final List<String>? features;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.techStack,
    this.githubLink,
    this.modules,
    this.duration,
    this.type,
    this.platform,
    this.year,
    this.about,
    this.features,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: DateTime.now().millisecondsSinceEpoch, // Generate a temporary ID
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      techStack: List<String>.from(json['tech_stack'] ?? []),
      githubLink: json['github_link'],
      modules:
          json['modules'] != null ? List<String>.from(json['modules']) : null,
      duration: json['duration'],
      type: json['type'],
      platform: json['platform'],
      year: json['year'],
      about: json['about'],
      features:
          json['features'] != null ? List<String>.from(json['features']) : null,
    );
  }
}
