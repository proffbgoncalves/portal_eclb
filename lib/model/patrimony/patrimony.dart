abstract interface class Patrimony {

  void set id(int? id);

  int? get id;

  void set name(String? name);

  String? get name;

  void set country(String? country);

  String? get country;

  void set description(String? description);

  String? get description;

  void set unescoClassification(int? unescoClassification);

  int? get unescoClassification;

  void set typeOfPatrimonyId(int? typeOfPatrimonyId);

  int? get typeOfPatrimonyId;

  void set compositePatrimonyId(int? id);

  int? get compositePatrimonyId;

  void set hasLocation(int? hasLocation);

  int? get hasLocation;

  void set state(String? state);

  String? get state;

  void set city(String? city);

  String? get city;

  void set district(String? district);

  String? get district;

  void set address(String? address);

  String? get address;

  void set postalCode(int? postalCode);

  int? get postalCode;

  void set longitude(double? longitude);

  double? get longitude;

  void set latitude(double? latitude);

  double? get latitude;

  void set altitude(double? altitude);

  double? get altitude;

}