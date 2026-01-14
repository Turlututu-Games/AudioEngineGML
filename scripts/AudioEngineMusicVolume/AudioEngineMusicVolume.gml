/// @desc Set the global music volume
/// @module Music
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Music?id=AudioEngineMusicSetVolume
/// @param {Real} _newVolume New Volume
/// @return {Undefined}
function AudioEngineMusicSetVolume(_newVolume) {

    if (!is_real(_newVolume)) {
        __AELogError("Volume must be a real number, got: " + string(typeof(_newVolume)));
        return;
    }

    static _system = __AudioEngineSystem();

    var _busArray = __AEBusGetAll(__AUDIOENGINE_PREFIX_MUSIC);

    _system.volumes.music = clamp(_newVolume, 0, 1);

    for(var _i = 0; _i < array_length(_busArray); _i++) {
        var _bus = _busArray[_i];

        // Feather ignore once GM1041 The enum value is correct
        __AEMusicUpdateVolume(_bus.category, _bus);
    }

}

/// @desc Set the music volume for a category
/// @module Music
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Music?id=AudioEngineMusicSetCategoryVolume
/// @param {Real} _newVolume New Volume
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineMusicSetCategoryVolume(_newVolume, _category = 0) {

    // Feather ignore once GM1041 The enum value is correct
    var _bus = __AEVolumeUpdate(__AUDIOENGINE_PREFIX_MUSIC, "music", _category, _newVolume);

    // Feather ignore once GM1041 The enum value is correct
    __AEMusicUpdateVolume(_category, _bus);
}

/// @desc Get the music volume for a category
/// @module Music
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Music?id=AudioEngineMusicGetCategoryVolume
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Real} Category volume
// Feather ignore once GM1045
function AudioEngineMusicGetCategoryVolume(_category = 0) {

    var _bus = __AEBusGet(__AUDIOENGINE_PREFIX_MUSIC, _category);

    return _bus.volume;

}
