class EntityFull {
  final String id;
  final String name;
  final String logoUrl;
  final String header;
  final bool isSecured;
  final bool isLiked;
  final List<Item> soundPacks;

  EntityFull(
      {required this.id,
      required this.name,
      required this.logoUrl,
      required this.header,
      required this.isSecured,
      required this.soundPacks,
      required this.isLiked});

  factory EntityFull.fromJson(dynamic json) {
    var soundPacks = List<SoundPacks>.empty(growable: true);
    // (json['expariences'] as List).forEach((element) => soundPacks.add(SoundPacks.fromJson(element)));
    //(json['campaigns'] as List).forEach((element) => campaigns.add(FanArtZone.fromJson(element)));

    return EntityFull(
        id: json['id'],
        name: json['name'],
        logoUrl: json['logo'],
        header: json['header'],
        soundPacks: soundPacks,
        isSecured: json['isSecuredByPassword'] ?? false,
        isLiked: json['isLiked'] ?? false);
  }
}

class Item {}

class SmartHears {
  final int id;
  final String uniqueKey;
  final String landingUrl;
  final String name;
  final String state;
  final String logoUrl;
  final int cost;
  final String? description;
  final String? descriptionApp;
  final String? headerUrl;
  final String imageFormUrl;
  final String endDate;
  final Entity? entity;

  SmartHears(
      {required this.id,
      required this.uniqueKey,
      required this.landingUrl,
      required this.name,
      required this.state,
      required this.logoUrl,
      required this.cost,
      this.description,
      this.descriptionApp,
      required this.headerUrl,
      required this.imageFormUrl,
      required this.endDate,
      this.entity});

  /*factory SmartHears.fromJson(dynamic json) => SmartHears(
      id: json['id'],
      uniqueKey: json['uniqueKey'],
      landingUrl: json['landingUrl'] ?? "",
      name: json['name'],
      state: json['state'],
      logoUrl: json['logoUrl'],
      vip: json['vip'],
      fan: json['fan'],
      cost: json['cost'],
      durationVideoFan: json['durationVideoFan'],
      durationVideoVip: json['durationVideoVip'],
      fanUnique: json['fanUnique'],
      vipUnique: json['vipUnique'],
      countVip: json['countVip'],
      countFan: json['countFan'],
      description: json['description'],
      descriptionApp: json['descriptionApp'],
      headerUrl: json['headerUrl'] ?? "",
      imageFormUrl: json['imageFormUrl'] ?? "",
      endDate: json['endDate'],
      entity: json['entity'] != null ? Entity.fromJson(json['entity']) : null);*/
}

class Entity extends Item {
  final String id;
  final String name;
  final String logoUrl;
  final String header;
  final bool isSecured;

  Entity(
      {required this.id,
      required this.name,
      required this.logoUrl,
      required this.header,
      required this.isSecured});

  factory Entity.fromJson(dynamic json) => Entity(
      id: json['id'],
      name: json['name'],
      logoUrl: json['logo'],
      header: json['header'],
      isSecured: json['isSecuredByPassword'] ?? false);
}

class Entities {
  final List<Entity> entities;

  Entities({required this.entities});

  factory Entities.fromJson(dynamic json) {
    var entities = List<Entity>.empty(growable: true);
    json.forEach((element) => entities.add(Entity.fromJson(element)));
    return Entities(entities: entities);
  }
}

class Position {
  final String type;
  final List<double> coordinates;
  final String title;
  final int radius;
  final bool visible;

  Position(
      {required this.type,
      required this.coordinates,
      required this.title,
      required this.radius,
      required this.visible});

  factory Position.fromJson(dynamic json) => Position(
      type: json['type'],
      coordinates: (json['coordinates'] != null && json['coordinates'] is List)
          ? List.from(json['coordinates'])
          : [],
      title: json['title'],
      radius: json['radius'],
      visible: json['visible']);
}

class Statistics {
  final int description;
  final int scan;
  final int link;
  final int print;
  int like;

  Statistics(
      {required this.description,
      required this.scan,
      required this.link,
      required this.print,
      required this.like});

  factory Statistics.fromJson(dynamic json) => Statistics(
      description: json['description'],
      scan: json['scan'],
      link: json['link'],
      print: json['print'],
      like: json['like']);
}

class ConfigObjects {
  final List<void>? objects;

  ConfigObjects({this.objects});

  factory ConfigObjects.fromJson(dynamic json) =>
      ConfigObjects(objects: json['objects']);
}

class SoundPacks extends Item {
  String? id;
  String? name;
  bool? secured;
  String? logoUrl;
  bool? securedByPosition;
  List<Position>? positions;
  List<int>? users;
  Entity? entity;
  String? descriptionApp;
  String? clientLogoUrl;
  String? hashtag;
  bool? isLiked;
  ConfigObjects? objects;
  String? packageId;
  String? offeringId;

