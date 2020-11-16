import 'package:json_annotation/json_annotation.dart';

part 'owner_details.g.dart';

@JsonSerializable()
class OwnerDetails {
  final String name;
  final String mobile;
  final String imageUrl;

  factory OwnerDetails.initial() => OwnerDetails(
        imageUrl: '',
        name: '',
        mobile: '',
      );
  OwnerDetails({this.imageUrl, this.mobile, this.name});

  OwnerDetails copyWith({
    String imageUrl,
    String mobile,
    String name,
  }) {
    return OwnerDetails(
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory OwnerDetails.fromJson(Map<String, dynamic> data) =>
      _$OwnerDetailsFromJson(data);

  Map<String, dynamic> toJson() => _$OwnerDetailsToJson(this);
}
