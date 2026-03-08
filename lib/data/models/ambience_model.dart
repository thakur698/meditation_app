class AmbienceModel {
  final String title;
  final String tag;
  final int duration;
  final String image;
  final String audio;
  final String description;

  AmbienceModel({
    required this.title,
    required this.tag,
    required this.duration,
    required this.image,
    required this.audio,
    required this.description,
  });

  factory AmbienceModel.fromJson(Map<String, dynamic> json) {
    return AmbienceModel(
      title: json['title'],
      tag: json['tag'],
      duration: json['duration'],
      image: json['image'],
      audio: json['audio'],
      description: json['description'],
    );
  }
}
