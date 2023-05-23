import 'package:firebase_core/firebase_core.dart';

void checkFirebaseConnection() async {
  try {
    // Khởi tạo Firebase
    await Firebase.initializeApp();
    
    // Kết nối thành công
    print("Kết nối Firebase thành công!");
  } catch (e) {
    // Xảy ra lỗi khi kết nối
    print("Lỗi khi kết nối Firebase: $e");
  }
}
