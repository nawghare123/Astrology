// // To parse this JSON data, do
// //
// //     final panchangModel = panchangModelFromJson(jsonString);

// import 'dart:convert';

// PanchangModel panchangModelFromJson(String str) => PanchangModel.fromJson(json.decode(str));

// String panchangModelToJson(PanchangModel data) => json.encode(data.toJson());

// class PanchangModel {
//     String sunRise;
//     String sunSet;
//     Weekday weekday;
//     LunarMonth lunarMonth;
//     Ritu ritu;
//     String aayanam;
//     Tithi tithi;
//     Nakshatra nakshatra;
//     Map<String, Karana> yoga;
//     Map<String, Karana> karana;
//     Year year;

//     PanchangModel({
//         required this.sunRise,
//         required this.sunSet,
//         required this.weekday,
//         required this.lunarMonth,
//         required this.ritu,
//         required this.aayanam,
//         required this.tithi,
//         required this.nakshatra,
//         required this.yoga,
//         required this.karana,
//         required this.year,
//     });

//     factory PanchangModel.fromJson(Map<String, dynamic> json) => PanchangModel(
//         sunRise: json["sun_rise"],
//         sunSet: json["sun_set"],
//         weekday: Weekday.fromJson(json["weekday"]),
//         lunarMonth: LunarMonth.fromJson(json["lunar_month"]),
//         ritu: Ritu.fromJson(json["ritu"]),
//         aayanam: json["aayanam"],
//         tithi: Tithi.fromJson(json["tithi"]),
//         nakshatra: Nakshatra.fromJson(json["nakshatra"]),
//         yoga: Map.from(json["yoga"]).map((k, v) => MapEntry<String, Karana>(k, Karana.fromJson(v))),
//         karana: Map.from(json["karana"]).map((k, v) => MapEntry<String, Karana>(k, Karana.fromJson(v))),
//         year: Year.fromJson(json["year"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "sun_rise": sunRise,
//         "sun_set": sunSet,
//         "weekday": weekday.toJson(),
//         "lunar_month": lunarMonth.toJson(),
//         "ritu": ritu.toJson(),
//         "aayanam": aayanam,
//         "tithi": tithi.toJson(),
//         "nakshatra": nakshatra.toJson(),
//         "yoga": Map.from(yoga).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
//         "karana": Map.from(karana).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
//         "year": year.toJson(),
//     };
// }

// class Karana {
//     int number;
//     String name;
//     double? karanaLeftPercentage;
//     DateTime completion;
//     double? yogaLeftPercentage;

//     Karana({
//         required this.number,
//         required this.name,
//         this.karanaLeftPercentage,
//         required this.completion,
//         this.yogaLeftPercentage,
//     });

//     factory Karana.fromJson(Map<String, dynamic> json) => Karana(
//         number: json["number"],
//         name: json["name"],
//         karanaLeftPercentage: json["karana_left_percentage"]?.toDouble(),
//         completion: DateTime.parse(json["completion"]),
//         yogaLeftPercentage: json["yoga_left_percentage"]?.toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "number": number,
//         "name": name,
//         "karana_left_percentage": karanaLeftPercentage,
//         "completion": completion.toIso8601String(),
//         "yoga_left_percentage": yogaLeftPercentage,
//     };
// }

// class LunarMonth {
//     int lunarMonthNumber;
//     String lunarMonthName;
//     String lunarMonthFullName;
//     int adhika;
//     int nija;
//     int kshaya;

//     LunarMonth({
//         required this.lunarMonthNumber,
//         required this.lunarMonthName,
//         required this.lunarMonthFullName,
//         required this.adhika,
//         required this.nija,
//         required this.kshaya,
//     });

//     factory LunarMonth.fromJson(Map<String, dynamic> json) => LunarMonth(
//         lunarMonthNumber: json["lunar_month_number"],
//         lunarMonthName: json["lunar_month_name"],
//         lunarMonthFullName: json["lunar_month_full_name"],
//         adhika: json["adhika"],
//         nija: json["nija"],
//         kshaya: json["kshaya"],
//     );

//     Map<String, dynamic> toJson() => {
//         "lunar_month_number": lunarMonthNumber,
//         "lunar_month_name": lunarMonthName,
//         "lunar_month_full_name": lunarMonthFullName,
//         "adhika": adhika,
//         "nija": nija,
//         "kshaya": kshaya,
//     };
// }

