part of 'color_changing_cubit.dart';

enum ColorChangePageStatus {
  loading,
  loaded,
  error,
}

class ColorChangingState extends Equatable {
  final ColorChangePageStatus status;
  final AppColor? newBackgroundColor;
  final AppColor? newTextColor;
  final AppColor? currentBackgroundColor;
  final AppColor? currentTextColor;
  final int? colorChangeCount;

  const ColorChangingState({
    this.status = ColorChangePageStatus.loading,
    this.newBackgroundColor,
    this.newTextColor,
    this.currentBackgroundColor,
    this.currentTextColor,
    this.colorChangeCount,
  });

  ColorChangingState copyWith({
    ColorChangePageStatus? status,
    AppColor? newBackgroundColor,
    AppColor? newTextColor,
    AppColor? currentBackgroundColor,
    AppColor? currentTextColor,
    int? colorChangeCount,
  }) {
    return ColorChangingState(
      status: status ?? this.status,
      newBackgroundColor: newBackgroundColor ?? this.newBackgroundColor,
      newTextColor: newTextColor ?? this.newTextColor,
      currentBackgroundColor:
          currentBackgroundColor ?? this.currentBackgroundColor,
      currentTextColor: currentTextColor ?? this.currentTextColor,
      colorChangeCount: colorChangeCount ?? this.colorChangeCount,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      newBackgroundColor,
      newTextColor,
      currentBackgroundColor,
      currentTextColor,
      colorChangeCount,
    ];
  }
}
