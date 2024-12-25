class DaySys {
  String? pod;

  DaySys({this.pod});

  factory DaySys.fromJson(Map<String, dynamic> json) => DaySys(
        pod: json['pod'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'pod': pod,
      };
}
