/// @desc Set the global music volume
/// @param {Real} _newVolume New Volume
/// @return {Undefined}
function AudioEngineGameSetVolume(_newVolume) {

    static _system = __AudioEngineSystem();

    var _busStaticArray = __AEBusGetAll(__AUDIOENGINE_PREFIX_STATIC_GAME);
    var _busSpatializedArray = __AEBusGetAll(__AUDIOENGINE_PREFIX_SPATIALIZED_GAME);

    _system.volumes.game = clamp(_newVolume, 0, 1);

    for(var _i = 0; _i < array_length(_busStaticArray); _i++) {
        var _bus = _busStaticArray[_i];

        // Feather ignore once GM1041 The enum value is correct
        __AEGameUpdateStaticVolume(_bus.category, _bus);
    }

    for(var _i = 0; _i < array_length(_busSpatializedArray); _i++) {
        var _bus = _busSpatializedArray[_i];

        // Feather ignore once GM1041 The enum value is correct
        __AEGameUpdateSpatializedVolume(_bus.category, _bus);
    }

}

/// @desc Set the global music volume
/// @param {Real} _newVolume New Volume
/// @return {Undefined}
function AudioEngineGameSetSpatializedVolume(_newVolume) {

    static _system = __AudioEngineSystem();

    var _busArray = __AEBusGetAll(__AUDIOENGINE_PREFIX_SPATIALIZED_GAME);

    for(var _i = 0; _i < array_length(_busArray); _i++) {
        var _bus = _busArray[_i];

        _bus.volume = clamp(_newVolume, 0, 1);

        // Feather ignore once GM1041 The enum value is correct
        __AEGameUpdateSpatializedVolume(_bus.category, _bus);
    }

    _system.defaultBusVolumes[$ __AUDIOENGINE_PREFIX_SPATIALIZED_GAME] = _newVolume;

}

/// @desc Set the music volume for a category
/// @param {Real} _newVolume New Volume
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineGameSetStaticVolume(_newVolume, _category = 0) {

    // Feather ignore once GM1041 The enum value is correct
    var _bus = __AEVolumeUpdate(__AUDIOENGINE_PREFIX_STATIC_GAME, "game", _category, _newVolume);

    // Feather ignore once GM1041 The enum value is correct
    __AEGameUpdateStaticVolume(_category, _bus);
}

/// @desc Get the music volume for a category
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Real} Category volume
// Feather ignore once GM1045
function AudioEngineGameStaticGetCategoryVolume(_category = 0) {

    var _bus = __AEBusGet(__AUDIOENGINE_PREFIX_STATIC_GAME, _category);

    return _bus.volume;

}
