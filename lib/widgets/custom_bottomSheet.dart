import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../viewmodels/map_viewmodel.dart';


class FilterBottomSheet {
  static void show(BuildContext context) {
    String? selectedLocation; // 선택된 지역 저장
    Map<String, NLatLng> locationCoordinates = {
      '압구정': NLatLng(37.5271, 127.0286),
      '홍대': NLatLng(37.5561, 126.9236),
      '동묘': NLatLng(37.5722, 127.0168),
      '망원': NLatLng(37.5569, 126.9104),
      '합정': NLatLng(37.5495, 126.9137),
      '이태원': NLatLng(37.5345, 126.9946),
      '성수': NLatLng(37.5444, 127.0563),
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFF1A1A1A),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: 360.w,
              height: 500.h,
              child: Column(
                children: [
                  Container(
                    width: 360.w,
                    height: 40.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFF1A1A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                    child: Text(
                      '지역선택',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.10,
                        letterSpacing: -0.45,
                      ),
                    ),
                  ),
                  Container(
                    width: 360.w,
                    height: 40.h,
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 120.w,
                          height: 16.h,
                          child: Text(
                            '시/도',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF888888),
                              fontSize: 12.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.30,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                        Container(
                          width: 240.w,
                          height: 16.h,
                          child: Text(
                            '상세보기',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF888888),
                              fontSize: 12.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.30,
                              letterSpacing: -0.30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 360.w,
                    height: 348.h,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 120.w,
                              height: 44.h,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Center(
                                child: Text(
                                  '서울',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    height: 1.40,
                                    letterSpacing: -0.35,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SelectableList(
                              onSelected: (value) {
                                setState(() {
                                  selectedLocation = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 360.w,
                    height: 68.h,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 156.w,
                            height: 36.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF888888),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '닫기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () {
                            if (selectedLocation != null && locationCoordinates.containsKey(selectedLocation)) {
                              final mapProvider = context.read<MapProvider>();
                              final coords = locationCoordinates[selectedLocation]!;

                              mapProvider.moveToLocation(coords.latitude, coords.longitude);
                              print("최종 선택된 위치: $selectedLocation -> ${coords.latitude}, ${coords.longitude}");
                            } else {
                              print("선택된 위치가 없습니다.");
                            }

                            Navigator.pop(context, selectedLocation);
                          },
                          child: Container(
                            width: 156.w,
                            height: 36.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF05FFF7),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '적용',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class StyleBottomSheet {
  static void show(BuildContext context) {
    String? selectedLocation; // 선택된 지역 저장

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFF1A1A1A),
      builder: (BuildContext context) {
        return StatefulBuilder( // 상태 변경을 위해 StatefulBuilder 사용
          builder: (context, setState) {
            return Container(
              width: 360.w,
              height: 500.h,
              child: Column(
                children: [
                  Container(
                    width: 360.w,
                    height: 40.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFF1A1A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                    child: Text(
                      '매장',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.10,
                        letterSpacing: -0.45,
                      ),
                    ),
                  ),
                  Container(
                    width: 360.w,
                    height: 388.h,
                    padding: EdgeInsets.only(left: 16,right: 16,bottom: 8,top: 8),
                    child: Container(
                      width: 328.w,
                      height: 36.h,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 156.w,
                                height: 36.h,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: Color(0xFF888888)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Container(
                                  width: 124.w,
                                  height: 20.h,
                                  padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                  child: Text(
                                    '편집샵',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF888888),
                                      fontSize: 14.sp,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 1.40,
                                      letterSpacing: -0.35,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Container(
                                width: 156.w,
                                height: 36.h,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: Color(0xFF888888)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Container(
                                  width: 124.w,
                                  height: 20.h,
                                  padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                  child: Text(
                                    '구제',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF888888),
                                      fontSize: 14.sp,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 1.40,
                                      letterSpacing: -0.35,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ),
                  Container(
                    width: 360.w,
                    height: 68.h,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 156.w,
                            height: 36.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF888888),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '닫기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () {
                            print("최종 선택된 위치: $selectedLocation");
                            Navigator.pop(context, selectedLocation);
                          },
                          child: Container(
                            width: 156.w,
                            height: 36.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF05FFF7),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '적용',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class GenderBottomSheet {
  static void show(BuildContext context) {
    String? selectedLocation; // 선택된 지역 저장

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFF1A1A1A),
      builder: (BuildContext context) {
        return StatefulBuilder( // 상태 변경을 위해 StatefulBuilder 사용
          builder: (context, setState) {
            return Container(
              width: 360.w,
              height: 500.h,
              child: Column(
                children: [
                  Container(
                    width: 360.w,
                    height: 40.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFF1A1A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                    child: Text(
                      '성별',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.10,
                        letterSpacing: -0.45,
                      ),
                    ),
                  ),
                  Container(
                      width: 360.w,
                      height: 388.h,
                      padding: EdgeInsets.only(left: 16,right: 16,bottom: 8,top: 8),
                      child: Container(
                        width: 328.w,
                        height: 36.h,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 156.w,
                                  height: 36.h,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1, color: Color(0xFF888888)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Container(
                                    width: 124.w,
                                    height: 20.h,
                                    padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                    child: Text(
                                      '남자',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF888888),
                                        fontSize: 14.sp,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.40,
                                        letterSpacing: -0.35,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Container(
                                  width: 156.w,
                                  height: 36.h,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1, color: Color(0xFF888888)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Container(
                                    width: 124.w,
                                    height: 20.h,
                                    padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                    child: Text(
                                      '여자',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF888888),
                                        fontSize: 14.sp,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.40,
                                        letterSpacing: -0.35,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                    width: 360.w,
                    height: 68.h,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 156.w,
                            height: 36.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF888888),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '닫기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () {
                            print("최종 선택된 위치: $selectedLocation");
                            Navigator.pop(context, selectedLocation);
                          },
                          child: Container(
                            width: 156.w,
                            height: 36.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF05FFF7),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '적용',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class BrandBottomSheet {
  static void show(BuildContext context) {
    String? selectedLocation; // 선택된 지역 저장

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFF1A1A1A),
      builder: (BuildContext context) {
        return StatefulBuilder( // 상태 변경을 위해 StatefulBuilder 사용
          builder: (context, setState) {
            return Container(
              width: 360.w,
              height: 500.h,
              child: Column(
                children: [
                  Container(
                    width: 360.w,
                    height: 40.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFF1A1A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                    child: Text(
                      '스타일',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.10,
                        letterSpacing: -0.45,
                      ),
                    ),
                  ),
                  Container(
                      width: 360.w,
                      height: 388.h,
                      padding: EdgeInsets.only(left: 16,right: 16,bottom: 8,top: 8),
                      child: Container(
                        width: 328.w,
                        height: 36.h,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 156.w,
                                  height: 36.h,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1, color: Color(0xFF888888)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Container(
                                    width: 124.w,
                                    height: 20.h,
                                    padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                    child: Text(
                                      '아메카지',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF888888),
                                        fontSize: 14.sp,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.40,
                                        letterSpacing: -0.35,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Container(
                                  width: 156.w,
                                  height: 36.h,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1, color: Color(0xFF888888)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Container(
                                    width: 124.w,
                                    height: 20.h,
                                    padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                    child: Text(
                                      '캐주얼',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF888888),
                                        fontSize: 14.sp,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.40,
                                        letterSpacing: -0.35,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                    width: 360.w,
                    height: 68.h,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 156.w,
                            height: 36.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF888888),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '닫기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () {
                            print("최종 선택된 위치: $selectedLocation");
                            Navigator.pop(context, selectedLocation);
                          },
                          child: Container(
                            width: 156.w,
                            height: 36.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF05FFF7),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '적용',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}



class SelectableContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableContainer({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240.w,
        height: 44.h,
        decoration: ShapeDecoration(
          color: isSelected ? Color(0xFF3D3D3D): Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFF242424)),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 1.40,
              letterSpacing: -0.35,
            ),
          ),
        ),
      ),
    );
  }
}

class SelectableList extends StatefulWidget {
  final Function(String) onSelected; // 선택한 값을 전달할 콜백

  SelectableList({required this.onSelected});

  @override
  _SelectableListState createState() => _SelectableListState();
}

class _SelectableListState extends State<SelectableList> {
  String? temporarySelectedText; // 임시 선택된 값

  void _handleSelection(String text) {
    setState(() {
      temporarySelectedText = text;
    });
    widget.onSelected(text); // 선택한 값을 부모 위젯으로 전달
  }

  @override
  Widget build(BuildContext context) {
    List<String> locations = ['압구정', '홍대', '동묘', '망원', '합정', '이태원', '성수'];

    return Column(
      children: locations.map((location) {
        return SelectableContainer(
          text: location,
          isSelected: temporarySelectedText == location,
          onTap: () => _handleSelection(location),
        );
      }).toList(),
    );
  }
}





