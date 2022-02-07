
class PaginationData {
  int? startIndex, lastIndex, totalCount;
  bool? replace; // if coming from real-time -> replace old list with new one from $startIndex to $lastIndex
  dynamic data;


  PaginationData({this.startIndex, this.lastIndex, this.replace});

  @override
  String toString() {
    return 'PaginationData{totalCount: $totalCount, data: $data}';
  }

  bool get clear => startIndex==0;

}
