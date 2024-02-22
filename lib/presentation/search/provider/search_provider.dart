// // 싱글턴.
// import '../../../data/dtos/airport_dto.dart';
//
// class SearchProvider {
//   static final SearchProvider _instance = SearchProvider._internal();
//
//   // getter
//   static SearchProvider get instance {
//     return _instance;
//   }
//   factory SearchProvider() {
//     return _instance;
//   }
//
//   SearchProvider._internal() {
//     // init
//     a = 2;
//     b = 2;
//   }
//
//   init () { // reset
//     a = 2;
//     b = 2;
//   }
//
//   //-------------------------------
//   // 변수부
//   int a = 4;
//   int b = 5;
//
//   List<AirportDTO> airportDTOModels = <AirportDTO>[];
//
//   //-------------------------------
//   // 함수부
//   plusA(int b) {
//
//   }
// }
//
// // 1. Sliding up panel 적용.
// // 2. Sliding up panel에 search 버튼을 만들고.
// // 3. Search button을 누르면
// // 4. data를 받아오는거.
// // 5. data를 provider에 저장.
// // 6. Sliding up panel에 비행기 정보 Tile 출력(목데이터 출력)