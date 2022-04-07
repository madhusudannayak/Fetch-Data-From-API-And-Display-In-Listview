class ApiResponse {
  List<Superheros>? superheros;

  ApiResponse({this.superheros});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['superheros'] != null) {
      superheros = <Superheros>[];
      json['superheros'].forEach((v) {
        superheros!.add(new Superheros.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.superheros != null) {
      data['superheros'] = this.superheros!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Superheros {
  String? name;
  String? power;
  String? url;

  Superheros({this.name, this.power, this.url});

  Superheros.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    power = json['power'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['power'] = this.power;
    data['url'] = this.url;
    return data;
  }
}
