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
  final String? externalUrl;
  final String? screenCraftSlug;
  final String? category; // 'professional' or 'personal'

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
    this.externalUrl,
    this.screenCraftSlug,
    this.category,
  });

  /// Dynamically computes the full ScreenCraft URL or external link.
  /// Prefers [screenCraftSlug] if available, otherwise fixes root-level ScreenCraft URLs
  /// to format: https://screencraft-ai.vercel.app/project/{slug}
  String? get effectiveExternalUrl {
    if (screenCraftSlug != null && screenCraftSlug!.trim().isNotEmpty) {
      return 'https://screencraft-ai.vercel.app/project/${screenCraftSlug!.trim()}';
    }
    if (externalUrl != null && externalUrl!.trim().isNotEmpty) {
      final url = externalUrl!.trim();
      if (url.startsWith('https://screencraft-ai.vercel.app/') &&
          !url.startsWith('https://screencraft-ai.vercel.app/project/')) {
        final slug = url.replaceFirst('https://screencraft-ai.vercel.app/', '');
        return 'https://screencraft-ai.vercel.app/project/$slug';
      }
      return url;
    }
    return null;
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: DateTime.now().millisecondsSinceEpoch,
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
      externalUrl: json['externalUrl'] ?? json['external_url'],
      screenCraftSlug: json['screenCraftSlug'] ?? json['screen_craft_slug'],
      category: json['category'] ?? 'professional',
    );
  }
}
