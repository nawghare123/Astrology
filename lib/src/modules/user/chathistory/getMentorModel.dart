// To parse this JSON data, do
//
//     final getMentorModel = getMentorModelFromJson(jsonString);

import 'dart:convert';

GetMentorModel getMentorModelFromJson(String str) => GetMentorModel.fromJson(json.decode(str));

String getMentorModelToJson(GetMentorModel data) => json.encode(data.toJson());

class GetMentorModel {
    bool? status;
    int? success;
    Data? data;
    String? msg;

    GetMentorModel({
        this.status,
        this.success,
        this.data,
        this.msg,
    });

    factory GetMentorModel.fromJson(Map<String, dynamic> json) => GetMentorModel(
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

    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    List<List<AppointmentTypeId>>? occupation;
    List<String>? religion;
	 DateTime? from;
    DateTime?to;
    dynamic? description;
    String? onlineStatus;
    String? imagePath;

    Datum({
        this.userId,
        this.firstName,
        this.lastName,
        this.occupation,
        this.religion,
        this.from,
        this.to,
        this.description,
        this.onlineStatus,
        this.imagePath,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        occupation: List<List<AppointmentTypeId>>.from(json["occupation"].map((x) => List<AppointmentTypeId>.from(x.map((x) => AppointmentTypeId.fromJson(x))))),
        religion: List<String>.from(json["religion"].map((x) => x)),
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        description: json["description"],
        onlineStatus: json["online_status"],
        imagePath: json["image_path"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "occupation": List<dynamic>.from(occupation!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
            "religion": List<dynamic>.from(religion!.map((x) => x)),
        "from": "${from!.year.toString().padLeft(4, '0')}-${from!.month.toString().padLeft(2, '0')}-${from!.day.toString().padLeft(2, '0')}",
        "to": "${to!.year.toString().padLeft(4, '0')}-${to!.month.toString().padLeft(2, '0')}-${to!.day.toString().padLeft(2, '0')}",
        "description": description,
        "online_status": onlineStatus,
        "image_path": imagePath,
    };
}


class AppointmentTypeId {
    String? name;

    AppointmentTypeId({
        this.name,
    });

    factory AppointmentTypeId.fromJson(Map<String, dynamic> json) => AppointmentTypeId(
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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
