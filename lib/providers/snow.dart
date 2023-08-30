import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snowflake/flutter_snowflake.dart';

final snowProv = Provider((ref) => Snowflake(0, 0));
