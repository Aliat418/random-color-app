import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../repository/color_repository.dart';
import '../model/app_color.dart';

part 'color_changing_state.dart';

@injectable
class ColorChangingCubit extends Cubit<ColorChangingState> {
  final ColorRepository colorRepository;

  ColorChangingCubit(
    this.colorRepository,
  ) : super(const ColorChangingState());

  Future<void> _handleOperation(AsyncCallback function) async {
    try {
      emit(state.copyWith(status: ColorChangePageStatus.loading));
      await function();
    } on Exception catch (e) {
      // Simulate error logging
      log(e.toString());
      emit(state.copyWith(status: ColorChangePageStatus.error));
    }
  }

  Future<void> init() async {
    await _handleOperation(() async {
      final currentBackground = await colorRepository.generateRandomColor();
      final currentTextColor = await colorRepository.selectAccessibleColor(
        currentBackground,
      );

      emit(state.copyWith(
        newBackgroundColor: currentBackground,
        newTextColor: currentTextColor,
        colorChangeCount: 0,
        status: ColorChangePageStatus.loaded,
      ));
    });
  }

  Future<void> updateColors(int count) async {
    await _handleOperation(() async {
      final newBackground = await colorRepository.generateRandomColor();
      final newTextColor = await colorRepository.selectAccessibleColor(
        newBackground,
      );

      emit(state.copyWith(
        currentBackgroundColor: state.newBackgroundColor,
        currentTextColor: state.newTextColor,
        newBackgroundColor: newBackground,
        newTextColor: newTextColor,
        colorChangeCount: count + 1,
        status: ColorChangePageStatus.loaded,
      ));
    });
  }
}
