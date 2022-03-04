import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfm_app/app/data/services/api_response.dart';

class ApiHelper {
  final db = FirebaseFirestore.instance;

  Future<ApiResponse> post(String path, Map<String, dynamic> data) async {
    try {
  var request =   await  db.collection(path).add(data);
     return ApiResponse(isSuccessful: true, data: request.id);
    } catch (e) {
     return  ApiResponse(isSuccessful: false, message: '$e');
    }
  }

  Future<ApiResponse> update(String path, String docPath, Map<String, dynamic> data) async {
    try {
    await  db.collection(path).doc(docPath).set(data);
     return ApiResponse(isSuccessful: true);
    } catch (e) {
     return  ApiResponse(isSuccessful: false, message: '$e');
    }
  }
}
