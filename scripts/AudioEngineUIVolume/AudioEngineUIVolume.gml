/// @desc Set the global music volume
/// @param {Real} _newVolume New Volume
/// @return {Undefined}
function AudioEngineUISetVolume(_newVolume) {

    static _system = __AudioEngineSystem();

    var _busArray = __AEBusGetAll(__AUDIOENGINE_PREFIX_UI);

    _system.volumes.ui = clamp(_newVolume, 0, 1);

    for(var _i = 0; _i < array_length(_busArray); _i++) {
        var _bus = _busArray[_i];

        // Feather ignore once GM1041 The enum value is correct
        __AEUIUpdateVolume(_bus.category, _bus);
    }

}

/// @desc Set the music volume for a category
/// @param {Real} _newVolume New Volume
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineUISetCategoryVolume(_newVolume, _category = 0) {

    // Feather ignore once GM1041 The enum value is correct
    var _bus = __AEVolumeUpdate(__AUDIOENGINE_PREFIX_UI, "ui", _category, _newVolume);

    // Feather ignore once GM1041 The enum value is correct
    __AEUIUpdateVolume(_category, _bus);
}

/// @desc Get the music volume for a category
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Real} Category volume
// Feather ignore once GM1045
function AudioEngineUIGetCategoryVolume(_category = 0) {

    var _bus = __AEBusGet(__AUDIOENGINE_PREFIX_UI, _category);

    return _bus.volume;

}
