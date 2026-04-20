import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/core/global_variables/services.dart';

part 'connectivity_provider.g.dart';

enum ConnectivityStatus { connected, disconnected }

@riverpod
Stream<ConnectivityStatus> connectivity(Ref ref) async* {
  final connectivity = Connectivity();

  final initialResult = await connectivity.checkConnectivity();
  yield _mapResultToStatus(initialResult);

  await for (final result in connectivity.onConnectivityChanged) {
    final status = _mapResultToStatus(result);
    talker.info('Connectivity changed: $status');
    yield status;
  }
}

ConnectivityStatus _mapResultToStatus(List<ConnectivityResult> results) {
  if (results.isEmpty || results.contains(ConnectivityResult.none)) {
    return ConnectivityStatus.disconnected;
  }
  return ConnectivityStatus.connected;
}
