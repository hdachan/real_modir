// lib/viewmodels/data_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/modir.dart';
import '../services/supabase_service.dart';


/// 마커 데이터 블로오기
class DataViewModel with ChangeNotifier {
  final SupabaseService _supabaseService;
  List<Modir> dataList = [];
  bool isLoading = false;
  String? errorMessage;
  RealtimeChannel? _realtimeChannel;
  NLatLngBounds? currentBounds; // 현재 bounds 저장

  DataViewModel({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService() {
    setupRealtimeSubscription();
    // fetchData(); // 초기 데이터 로드는 bounds가 없으므로 제거하거나 상황에 맞게 수정
  }

  // bounds 내 데이터 불러오기
  Future<void> fetchDataInBounds(NLatLngBounds bounds) async {
    print('Fetching data in bounds from DataViewModel');
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      dataList = await _supabaseService.fetchModirDataInBounds(bounds);
      currentBounds = bounds;
      print('Data loaded into dataList: ${dataList.length} items');
      if (dataList.isEmpty) {
        print('No data loaded - bounds may not match database');
      }
    } catch (e) {
      errorMessage = e.toString();
      print('Error in DataViewModel: $errorMessage');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 특정 성별에 맞는 데이터만 필터링하여 불러오기
  Future<void> fetchFilteredDataInBounds(NLatLngBounds bounds, String? gender, String? type) async {
    print('Fetching filtered data in bounds: gender = $gender, type = $type');
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // 원본 데이터 불러오기
      await fetchDataInBounds(bounds);

      // 다중 필터링 적용
      dataList = dataList.where((modir) {
        bool matchesGender = gender == null || modir.clothesgender == gender;
        bool matchesType = type == null || modir.type == type;
        return matchesGender && matchesType; // 두 조건 모두 만족해야 함
      }).toList();

      print('Filtered data count: ${dataList.length}');
    } catch (e) {
      errorMessage = e.toString();
      print('Error in fetching filtered data: $errorMessage');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  // 실시간 구독 설정
  void setupRealtimeSubscription() {
    _realtimeChannel = _supabaseService.setupRealtimeSubscription(
      'modir_channel',
          (payload) {
        if (currentBounds != null) {
          fetchDataInBounds(currentBounds!); // bounds 내 데이터만 갱신
        }
      },
    );
  }

  // 리소스 정리
  void disposeProvider() {
    _realtimeChannel?.unsubscribe();
  }

  @override
  void dispose() {
    disposeProvider();
    super.dispose();
  }
}