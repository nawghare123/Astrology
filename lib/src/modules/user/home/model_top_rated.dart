// 


// To parse this JSON data, do
//
//     final topRatedModel = topRatedModelFromJson(jsonString);

import 'dart:convert';

TopRatedModel topRatedModelFromJson(String str) => TopRatedModel.fromJson(json.decode(str));

String topRatedModelToJson(TopRatedModel data) => json.encode(data.toJson());

class TopRatedModel {
    bool? status;
    int? success;
    Data? data;
    String? msg;

    TopRatedModel({
        this.status,
        this.success,
        this.data,
        this.msg,
    });

    factory TopRatedModel.fromJson(Map<String, dynamic> json) => TopRatedModel(
        status: json["Status"],
        success: json["success"],
        data: Data.fromJson(json["data"]),
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "success": success,
        "data": data!.toJson(),
        "msg": msg,
    };
}

class Data {
    TopRatedMentors? topRatedMentors;

    Data({
        this.topRatedMentors,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        topRatedMentors: TopRatedMentors.fromJson(json["topRatedMentors"]),
    );

    Map<String, dynamic> toJson() => {
        "topRatedMentors": topRatedMentors!.toJson(),
    };
}

class TopRatedMentors {
    int? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic? nextPageUrl;
    String? path;
    int? perPage;
    dynamic? prevPageUrl;
    int? to;
    int? total;

    TopRatedMentors({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory TopRatedMentors.fromJson(Map<String, dynamic> json) => TopRatedMentors(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    int? userId;
    String? firstName;
    String? lastName;
    String? imagePath;
    List<List<Occupation>>? occupation;
    List<String>? religion;
	  DateTime? from;
    DateTime?to;
    String? onlineStatus;
    int? topRating;
    Category? category;
    int? ratingCount;
    int? ratingAvg;

    Datum({
        this.userId,
        this.firstName,
        this.lastName,
        this.imagePath,
        this.occupation,
        this.religion,
        this.from,
        this.to,
        this.onlineStatus,
        this.topRating,
        this.category,
        this.ratingCount,
        this.ratingAvg,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        imagePath: json["image_path"],
        occupation: List<List<Occupation>>.from(json["occupation"].map((x) => List<Occupation>.from(x.map((x) => Occupation.fromJson(x))))),
        religion: List<String>.from(json["religion"].map((x) => x)),
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        onlineStatus: json["online_status"],
        topRating: json["topRating"],
        category: Category.fromJson(json["category"]),
        ratingCount: json["ratingCount"],
        ratingAvg: json["ratingAvg"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "image_path": imagePath,
        "occupation": List<dynamic>.from(occupation!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
         "religion": List<dynamic>.from(religion!.map((x) => x)),
        "from": "${from!.year.toString().padLeft(4, '0')}-${from!.month.toString().padLeft(2, '0')}-${from!.day.toString().padLeft(2, '0')}",
        "to": "${to!.year.toString().padLeft(4, '0')}-${to!.month.toString().padLeft(2, '0')}-${to!.day.toString().padLeft(2, '0')}",
        "online_status": onlineStatus,
        "topRating": topRating,
        "category": category!.toJson(),
        "ratingCount": ratingCount,
        "ratingAvg": ratingAvg,
    };
}

class Category {
    int? id;
    int? parentId;
    String? name;
    String? slug;
    String? imagePath;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;

    Category({
        this.id,
        this.parentId,
        this.name,
        this.slug,
        this.imagePath,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        slug: json["slug"],
        imagePath: json["image_path"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "slug": slug,
        "image_path": imagePath,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
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

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}