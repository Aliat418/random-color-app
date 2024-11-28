class AppColor {
  final int red;
  final int green;
  final int blue;
  final double opacity;

  const AppColor({
    required this.red,
    required this.green,
    required this.blue,
    this.opacity = 1.0,
  });

  factory AppColor.dark() {
    return const AppColor(
      red: 0,
      green: 0,
      blue: 0,
    );
  }

  factory AppColor.light() {
    return const AppColor(
      red: 255,
      green: 255,
      blue: 255,
    );
  }

  factory AppColor.fromRGBO({
    required int red,
    required int green,
    required blue,
  }) {
    return AppColor(
      red: red,
      green: green,
      blue: blue,
    );
  }
}
