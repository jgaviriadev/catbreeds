import 'dart:convert';

import 'package:cat_breeds/features/breeds/data/models/models.dart';

class BreedModel {
  final WeightModel? weight;
  final String? id;
  final String? name;
  final String? cfaUrl;
  final String? vetstreetUrl;
  final String? vcahospitalsUrl;
  final String? temperament;
  final String? origin;
  final String? countryCodes;
  final String? countryCode;
  final String? description;
  final String? lifeSpan;
  final int? indoor;
  final int? lap;
  final String? altNames;
  final int? adaptability;
  final int? affectionLevel;
  final int? childFriendly;
  final int? dogFriendly;
  final int? energyLevel;
  final int? grooming;
  final int? healthIssues;
  final int? intelligence;
  final int? sheddingLevel;
  final int? socialNeeds;
  final int? strangerFriendly;
  final int? vocalisation;
  final int? experimental;
  final int? hairless;
  final int? natural;
  final int? rare;
  final int? rex;
  final int? suppressedTail;
  final int? shortLegs;
  final String? wikipediaUrl;
  final int? hypoallergenic;
  final String? referenceImageId;
  final dynamic breedGroup;
  final int? catFriendly;
  final int? bidability;
  final BreedImageModel? image;

  BreedModel({
    this.weight,
    this.id,
    this.name,
    this.cfaUrl,
    this.vetstreetUrl,
    this.vcahospitalsUrl,
    this.temperament,
    this.origin,
    this.countryCodes,
    this.countryCode,
    this.description,
    this.lifeSpan,
    this.indoor,
    this.lap,
    this.altNames,
    this.adaptability,
    this.affectionLevel,
    this.childFriendly,
    this.dogFriendly,
    this.energyLevel,
    this.grooming,
    this.healthIssues,
    this.intelligence,
    this.sheddingLevel,
    this.socialNeeds,
    this.strangerFriendly,
    this.vocalisation,
    this.experimental,
    this.hairless,
    this.natural,
    this.rare,
    this.rex,
    this.suppressedTail,
    this.shortLegs,
    this.wikipediaUrl,
    this.hypoallergenic,
    this.referenceImageId,
    this.breedGroup,
    this.catFriendly,
    this.bidability,
    this.image,
  });

  factory BreedModel.fromJson(String str) => BreedModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BreedModel.fromMap(Map<String, dynamic> json) => BreedModel(
    weight: json['weight'] == null ? null : WeightModel.fromMap(json['weight']),
    id: json['id'],
    name: json['name'],
    cfaUrl: json['cfa_url'],
    vetstreetUrl: json['vetstreet_url'],
    vcahospitalsUrl: json['vcahospitals_url'],
    temperament: json['temperament'],
    origin: json['origin'],
    countryCodes: json['country_codes'],
    countryCode: json['country_code'],
    description: json['description'],
    lifeSpan: json['life_span'],
    indoor: json['indoor'],
    lap: json['lap'],
    altNames: json['alt_names'],
    adaptability: json['adaptability'],
    affectionLevel: json['affection_level'],
    childFriendly: json['child_friendly'],
    dogFriendly: json['dog_friendly'],
    energyLevel: json['energy_level'],
    grooming: json['grooming'],
    healthIssues: json['health_issues'],
    intelligence: json['intelligence'],
    sheddingLevel: json['shedding_level'],
    socialNeeds: json['social_needs'],
    strangerFriendly: json['stranger_friendly'],
    vocalisation: json['vocalisation'],
    experimental: json['experimental'],
    hairless: json['hairless'],
    natural: json['natural'],
    rare: json['rare'],
    rex: json['rex'],
    suppressedTail: json['suppressed_tail'],
    shortLegs: json['short_legs'],
    wikipediaUrl: json['wikipedia_url'],
    hypoallergenic: json['hypoallergenic'],
    referenceImageId: json['reference_image_id'],
    breedGroup: json['breed_group'],
    catFriendly: json['cat_friendly'],
    bidability: json['bidability'],
    image: json['image'] == null ? null : BreedImageModel.fromMap(json['image']),
  );

  Map<String, dynamic> toMap() => {
    'weight': weight?.toMap(),
    'id': id,
    'name': name,
    'cfa_url': cfaUrl,
    'vetstreet_url': vetstreetUrl,
    'vcahospitals_url': vcahospitalsUrl,
    'temperament': temperament,
    'origin': origin,
    'country_codes': countryCodes,
    'country_code': countryCode,
    'description': description,
    'life_span': lifeSpan,
    'indoor': indoor,
    'lap': lap,
    'alt_names': altNames,
    'adaptability': adaptability,
    'affection_level': affectionLevel,
    'child_friendly': childFriendly,
    'dog_friendly': dogFriendly,
    'energy_level': energyLevel,
    'grooming': grooming,
    'health_issues': healthIssues,
    'intelligence': intelligence,
    'shedding_level': sheddingLevel,
    'social_needs': socialNeeds,
    'stranger_friendly': strangerFriendly,
    'vocalisation': vocalisation,
    'experimental': experimental,
    'hairless': hairless,
    'natural': natural,
    'rare': rare,
    'rex': rex,
    'suppressed_tail': suppressedTail,
    'short_legs': shortLegs,
    'wikipedia_url': wikipediaUrl,
    'hypoallergenic': hypoallergenic,
    'reference_image_id': referenceImageId,
    'breed_group': breedGroup,
    'cat_friendly': catFriendly,
    'bidability': bidability,
    'image': image?.toMap(),
  };
}
