// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../page/color_changing_cubit.dart' as _i357;
import '../repository/color_repository.dart' as _i1046;
import '../service/color_changing_service.dart' as _i1048;

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
  gh.singleton<_i1048.ColorChangingService>(
    () => _i1048.SimpleColorChangingService(),
    instanceName: 'SimpleColorChangingService',
  );
  gh.singleton<_i1048.ColorChangingService>(
    () => _i1048.CustomColorChangingService(),
    instanceName: 'CustomColorChangingService',
  );
  gh.singleton<_i1046.ColorRepository>(() => _i1046.ColorRepository(
        simpleColorService: gh<_i1048.ColorChangingService>(
            instanceName: 'SimpleColorChangingService'),
        customColorService: gh<_i1048.ColorChangingService>(
            instanceName: 'CustomColorChangingService'),
      ));
  gh.factory<_i357.ColorChangingCubit>(
      () => _i357.ColorChangingCubit(gh<_i1046.ColorRepository>()));
  return getIt;
}
