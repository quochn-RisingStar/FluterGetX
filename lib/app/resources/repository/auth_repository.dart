import 'package:dio/dio.dart';
import '../../constants/constants.dart';
import '../../utils/app_clients.dart';
import '../resources.dart';

class AuthRepository {

  factory AuthRepository() {
    _instance ??= AuthRepository._();
    return _instance!;
  }
  AuthRepository._();

  static AuthRepository? _instance;

// /Example
  Future<NetworkState<List<TestModel>>> testApi() async {
    // final bool isDisconnect = await WifiService.isDisconnect();
    final bool isConnected = await WifiService.isNetWorkConnect();
    if (!isConnected) {
      return NetworkState<List<TestModel>>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.TEST_API;
      // Map<String, dynamic> params = {
      //   "os": Platform.isAndroid ? "android" : "ios"
      // };
      final Response<List<dynamic>> response = await AppClients().get(api);
      return NetworkState<List<TestModel>>(
        status: AppEndpoint.SUCCESS,
        data: response.data?.map((dynamic e) => TestModel.fromJson(e as Map<String, dynamic>)).toList(),
      );
    } on DioError catch (e) {
      return NetworkState<List<TestModel>>.withError(e);
    }
  }
}
