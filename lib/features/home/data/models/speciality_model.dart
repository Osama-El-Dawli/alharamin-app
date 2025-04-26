import 'package:alharamin_app/core/constants/assets.dart';

class SpecialityModel {
  final String specialityImage;
  final String speacialityName;

  const SpecialityModel({required this.specialityImage, required this.speacialityName});
}

final List<String> specialityImages = [
  Assets.assetsImagesLeathern,
  Assets.assetsImagesHeart,
  Assets.assetsImagesBrainAndNerves,
  Assets.assetsImagesBones,
  Assets.assetsImagesEarNoseThroat,
  Assets.assetsImagesEyes,
  Assets.assetsImagesChildren,
  Assets.assetsImagesGynecologyAndObstetrics,
];

final List<String> specialityNames = [
  'Leathern',
  'Heart',
  'Brain and nerves',
  'Bones',
  'Ear, Nose and Throat',
  'Eyes',
  'Children',
  'Gynecology and Obstetrics',
];

final List<SpecialityModel> specialities = List.generate(
  specialityNames.length,
  (index) {
    return SpecialityModel(
      specialityImage: specialityImages[index],
      speacialityName: specialityNames[index],
    );
  },
);
