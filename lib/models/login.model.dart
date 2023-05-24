// To parse this JSON data, do
//
//     final ntaLoginModel = ntaLoginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NtaLoginModel ntaLoginModelFromJson(String str) => NtaLoginModel.fromJson(json.decode(str));

String ntaLoginModelToJson(NtaLoginModel data) => json.encode(data.toJson());

class NtaLoginModel {
    final String success;
    final String code;
    final String message;
    final String appversion;
    final String apiname;
    final String error;
    final Data data;

    NtaLoginModel({
        required this.success,
        required this.code,
        required this.message,
        required this.appversion,
        required this.apiname,
        required this.error,
        required this.data,
    });

    factory NtaLoginModel.fromJson(Map<String, dynamic> json) => NtaLoginModel(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        appversion: json["appversion"],
        apiname: json["apiname"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "appversion": appversion,
        "apiname": apiname,
        "error": error,
        "data": data.toJson(),
    };
}

class Data {
    final Token token;
    final String name;

    Data({
        required this.token,
        required this.name,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: Token.fromJson(json["token"]),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "token": token.toJson(),
        "name": name,
    };
}

class Token {
    final String name;
    final List<String> abilities;
    final dynamic expiresAt;
    final int tokenableId;
    final String tokenableType;
    final DateTime updatedAt;
    final DateTime createdAt;
    final int id;

    Token({
        required this.name,
        required this.abilities,
        required this.expiresAt,
        required this.tokenableId,
        required this.tokenableType,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        name: json["name"],
        abilities: List<String>.from(json["abilities"].map((x) => x)),
        expiresAt: json["expires_at"],
        tokenableId: json["tokenable_id"],
        tokenableType: json["tokenable_type"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "abilities": List<dynamic>.from(abilities.map((x) => x)),
        "expires_at": expiresAt,
        "tokenable_id": tokenableId,
        "tokenable_type": tokenableType,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
