import 'dart:math';

import 'package:auzmor_task/utils/assets.dart';

///Model Class for holding Training Data
class TrainingData {
  String name, location, trainerName, trainerPic, trainerDesignation, background;
  DateTime from, to;
  TrainingTag tag;

  TrainingData(
      {required this.name,
      required this.from,
      required this.to,
      required this.location,
      required this.trainerName,
      required this.trainerPic,
      required this.trainerDesignation,
      required this.background,
      required this.tag});
}


/// An enum representing the possible training tags.
enum TrainingTag { Filling_Fast, Early_Bird }


/// Generates a list of random TrainingData objects with specified parameters.
List<TrainingData> generateRandomTrainingData({int numData = 10}) {
  final names = [
    "Safe Scrum Master (4.6)",
    "Senior Flutter Developer",
    "Project Manager"
  ];
  final locations = ["Mysuru Studio", "Online", "Bangalore Tech Center"];
  final trainerNames = ["Alice Smith", "John Doe", "Jane Williams"];
  final trainerDesignations = [
    "Keynote Speaker",
    "Guest Speaker",
    "In-house Speaker"
  ];

  final backgroundImages = [
    Assets.asset1,
    Assets.asset2,
    Assets.asset3
  ];

  final tagOptions = TrainingTag.values;

  final random = Random();
  return List.generate(
    numData,
    (_) {
      final now = DateTime.now();
      final from = now.add(
        Duration(
          days: 1 + random.nextInt(6),
          hours: random.nextInt(24),
        ),
      );
      // Ensure 'to' is after 'from'
      final to = from.add(Duration(hours: random.nextInt(3) + 1));

      return TrainingData(
        name: names[random.nextInt(names.length)],
        location: locations[random.nextInt(locations.length)],
        trainerName: trainerNames[random.nextInt(trainerNames.length)],
        trainerPic:
        "https://i.pravatar.cc/150?img=${Random().nextInt(60)+1}",
        trainerDesignation:
            trainerDesignations[random.nextInt(trainerDesignations.length)],
        background: backgroundImages[Random().nextInt(2)],
        from: from,
        to: to,
        tag: tagOptions[random.nextInt(tagOptions.length)],
      );
    },
  );
}
