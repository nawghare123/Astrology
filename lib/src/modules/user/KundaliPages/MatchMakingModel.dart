// To parse this JSON data, do
//
//     final matchMakingModel = matchMakingModelFromJson(jsonString);

import 'dart:convert';

MatchMakingModel matchMakingModelFromJson(String str) => MatchMakingModel.fromJson(json.decode(str));

String matchMakingModelToJson(MatchMakingModel data) => json.encode(data.toJson());

class MatchMakingModel {
    int? statusCode;
    Output? output;

    MatchMakingModel({
         this.statusCode,
         this.output,
    });

    factory MatchMakingModel.fromJson(Map<String, dynamic> json) => MatchMakingModel(
        statusCode: json["statusCode"],
        output: Output.fromJson(json["output"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "output": output!.toJson(),
    };
}

class Output {
    int? outOf;
    double? totalScore;
    VarnaKootam? varnaKootam;
    VasyaKootam? vasyaKootam;
    TaraKootam? taraKootam;
    YoniKootam? yoniKootam;
    GrahaMaitriKootam? grahaMaitriKootam;
    GanaKootam? ganaKootam;
    RasiKootam? rasiKootam;
    NadiKootam? nadiKootam;

    Output({
         this.outOf,
         this.totalScore,
         this.varnaKootam,
         this.vasyaKootam,
         this.taraKootam,
         this.yoniKootam,
         this.grahaMaitriKootam,
         this.ganaKootam,
         this.rasiKootam,
         this.nadiKootam,
    });

    factory Output.fromJson(Map<String, dynamic> json) => Output(
        outOf: json["out_of"],
        totalScore: json["total_score"],
        varnaKootam: VarnaKootam.fromJson(json["varna_kootam"]),
        vasyaKootam: VasyaKootam.fromJson(json["vasya_kootam"]),
        taraKootam: TaraKootam.fromJson(json["tara_kootam"]),
        yoniKootam: YoniKootam.fromJson(json["yoni_kootam"]),
        grahaMaitriKootam: GrahaMaitriKootam.fromJson(json["graha_maitri_kootam"]),
        ganaKootam: GanaKootam.fromJson(json["gana_kootam"]),
        rasiKootam: RasiKootam.fromJson(json["rasi_kootam"]),
        nadiKootam: NadiKootam.fromJson(json["nadi_kootam"]),
    );

    Map<String, dynamic> toJson() => {
        "out_of": outOf,
        "total_score": totalScore,
        "varna_kootam": varnaKootam!.toJson(),
        "vasya_kootam": vasyaKootam!.toJson(),
        "tara_kootam": taraKootam!.toJson(),
        "yoni_kootam": yoniKootam!.toJson(),
        "graha_maitri_kootam": grahaMaitriKootam!.toJson(),
        "gana_kootam": ganaKootam!.toJson(),
        "rasi_kootam": rasiKootam!.toJson(),
        "nadi_kootam": nadiKootam!.toJson(),
    };
}

class GanaKootam {
    GanaKootamBride? bride;
    GanaKootamGroom? groom;
    int? outOf;
    int? score;

    GanaKootam({
         this.bride,
         this.groom,
         this.outOf,
         this.score,
    });

    factory GanaKootam.fromJson(Map<String, dynamic> json) => GanaKootam(
        bride: GanaKootamBride.fromJson(json["bride"]),
        groom: GanaKootamGroom.fromJson(json["groom"]),
        outOf: json["out_of"],
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "bride": bride!.toJson(),
        "groom": groom!.toJson(),
        "out_of": outOf,
        "score": score,
    };
}

class GanaKootamBride {
    int? brideNadi;
    String? brideNadiName;

    GanaKootamBride({
         this.brideNadi,
         this.brideNadiName,
    });

    factory GanaKootamBride.fromJson(Map<String, dynamic> json) => GanaKootamBride(
        brideNadi: json["bride_nadi"],
        brideNadiName: json["bride_nadi_name"],
    );

    Map<String, dynamic> toJson() => {
        "bride_nadi": brideNadi,
        "bride_nadi_name": brideNadiName,
    };
}

class GanaKootamGroom {
    int? groomNadi;
    String? groomNadiName;

    GanaKootamGroom({
         this.groomNadi,
         this.groomNadiName,
    });

    factory GanaKootamGroom.fromJson(Map<String, dynamic> json) => GanaKootamGroom(
        groomNadi: json["groom_nadi"],
        groomNadiName: json["groom_nadi_name"],
    );

    Map<String, dynamic> toJson() => {
        "groom_nadi": groomNadi,
        "groom_nadi_name": groomNadiName,
    };
}

class GrahaMaitriKootam {
    GrahaMaitriKootamBride? bride;
    GrahaMaitriKootamBride? groom;
    int? outOf;
    double? score;

    GrahaMaitriKootam({
         this.bride,
         this.groom,
         this.outOf,
         this.score,
    });

    factory GrahaMaitriKootam.fromJson(Map<String, dynamic> json) => GrahaMaitriKootam(
        bride: GrahaMaitriKootamBride.fromJson(json["bride"]),
        groom: GrahaMaitriKootamBride.fromJson(json["groom"]),
        outOf: json["out_of"],
        score: json["score"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "bride": bride!.toJson(),
        "groom": groom!.toJson(),
        "out_of": outOf,
        "score": score,
    };
}

class GrahaMaitriKootamBride {
    int? moonSignNumber;
    String? moonSign;
    int? moonSignLord;
    String? moonSignLordName;

    GrahaMaitriKootamBride({
         this.moonSignNumber,
         this.moonSign,
         this.moonSignLord,
         this.moonSignLordName,
    });

    factory GrahaMaitriKootamBride.fromJson(Map<String, dynamic> json) => GrahaMaitriKootamBride(
        moonSignNumber: json["moon_sign_number"],
        moonSign: json["moon_sign"],
        moonSignLord: json["moon_sign_lord"],
        moonSignLordName: json["moon_sign_lord_name"],
    );

    Map<String, dynamic> toJson() => {
        "moon_sign_number": moonSignNumber,
        "moon_sign": moonSign,
        "moon_sign_lord": moonSignLord,
        "moon_sign_lord_name": moonSignLordName,
    };
}

class NadiKootam {
    NadiKootamBride? bride;
    NadiKootamBride? groom;
    int? outOf;
    int? score;

    NadiKootam({
         this.bride,
         this.groom,
         this.outOf,
         this.score,
    });

    factory NadiKootam.fromJson(Map<String, dynamic> json) => NadiKootam(
        bride: NadiKootamBride.fromJson(json["bride"]),
        groom: NadiKootamBride.fromJson(json["groom"]),
        outOf: json["out_of"],
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "bride": bride!.toJson(),
        "groom": groom!.toJson(),
        "out_of": outOf,
        "score": score,
    };
}

class NadiKootamBride {
    int? nadi;
    String? nadiName;

    NadiKootamBride({
         this.nadi,
         this.nadiName,
    });

    factory NadiKootamBride.fromJson(Map<String, dynamic> json) => NadiKootamBride(
        nadi: json["nadi"],
        nadiName: json["nadi_name"],
    );

    Map<String, dynamic> toJson() => {
        "nadi": nadi,
        "nadi_name": nadiName,
    };
}

class RasiKootam {
    RasiKootamBride? bride;
    RasiKootamBride? groom;
    int? outOf;
    int? score;

    RasiKootam({
         this.bride,
         this.groom,
         this.outOf,
         this.score,
    });

    factory RasiKootam.fromJson(Map<String, dynamic> json) => RasiKootam(
        bride: RasiKootamBride.fromJson(json["bride"]),
        groom: RasiKootamBride.fromJson(json["groom"]),
        outOf: json["out_of"],
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "bride": bride!.toJson(),
        "groom": groom!.toJson(),
        "out_of": outOf,
        "score": score,
    };
}

class RasiKootamBride {
    int? moonSign;
    String? moonSignName;

    RasiKootamBride({
         this.moonSign,
         this.moonSignName,
    });

    factory RasiKootamBride.fromJson(Map<String, dynamic> json) => RasiKootamBride(
        moonSign: json["moon_sign"],
        moonSignName: json["moon_sign_name"],
    );

    Map<String, dynamic> toJson() => {
        "moon_sign": moonSign,
        "moon_sign_name": moonSignName,
    };
}

class TaraKootam {
    TaraKootamBride? bride;
    TaraKootamBride? groom;
    int? outOf;
    double? score;

    TaraKootam({
         this.bride,
         this.groom,
         this.outOf,
         this.score,
    });

    factory TaraKootam.fromJson(Map<String, dynamic> json) => TaraKootam(
        bride: TaraKootamBride.fromJson(json["bride"]),
        groom: TaraKootamBride.fromJson(json["groom"]),
        outOf: json["out_of"],
        score: json["score"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "bride": bride!.toJson(),
        "groom": groom!.toJson(),
        "out_of": outOf,
        "score": score,
    };
}

class TaraKootamBride {
    int? starNumber;
    String? starName;

    TaraKootamBride({
         this.starNumber,
         this.starName,
    });

    factory TaraKootamBride.fromJson(Map<String, dynamic> json) => TaraKootamBride(
        starNumber: json["star_number"],
        starName: json["star_name"],
    );

    Map<String, dynamic> toJson() => {
        "star_number": starNumber,
        "star_name": starName,
    };
}

class VarnaKootam {
    VarnaKootamBride? bride;
    VarnaKootamBride? groom;
    int? outOf;
    int? score;

    VarnaKootam({
         this.bride,
         this.groom,
         this.outOf,
         this.score,
    });

    factory VarnaKootam.fromJson(Map<String, dynamic> json) => VarnaKootam(
        bride: VarnaKootamBride.fromJson(json["bride"]),
        groom: VarnaKootamBride.fromJson(json["groom"]),
        outOf: json["out_of"],
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "bride": bride!.toJson(),
        "groom": groom!.toJson(),
        "out_of": outOf,
        "score": score,
    };
}

class VarnaKootamBride {
    int? moonSignNumber;
    String? moonSign;
    int? varnam;
    String? varnamName;

    VarnaKootamBride({
         this.moonSignNumber,
         this.moonSign,
         this.varnam,
         this.varnamName,
    });

    factory VarnaKootamBride.fromJson(Map<String, dynamic> json) => VarnaKootamBride(
        moonSignNumber: json["moon_sign_number"],
        moonSign: json["moon_sign"],
        varnam: json["varnam"],
        varnamName: json["varnam_name"],
    );

    Map<String, dynamic> toJson() => {
        "moon_sign_number": moonSignNumber,
        "moon_sign": moonSign,
        "varnam": varnam,
        "varnam_name": varnamName,
    };
}

class VasyaKootam {
    VasyaKootamBride? bride;
    VasyaKootamGroom? groom;
    int? outOf;
    int? score;

    VasyaKootam({
         this.bride,
         this.groom,
         this.outOf,
         this.score,
    });

    factory VasyaKootam.fromJson(Map<String, dynamic> json) => VasyaKootam(
        bride: VasyaKootamBride.fromJson(json["bride"]),
        groom: VasyaKootamGroom.fromJson(json["groom"]),
        outOf: json["out_of"],
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "bride": bride!.toJson(),
        "groom": groom!.toJson(),
        "out_of": outOf,
        "score": score,
    };
}

class VasyaKootamBride {
    int? brideKootam;
    String? brideKootamName;

    VasyaKootamBride({
         this.brideKootam,
         this.brideKootamName,
    });

    factory VasyaKootamBride.fromJson(Map<String, dynamic> json) => VasyaKootamBride(
        brideKootam: json["bride_kootam"],
        brideKootamName: json["bride_kootam_name"],
    );

    Map<String, dynamic> toJson() => {
        "bride_kootam": brideKootam,
        "bride_kootam_name": brideKootamName,
    };
}

class VasyaKootamGroom {
    int? groomKootam;
    String? groomKootamName;

    VasyaKootamGroom({
         this.groomKootam,
         this.groomKootamName,
    });

    factory VasyaKootamGroom.fromJson(Map<String, dynamic> json) => VasyaKootamGroom(
        groomKootam: json["groom_kootam"],
        groomKootamName: json["groom_kootam_name"],
    );

    Map<String, dynamic> toJson() => {
        "groom_kootam": groomKootam,
        "groom_kootam_name": groomKootamName,
    };
}

class YoniKootam {
    YoniKootamBride? bride;
    YoniKootamBride? groom;
    int? outOf;
    int? score;

    YoniKootam({
         this.bride,
         this.groom,
         this.outOf,
         this.score,
    });

    factory YoniKootam.fromJson(Map<String, dynamic> json) => YoniKootam(
        bride: YoniKootamBride.fromJson(json["bride"]),
        groom: YoniKootamBride.fromJson(json["groom"]),
        outOf: json["out_of"],
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "bride": bride!.toJson(),
        "groom": groom!.toJson(),
        "out_of": outOf,
        "score": score,
    };
}

class YoniKootamBride {
    int? star;
    int? yoniNumber;
    String? yoni;

    YoniKootamBride({
         this.star,
         this.yoniNumber,
         this.yoni,
    });

    factory YoniKootamBride.fromJson(Map<String, dynamic> json) => YoniKootamBride(
        star: json["star"],
        yoniNumber: json["yoni_number"],
        yoni: json["yoni"],
    );

    Map<String, dynamic> toJson() => {
        "star": star,
        "yoni_number": yoniNumber,
        "yoni": yoni,
    };
}