  SoundPacks(
      {this.id,
      this.name,
      this.secured,
      this.logoUrl,
      this.securedByPosition,
      this.positions,
      this.users,
      this.entity,
      this.descriptionApp,
      this.clientLogoUrl,
      this.hashtag,
      this.isLiked,
      this.objects,
      this.packageId,
      this.offeringId});

  factory SoundPacks.fromJson(dynamic json) {
    var positions = List<Position>.empty(growable: true);
    if (json['positions'] != null) {
      (json['positions'] as List).forEach(
          (element) => positions.add(Position.fromJson(element['position'])));
    }
    return SoundPacks(
        id: json['id'],
        name: json['displayName'] != null && json['displayName'].isNotEmpty
            ? json['displayName']
            : json['name'],
        secured: json['securedByPassword'] ?? false,
        logoUrl: json['logoUrl'],
        securedByPosition: json['securedByPosition'] ?? false,
        positions: positions,
        users: json['users'] != null ? List.from(json['users']) : [],
        entity: json['entity'] != null ? Entity.fromJson(json['entity']) : null,
        descriptionApp: json['descriptionApp'],
        clientLogoUrl: json['clientLogoUrl'],
        hashtag: json['hashtag'],
        isLiked: json['isLiked'] ?? false,
        objects: ConfigObjects.fromJson(json),
        packageId: json['packageId'],
        offeringId: json['offeringId']);
  }

  List<Position> getVisiblePositions() =>
      positions!.where((element) => element.visible).toList();

  factory SoundPacks.fromJsonWithDetails(dynamic json) {
    var positions = List<Position>.empty(growable: true);
    if (json['positions'] != null) {
      (json['positions'] as List).forEach(
          (element) => positions.add(Position.fromJson(element['position'])));
    }
    return SoundPacks(
        id: json['id'],
        name: json['name'],
        secured: json['securedByPassword'] ?? false,
        logoUrl: json['logoUrl'],
        securedByPosition: json['securedByPosition'] ?? false,
        positions: positions,
        users: json['users'] != null ? List.from(json['users']) : [],
        entity: json['entity'] != null ? Entity.fromJson(json['entity']) : null,
        descriptionApp: json['descriptionApp'],
        clientLogoUrl: json['clientLogoUrl'],
        hashtag: json['hashtag'],
        isLiked: json['isLiked'] ?? false,
        objects: json['objects'] != null ? ConfigObjects.fromJson(json) : null,
        packageId: json['packageId'],
        offeringId: json['offeringId']);
  }
}

class ContentPage {
  final String id;
  final List<String> headerUrls;
  final List<Item> soundPacks;

  // final List<Item> myExpariences;
  final List<SoundPacks> favorites;
  final List<Item> currentSoundPacks;
  final List<SmartHears> smarthearsList;
  final List<Header> headers;

  ContentPage(
      {required this.id,
      required this.headerUrls,
      required this.soundPacks,
      required this.currentSoundPacks,
      required this.favorites,
      required this.smarthearsList,
      required this.headers});

  factory ContentPage.fromJson(Map<String, dynamic> json) {
    var soundPacks = List<Item>.empty(growable: true);
    var currentSoundPacks = List<Item>.empty(growable: true);
    var favorites = List<SoundPacks>.empty(growable: true);
    var smarthearsList = List<SmartHears>.empty(growable: true);
    var headers = <Header>[];
    var contentPage = ContentPage(
        id: json['_id'],
        headerUrls: List.from(json['headerUrls']),
        soundPacks: soundPacks,
        favorites: favorites,
        smarthearsList: smarthearsList,
        currentSoundPacks: currentSoundPacks,
        headers: headers);
    return contentPage;
  }
}

enum ItemType { soundPacks, voice, voicePacks, soundsProfile }

class Header {
  Header({required this.url, required this.type, required this.objectId});

  final String url;
  final ItemType type;
  final String objectId;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
      url: json['url'],
      type: getItemType(json['type'] ?? ""),
      objectId: json['objectId'] ?? "");

  static ItemType getItemType(String type) {
    switch (type) {
      case 'soundPacks':
        return ItemType.soundPacks;
      case 'voice':
        return ItemType.voice;
      case 'voicePacks':
        return ItemType.voice;
      case 'soundsProfile':
        return ItemType.voice;
      default:
        return ItemType.soundPacks;
    }
  }
}

class SearchResult {
  final List<Item> soundPacks;
  final List<Entity> entities;

  SearchResult({required this.soundPacks, required this.entities});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    var soundPacks = List<Item>.empty(growable: true);
    //  (json['expariences'] as List).forEach((element) => expariences.add(SoundPacks.fromJson(element)));
    //(json['campaigns'] as List).forEach((element) => fanartzones.add(FanArtZone.fromJson(element)));
    var entities = List<Entity>.empty(growable: true);
    // (json['entities'] as List).forEach((element) => entities.add(Entity.fromJson(element)));
    var searchResult = SearchResult(soundPacks: soundPacks, entities: entities);
    return searchResult;
  }
}
