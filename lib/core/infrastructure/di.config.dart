// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repository/color_repository.dart' as _i508;
import '../../data/service/color_changing_service.dart' as _i807;
import '../../data/service/custom_color_changing_service.dart' as _i673;
import '../../data/service/simple_color_changing_service.dart' as _i424;
import '../../presentation/color_changing_page/color_changing_cubit.dart'
    as _i92;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $configureDependencies(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i807.ColorChangingService>(
    () => _i673.CustomColorChangingService(),
    instanceName: 'CustomColorChangingService',
  );
  gh.singleton<_i807.ColorChangingService>(
    () => _i424.SimpleColorChangingService(),
    instanceName: 'SimpleColorChangingService',
  );
  gh.singleton<_i508.ColorRepository>(() => _i508.ColorRepository(
        simpleColorService: gh<_i807.ColorChangingService>(
            instanceName: 'SimpleColorChangingService'),
        customColorService: gh<_i807.ColorChangingService>(
            instanceName: 'CustomColorChangingService'),
      ));
  gh.factory<_i92.ColorChangingCubit>(
      () => _i92.ColorChangingCubit(gh<_i508.ColorRepository>()));
  return getIt;
}
