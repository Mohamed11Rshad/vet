class Podcasts {
  late int id;
  late String name;
  late String url;

  Podcasts({
    required this.id,
    required this.name,
    required this.url,

  });


  factory Podcasts.fromJson(Map<String, dynamic> json) {
    return Podcasts(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'url' :url,
    

  };
}