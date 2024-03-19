// //import 'package:consultant_product/src/modules/user/home/model_top_rated.dart';

// class FeaturedConsultantModel {
//   FeaturedConsultantModel({
//     bool? status,
//     int? success,
//     FeaturedConsultantModelData? data,
//     String? msg,
//   }) {
//     _status = status;
//     _success = success;
//     _data = data;
//     _msg = msg;
//   }

//   FeaturedConsultantModel.fromJson(dynamic json) {
//     _status = json['Status'];
//     _success = json['success'];
//     _data = json['data'] != null
//         ? FeaturedConsultantModelData.fromJson(json['data'])
//         : null;
//     _msg = json['msg'];
//   }

//   bool? _status;
//   int? _success;
//   FeaturedConsultantModelData? _data;
//   String? _msg;

//   bool? get status => _status;

//   int? get success => _success;

//   FeaturedConsultantModelData? get data => _data;

//   String? get msg => _msg;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['Status'] = _status;
//     map['success'] = _success;
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     map['msg'] = _msg;
//     return map;
//   }
// }

// class FeaturedConsultantModelData {
//   FeaturedConsultantModelData({
//     List<Datum>? mentors,
//   }) {
//     _mentors = mentors;
//   }

//   FeaturedConsultantModelData.fromJson(dynamic json) {
//     if (json['mentors'] != null) {
//       _mentors = [];
//       json['mentors'].forEach((v) {
//         _mentors?.add(Datum.fromJson(v));
//       });
//     }
//   }

//   List<Datum>? _mentors;

//   List<Datum>? get mentors => _mentors;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_mentors != null) {
//       map['mentors'] = _mentors?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }


class FeaturedConsultantModel {
  bool? status;
  int? success;
  Data? data;
  String? msg;

  FeaturedConsultantModel({this.status, this.success, this.data, this.msg});

  FeaturedConsultantModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  List<Mentors>? mentors;

  Data({this.mentors});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['mentors'] != null) {
      mentors = <Mentors>[];
      json['mentors'].forEach((v) {
        mentors!.add(new Mentors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mentors != null) {
      data['mentors'] = this.mentors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mentors {
  String? firstName;
  String? lastName;
  String? imagePath;
  int? userId;
  List<List<Occupation>>? occupation;
  String? gender;
  int? ratingAvg;
  int? ratingCount;
  int? topRating;
  Category? category;

  Mentors(
      {this.firstName,
      this.lastName,
      this.imagePath,
      this.userId,
      this.occupation,
      this.gender,
      this.ratingAvg,
      this.ratingCount,
      this.topRating,
      this.category});

factory Mentors.fromJson(Map<String, dynamic> json) => Mentors(
        firstName: json["first_name"],
        lastName: json["last_name"],
        occupation: List<List<Occupation>>.from(json["occupation"].map((x) => List<Occupation>.from(x.map((x) => Occupation.fromJson(x))))),
        // religion: List<Religion>.from(json["religion"].map((x) => religionValues.map[x])),
        imagePath: json["image_path"],
        userId: json["user_id"],
        gender: json["gender"],
        ratingAvg: json["ratingAvg"],
        ratingCount: json["ratingCount"],
        topRating: json["topRating"],
        category: Category.fromJson(json["category"]),
    );
  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "occupation": List<dynamic>.from(occupation!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        // "religion": List<dynamic>.from(religion.map((x) => religionValues.reverse[x])),
        "image_path": imagePath,
        "user_id": userId,
        "gender": gender,
        "ratingAvg": ratingAvg,
        "ratingCount": ratingCount,
        "topRating": topRating,
        "category": category!.toJson(),
    };

}


class Category {
  int? id;
  int? parentId;
  String? name;
  String? slug;
  String? imagePath;
  String? description;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.parentId,
      this.name,
      this.slug,
      this.imagePath,
      this.description,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    slug = json['slug'];
    imagePath = json['image_path'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image_path'] = this.imagePath;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  
}


class Occupation {
    String? name;

    Occupation({
        this.name,
    });

    factory Occupation.fromJson(Map<String, dynamic> json) => Occupation(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}