import 'package:temea/models/models.dart';

abstract class ActivityRepo {
  Future<List<Activity>> getActivities();
}
