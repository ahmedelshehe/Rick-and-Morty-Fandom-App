class Character{
  late final int id;
  late final String name;
  late final String status;
  late final String species;
  late final String gender;
  late final String originName;
  late final String originUrl;
  late final String locationName;
  late final String locationUrl;
  late final String image;
  late final List<dynamic> episodes;
  Character.fromJson(Map<String,dynamic> json){
    id= json['id'];
    name= json['name'];
    status= json['status'];
    species = json['species'];
    gender = json['gender'];
    originName= json['origin']['name'];
    originUrl= json['origin']['url'];
    locationName= json['location']['name'];
    locationUrl= json['location']['url'];
    image= json['image'];
    episodes=json['episode'];
  }
}