// class Nakshatra {
//     int number;
//     String name;
//     DateTime startsAt;
//     DateTime endsAt;
//     double leftPercentage;

//     Nakshatra({
//         required this.number,
//         required this.name,
//         required this.startsAt,
//         required this.endsAt,
//         required this.leftPercentage,
//     });

//     factory Nakshatra.fromJson(Map<String, dynamic> json) => Nakshatra(
//         number: json["number"],
//         name: json["name"],
//         startsAt: DateTime.parse(json["starts_at"]),
//         endsAt: DateTime.parse(json["ends_at"]),
//         leftPercentage: json["left_percentage"]?.toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "number": number,
//         "name": name,
//         "starts_at": startsAt.toIso8601String(),
//         "ends_at": endsAt.toIso8601String(),
//         "left_percentage": leftPercentage,
//     };
// }

// class Ritu {
//     int number;
//     String name;

//     Ritu({
//         required this.number,
//         required this.name,
//     });

//     factory Ritu.fromJson(Map<String, dynamic> json) => Ritu(
//         number: json["number"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "number": number,
//         "name": name,
//     };
// }

// class Tithi {
//     int number;
//     String name;
//     String paksha;
//     DateTime completesAt;
//     double leftPrecentage;

//     Tithi({
//         required this.number,
//         required this.name,
//         required this.paksha,
//         required this.completesAt,
//         required this.leftPrecentage,
//     });

//     factory Tithi.fromJson(Map<String, dynamic> json) => Tithi(
//         number: json["number"],
//         name: json["name"],
//         paksha: json["paksha"],
//         completesAt: DateTime.parse(json["completes_at"]),
//         leftPrecentage: json["left_precentage"]?.toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "number": number,
//         "name": name,
//         "paksha": paksha,
//         "completes_at": completesAt.toIso8601String(),
//         "left_precentage": leftPrecentage,
//     };
// }

// class Weekday {
//     int weekdayNumber;
//     String weekdayName;
//     int vedicWeekdayNumber;
//     String vedicWeekdayName;

//     Weekday({
//         required this.weekdayNumber,
//         required this.weekdayName,
//         required this.vedicWeekdayNumber,
//         required this.vedicWeekdayName,
//     });

//     factory Weekday.fromJson(Map<String, dynamic> json) => Weekday(
//         weekdayNumber: json["weekday_number"],
//         weekdayName: json["weekday_name"],
//         vedicWeekdayNumber: json["vedic_weekday_number"],
//         vedicWeekdayName: json["vedic_weekday_name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "weekday_number": weekdayNumber,
//         "weekday_name": weekdayName,
//         "vedic_weekday_number": vedicWeekdayNumber,
//         "vedic_weekday_name": vedicWeekdayName,
//     };
// }

// class Year {
//     String status;
//     DateTime timestamp;
//     int sakaSalivahanaNumber;
//     int sakaSalivahanaNameNumber;
//     String sakaSalivahanaYearName;
//     int vikramChaitradiNumber;
//     int vikramChaitradiNameNumber;
//     String vikramChaitradiYearName;

//     Year({
//         required this.status,
//         required this.timestamp,
//         required this.sakaSalivahanaNumber,
//         required this.sakaSalivahanaNameNumber,
//         required this.sakaSalivahanaYearName,
//         required this.vikramChaitradiNumber,
//         required this.vikramChaitradiNameNumber,
//         required this.vikramChaitradiYearName,
//     });

//     factory Year.fromJson(Map<String, dynamic> json) => Year(
//         status: json["status"],
//         timestamp: DateTime.parse(json["timestamp"]),
//         sakaSalivahanaNumber: json["saka_salivahana_number"],
//         sakaSalivahanaNameNumber: json["saka_salivahana_name_number"],
//         sakaSalivahanaYearName: json["saka_salivahana_year_name"],
//         vikramChaitradiNumber: json["vikram_chaitradi_number"],
//         vikramChaitradiNameNumber: json["vikram_chaitradi_name_number"],
//         vikramChaitradiYearName: json["vikram_chaitradi_year_name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "timestamp": timestamp.toIso8601String(),
//         "saka_salivahana_number": sakaSalivahanaNumber,
//         "saka_salivahana_name_number": sakaSalivahanaNameNumber,
//         "saka_salivahana_year_name": sakaSalivahanaYearName,
//         "vikram_chaitradi_number": vikramChaitradiNumber,
//         "vikram_chaitradi_name_number": vikramChaitradiNameNumber,
//         "vikram_chaitradi_year_name": vikramChaitradiYearName,
//     };
// }



