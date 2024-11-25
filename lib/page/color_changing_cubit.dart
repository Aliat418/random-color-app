import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../service/color_changing_service.dart';
import '../model/app_color.dart';

part 'color_changing_state.dart';

@injectable
class ColorChangingCubit extends Cubit<ColorChangingState> {
  final ColorRepository colorRepository;
  ColorChangingCubit(this.colorRepository) : super(const ColorChangingState());

  Future<void> _handleOperation(AsyncCallback function) async {
    try {
      emit(state.copyWith(status: ColorChangePageStatus.loading));
      await function();
    } on Exception catch (e) {
      log(e.toString());
      emit(state.copyWith(status: ColorChangePageStatus.error));
    }
  }

  Future<void> init() async {
    await _handleOperation(() async {
      final currentBackgroundColor = colorRepository.generateRandomColor();
      final currentTextColor = colorRepository.selectAccessibleColor(
        currentBackgroundColor,
      );

      emit(state.copyWith(
        newBackgroundColor: currentBackgroundColor,
        newTextColor: currentTextColor,
        colorChangeCount: 0,
        status: ColorChangePageStatus.loaded,
      ));
    });
  }

  Future<void> updateColors(int count) async {
    await _handleOperation(() async {
      final newBackgroundColor = await colorRepository.generateRandomColor();
      final newTextColor = await colorRepository.selectAccessibleColor(
        newBackgroundColor,
      );

      emit(state.copyWith(
        currentBackgroundColor: state.newBackgroundColor,
        currentTextColor: state.newTextColor,
        newBackgroundColor: newBackgroundColor,
        newTextColor: newTextColor,
        colorChangeCount: count + 1,
        status: ColorChangePageStatus.loaded,
      ));
    });
  }
}
