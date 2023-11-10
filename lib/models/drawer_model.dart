class DrawerModel {
  List<DrawerData>? drawerData;
  DrawerModel({this.drawerData});
}



class DrawerData {
  int? id;
  String? name;
  dynamic? icon;
  String? navigateTo;

  DrawerData({this.id, this.name, this.icon, this.navigateTo});

}