// To parse this JSON data, do
//
//     final panchangModel = panchangModelFromJson(jsonString);

import 'dart:convert';

PanchangModel panchangModelFromJson(String str) => PanchangModel.fromJson(json.decode(str));

String panchangModelToJson(PanchangModel data) => json.encode(data.toJson());

class PanchangModel {
    String? sunRise;
    String? sunSet;
    Weekday? weekday;
    LunarMonth? lunarMonth;
    Ritu? ritu;
    String? aayanam;
    Tithi? tithi;
    Nakshatra? nakshatra;
    Map<String, Karana> yoga;
    Map<String, Karana> karana;
    Year? year;

    PanchangModel({
        required this.sunRise,
        required this.sunSet,
        required this.weekday,
        required this.lunarMonth,
        required this.ritu,
        required this.aayanam,
        required this.tithi,
        required this.nakshatra,
        required this.yoga,
        required this.karana,
        required this.year,
    });

    factory PanchangModel.fromJson(Map<String, dynamic> json) => PanchangModel(
        sunRise: json["sun_rise"],
        sunSet: json["sun_set"],
        weekday: Weekday.fromJson(json["weekday"]),
        lunarMonth: LunarMonth.fromJson(json["lunar_month"]),
        ritu: Ritu.fromJson(json["ritu"]),
        aayanam: json["aayanam"],
        tithi: Tithi.fromJson(json["tithi"]),
        nakshatra: Nakshatra.fromJson(json["nakshatra"]),
        yoga: Map.from(json["yoga"]).map((k, v) => MapEntry<String, Karana>(k, Karana.fromJson(v))),
        karana: Map.from(json["karana"]).map((k, v) => MapEntry<String, Karana>(k, Karana.fromJson(v))),
        year: Year.fromJson(json["year"]),
    );

    Map<String, dynamic> toJson() => {
        "sun_rise": sunRise,
        "sun_set": sunSet,
        "weekday": weekday!.toJson(),
        "lunar_month": lunarMonth!.toJson(),
        "ritu": ritu!.toJson(),
        "aayanam": aayanam,
        "tithi": tithi!.toJson(),
        "nakshatra": nakshatra!.toJson(),
        "yoga": Map.from(yoga).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "karana": Map.from(karana).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "year": year!.toJson(),
    };
}

class Karana {
    int number;
    String name;
    double? karanaLeftPercentage;
    DateTime completion;
    double? yogaLeftPercentage;

    Karana({
        required this.number,
        required this.name,
        this.karanaLeftPercentage,
        required this.completion,
        this.yogaLeftPercentage,
    });

    factory Karana.fromJson(Map<String, dynamic> json) => Karana(
        number: json["number"],
        name: json["name"],
        karanaLeftPercentage: json["karana_left_percentage"]?.toDouble(),
        completion: DateTime.parse(json["completion"]),
        yogaLeftPercentage: json["yoga_left_percentage"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "karana_left_percentage": karanaLeftPercentage,
        "completion": completion.toIso8601String(),
        "yoga_left_percentage": yogaLeftPercentage,
    };
}

class LunarMonth {
    int lunarMonthNumber;
    String lunarMonthName;
    String lunarMonthFullName;
    int adhika;
    int nija;
    int kshaya;

    LunarMonth({
        required this.lunarMonthNumber,
        required this.lunarMonthName,
        required this.lunarMonthFullName,
        required this.adhika,
        required this.nija,
        required this.kshaya,
    });

    factory LunarMonth.fromJson(Map<String, dynamic> json) => LunarMonth(
        lunarMonthNumber: json["lunar_month_number"],
        lunarMonthName: json["lunar_month_name"],
        lunarMonthFullName: json["lunar_month_full_name"],
        adhika: json["adhika"],
        nija: json["nija"],
        kshaya: json["kshaya"],
    );

