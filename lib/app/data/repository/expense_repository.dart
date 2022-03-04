import 'package:pfm_app/app/data/services/api_helper.dart';
import 'package:pfm_app/app/data/services/api_response.dart';

class ExpenseRepository {
  final ApiHelper api;

  ExpenseRepository(this.api);

  Future<ApiResponse> addExpense(Map<String, dynamic> data) async {
    ApiResponse response = await api.post('expenses', data);
    if (response.isSuccessful) {
      response.message = 'Expense recorded succesfully';
      return response;
    }
    return response;
  }

  Future<ApiResponse> updateExpense(
      Map<String, dynamic> data, String docPath) async {
    ApiResponse response = await api.update('expenses', docPath, data);
    if (response.isSuccessful) {
      response.message = 'Expense updated succesfully';
      return response;
    }
    return response;
  }
}
