// To parse this JSON data, do
//
//     final getMenteeModel = getMenteeModelFromJson(jsonString);

import 'dart:convert';

GetMenteeModel getMenteeModelFromJson(String str) => GetMenteeModel.fromJson(json.decode(str));

String getMenteeModelToJson(GetMenteeModel data) => json.encode(data.toJson());

class GetMenteeModel {
    bool? status;
    int? success;
    Data? data;
    String? msg;

    GetMenteeModel({
        this.status,
        this.success,
        this.data,
        this.msg,
    });

    factory GetMenteeModel.fromJson(Map<String, dynamic> json) => GetMenteeModel(
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
    String? onlineStatus;
    dynamic? imagePath;

    Datum({
        this.userId,
        this.firstName,
        this.lastName,
        this.onlineStatus,
        this.imagePath,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        onlineStatus: json["online_status"],
        imagePath: json["image_path"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "online_status": onlineStatus,
        "image_path": imagePath,
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