    Map<String, dynamic> toJson() => {
        "lunar_month_number": lunarMonthNumber,
        "lunar_month_name": lunarMonthName,
        "lunar_month_full_name": lunarMonthFullName,
        "adhika": adhika,
        "nija": nija,
        "kshaya": kshaya,
    };
}

class Nakshatra {
    int number;
    String name;
    DateTime startsAt;
    DateTime endsAt;
    double leftPercentage;

    Nakshatra({
        required this.number,
        required this.name,
        required this.startsAt,
        required this.endsAt,
        required this.leftPercentage,
    });

    factory Nakshatra.fromJson(Map<String, dynamic> json) => Nakshatra(
        number: json["number"],
        name: json["name"],
        startsAt: DateTime.parse(json["starts_at"]),
        endsAt: DateTime.parse(json["ends_at"]),
        leftPercentage: json["left_percentage"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "starts_at": startsAt.toIso8601String(),
        "ends_at": endsAt.toIso8601String(),
        "left_percentage": leftPercentage,
    };
}

class Ritu {
    int number;
    String name;

    Ritu({
        required this.number,
        required this.name,
    });

    factory Ritu.fromJson(Map<String, dynamic> json) => Ritu(
        number: json["number"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
    };
}

class Tithi {
    int number;
    String name;
    String paksha;
    DateTime completesAt;
    double leftPrecentage;

    Tithi({
        required this.number,
        required this.name,
        required this.paksha,
        required this.completesAt,
        required this.leftPrecentage,
    });

    factory Tithi.fromJson(Map<String, dynamic> json) => Tithi(
        number: json["number"],
        name: json["name"],
        paksha: json["paksha"],
        completesAt: DateTime.parse(json["completes_at"]),
        leftPrecentage: json["left_precentage"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "paksha": paksha,
        "completes_at": completesAt.toIso8601String(),
        "left_precentage": leftPrecentage,
    };
}

class Weekday {
    int weekdayNumber;
    String weekdayName;
    int vedicWeekdayNumber;
    String vedicWeekdayName;

    Weekday({
        required this.weekdayNumber,
        required this.weekdayName,
        required this.vedicWeekdayNumber,
        required this.vedicWeekdayName,
    });

    factory Weekday.fromJson(Map<String, dynamic> json) => Weekday(
        weekdayNumber: json["weekday_number"],
        weekdayName: json["weekday_name"],
        vedicWeekdayNumber: json["vedic_weekday_number"],
        vedicWeekdayName: json["vedic_weekday_name"],
    );

    Map<String, dynamic> toJson() => {
        "weekday_number": weekdayNumber,
        "weekday_name": weekdayName,
        "vedic_weekday_number": vedicWeekdayNumber,
        "vedic_weekday_name": vedicWeekdayName,
    };
}

class Year {
    String status;
    DateTime timestamp;
    int sakaSalivahanaNumber;
    int sakaSalivahanaNameNumber;
    String sakaSalivahanaYearName;
    int vikramChaitradiNumber;
    int vikramChaitradiNameNumber;
    String vikramChaitradiYearName;

    Year({
        required this.status,
        required this.timestamp,
        required this.sakaSalivahanaNumber,
        required this.sakaSalivahanaNameNumber,
        required this.sakaSalivahanaYearName,
        required this.vikramChaitradiNumber,
        required this.vikramChaitradiNameNumber,
        required this.vikramChaitradiYearName,
    });

    factory Year.fromJson(Map<String, dynamic> json) => Year(
        status: json["status"],
        timestamp: DateTime.parse(json["timestamp"]),
        sakaSalivahanaNumber: json["saka_salivahana_number"],
        sakaSalivahanaNameNumber: json["saka_salivahana_name_number"],
        sakaSalivahanaYearName: json["saka_salivahana_year_name"],
        vikramChaitradiNumber: json["vikram_chaitradi_number"],
        vikramChaitradiNameNumber: json["vikram_chaitradi_name_number"],
        vikramChaitradiYearName: json["vikram_chaitradi_year_name"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "timestamp": timestamp.toIso8601String(),
        "saka_salivahana_number": sakaSalivahanaNumber,
        "saka_salivahana_name_number": sakaSalivahanaNameNumber,
        "saka_salivahana_year_name": sakaSalivahanaYearName,
        "vikram_chaitradi_number": vikramChaitradiNumber,
        "vikram_chaitradi_name_number": vikramChaitradiNameNumber,
        "vikram_chaitradi_year_name": vikramChaitradiYearName,
    };
}
