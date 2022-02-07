
import 'package:hospital/model/api/resource.dart';

///Request methods middleware callbacks
typedef RequestCallback = Future<Resource> Function();
typedef ListenerCallback = Stream<Resource> Function(); // for real-time requests