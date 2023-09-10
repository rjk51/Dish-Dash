import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dish_dash/data/dummy_data.dart';

final dishProvider = Provider((ref) {
  return dummyDishes;
});