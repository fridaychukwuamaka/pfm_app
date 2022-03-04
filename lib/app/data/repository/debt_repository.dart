import 'package:pfm_app/app/data/services/api_helper.dart';
import 'package:pfm_app/app/data/services/api_response.dart';

class DebtRepository {
  final ApiHelper api;

  DebtRepository(this.api);

  Future<ApiResponse> addDebt(Map<String, dynamic> data) async {
    ApiResponse response = await api.post('debts', data);
    if (response.isSuccessful) {
      response.message = 'Debt recorded succesfully';
      return response;
    }
    return response;
  }
  Future<ApiResponse> editDebt(Map<String, dynamic> data, String docPath) async {
    ApiResponse response = await api.update('debts',  docPath, data);
    if (response.isSuccessful) {
      response.message = 'Debt recorded succesfully';
      return response;
    }
    return response;
  }
}
