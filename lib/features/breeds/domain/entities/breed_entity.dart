import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';

class BreedEntity {
  final WeightEntity? weight;
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
  final BreedImageEntity? image;

  BreedEntity({
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

  BreedEntity copyWith({
    WeightEntity? weight,
    String? id,
    String? name,
    String? cfaUrl,
    String? vetstreetUrl,
    String? vcahospitalsUrl,
    String? temperament,
    String? origin,
    String? countryCodes,
    String? countryCode,
    String? description,
    String? lifeSpan,
    int? indoor,
    int? lap,
    String? altNames,
    int? adaptability,
    int? affectionLevel,
    int? childFriendly,
    int? dogFriendly,
    int? energyLevel,
    int? grooming,
    int? healthIssues,
    int? intelligence,
    int? sheddingLevel,
    int? socialNeeds,
    int? strangerFriendly,
    int? vocalisation,
    int? experimental,
    int? hairless,
    int? natural,
    int? rare,
    int? rex,
    int? suppressedTail,
    int? shortLegs,
    String? wikipediaUrl,
    int? hypoallergenic,
    String? referenceImageId,
    dynamic breedGroup,
    int? catFriendly,
    int? bidability,
    BreedImageEntity? image,
  }) => BreedEntity(
    weight: weight ?? this.weight,
    id: id ?? this.id,
    name: name ?? this.name,
    cfaUrl: cfaUrl ?? this.cfaUrl,
    vetstreetUrl: vetstreetUrl ?? this.vetstreetUrl,
    vcahospitalsUrl: vcahospitalsUrl ?? this.vcahospitalsUrl,
    temperament: temperament ?? this.temperament,
    origin: origin ?? this.origin,
    countryCodes: countryCodes ?? this.countryCodes,
    countryCode: countryCode ?? this.countryCode,
    description: description ?? this.description,
    lifeSpan: lifeSpan ?? this.lifeSpan,
    indoor: indoor ?? this.indoor,
    lap: lap ?? this.lap,
    altNames: altNames ?? this.altNames,
    adaptability: adaptability ?? this.adaptability,
    affectionLevel: affectionLevel ?? this.affectionLevel,
    childFriendly: childFriendly ?? this.childFriendly,
    dogFriendly: dogFriendly ?? this.dogFriendly,
    energyLevel: energyLevel ?? this.energyLevel,
    grooming: grooming ?? this.grooming,
    healthIssues: healthIssues ?? this.healthIssues,
    intelligence: intelligence ?? this.intelligence,
    sheddingLevel: sheddingLevel ?? this.sheddingLevel,
    socialNeeds: socialNeeds ?? this.socialNeeds,
    strangerFriendly: strangerFriendly ?? this.strangerFriendly,
    vocalisation: vocalisation ?? this.vocalisation,
    experimental: experimental ?? this.experimental,
    hairless: hairless ?? this.hairless,
    natural: natural ?? this.natural,
    rare: rare ?? this.rare,
    rex: rex ?? this.rex,
    suppressedTail: suppressedTail ?? this.suppressedTail,
    shortLegs: shortLegs ?? this.shortLegs,
    wikipediaUrl: wikipediaUrl ?? this.wikipediaUrl,
    hypoallergenic: hypoallergenic ?? this.hypoallergenic,
    referenceImageId: referenceImageId ?? this.referenceImageId,
    breedGroup: breedGroup ?? this.breedGroup,
    catFriendly: catFriendly ?? this.catFriendly,
    bidability: bidability ?? this.bidability,
    image: image ?? this.image,
  );
}
