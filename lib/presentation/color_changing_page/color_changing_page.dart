import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/infrastructure/locator.dart';
import '../../domain/model/app_color.dart';
import '../../core/extension/build_context_ext.dart';

import 'color_changing_cubit.dart';

class ColorChangingScreen extends StatefulWidget {
  const ColorChangingScreen({super.key});

  @override
  State<ColorChangingScreen> createState() => _ColorChangingScreenState();
}

class _ColorChangingScreenState extends State<ColorChangingScreen>
    with SingleTickerProviderStateMixin {
  late final ColorChangingCubit _cubit;
  late final AnimationController _animationController;

  static const _animationDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    _cubit = locator.get<ColorChangingCubit>()..init();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleTap(ColorChangingState state) async {
    await _cubit.updateColors(state.colorChangeCount ?? 0);
    await (_animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse());
  }

  // Convert AppColor to Flutter Color
  Color _convertToColor(AppColor? color) {
    return color != null
        ? Color.fromRGBO(color.red, color.green, color.blue, color.opacity)
        : Colors.black;
  }

  TextStyle _getTitleStyle(AppColor? color) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.9,
      height: 1.14,
      color: _convertToColor(color),
    );
  }

  TextStyle _getSubTitleTextStyle(AppColor? color) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      letterSpacing: 1.1,
      height: 1.24,
      color: _convertToColor(color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _convertToColor(AppColor.light()),
      body: BlocProvider.value(
        value: _cubit,
        child: BlocBuilder<ColorChangingCubit, ColorChangingState>(
          builder: (context, state) {
            switch (state.status) {
              case ColorChangePageStatus.loading:
                return const CircularProgressIndicator();
              case ColorChangePageStatus.error:
                return const SizedBox.shrink();
              case ColorChangePageStatus.loaded:
                return _buildLoadedState(state);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadedState(ColorChangingState state) {
    return GestureDetector(
      onTap: () async => _handleTap(state),
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                _buildBackgroundContainer(state),
                _buildTransformable(state),
              ],
            );
          }),
    );
  }

  Widget _buildBackgroundContainer(ColorChangingState state) {
    return Container(
      width: double.infinity,
      color: _convertToColor(
        _animationController.isForwardOrCompleted
            ? state.newBackgroundColor
            : state.currentBackgroundColor,
      ),
      child: _buildTextHolder(state, isBackground: true),
    );
  }

  Widget _buildTransformable(ColorChangingState state) {
    final scale = 1 - (_animationController.value * 1);
    return Transform(
      transform: Matrix4.identity()..scale(scale),
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        color: _convertToColor(state.newBackgroundColor),
        child: _buildTextHolder(state),
      ),
    );
  }

  Widget _buildTextHolder(
    ColorChangingState state, {
    bool isBackground = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.strings.helloThere,
          style: _getTitleStyle(
            _animationController.isDismissed && isBackground
                ? state.currentTextColor
                : state.newTextColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          context.strings.colorsChanged(state.colorChangeCount ?? 0),
          style: _getSubTitleTextStyle(
            _animationController.isDismissed && isBackground
                ? state.currentTextColor
                : state.newTextColor,
          ),
        ),
      ],
    );
  }
}
