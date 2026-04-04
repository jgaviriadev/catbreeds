import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_info_item.dart';
import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BreedInfoGrid extends StatelessWidget {
  final BreedEntity breed;

  const BreedInfoGrid({
    required this.breed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = <Map<String, String>>[
      if (breed.affectionLevel != null) {'label': LocaleKeys.breed_detail_affection_level.tr(), 'value': '${breed.affectionLevel}/5'},
      if (breed.childFriendly != null) {'label': LocaleKeys.breed_detail_child_friendly.tr(), 'value': '${breed.childFriendly}/5'},
      if (breed.dogFriendly != null) {'label': LocaleKeys.breed_detail_dog_friendly.tr(), 'value': '${breed.dogFriendly}/5'},
      if (breed.energyLevel != null) {'label': LocaleKeys.breed_detail_energy_level.tr(), 'value': '${breed.energyLevel}/5'},
      if (breed.grooming != null) {'label': LocaleKeys.breed_detail_grooming.tr(), 'value': '${breed.grooming}/5'},
      if (breed.healthIssues != null) {'label': LocaleKeys.breed_detail_health_issues.tr(), 'value': '${breed.healthIssues}/5'},
      if (breed.sheddingLevel != null) {'label': LocaleKeys.breed_detail_shedding_level.tr(), 'value': '${breed.sheddingLevel}/5'},
      if (breed.socialNeeds != null) {'label': LocaleKeys.breed_detail_social_needs.tr(), 'value': '${breed.socialNeeds}/5'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return BreedInfoItem(
          label: item['label']!,
          value: item['value']!,
        );
      },
    );
  }
}
