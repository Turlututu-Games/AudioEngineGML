/// @desc Play a game sound
/// @module Game
/// @param {Enum.AE_GAME_SOUND} _gameSoundInstance Sound key
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real} [_volumeOffset] Optional offset for the volume
/// @param {Real} [_pitchOffset] Optional offset for the pitch
/// @return {Struct.__AESystemPlaying} Sound reference
// Feather ignore once GM1045
function AudioEngineGamePlay(_gameSoundInstance, _category = 0, _volumeOffset = 0, _pitchOffset = 0){
    // Feather ignore once GM1041 The enum value is correct
    return __AEGamePlay(_gameSoundInstance, _category, 0, 0, 0, _volumeOffset, _pitchOffset, []);
}

/// @desc Play a spatialized game sound at a position. Position do nothing for non-spatialized sounds
/// @module Game
/// @param {Enum.AE_GAME_SOUND} _gameSoundInstance Sound key
/// @param {Real} _x X position
/// @param {Real} _y Y position
/// @param {Real} [_z] Z position. Default to 0
/// @param {Real} [_volumeOffset] Optional offset for the volume
/// @param {Real} [_pitchOffset] Optional offset for the pitch
/// @param {Array<Struct.AudioEffect>,Struct.AudioEffect} [_effects] Default effet or array of effects to apply to the sound
/// @return {Struct.__AESystemPlaying} Sound reference
function AudioEngineGamePlayAt(_gameSoundInstance, _x, _y, _z = 0, _volumeOffset = 0, _pitchOffset = 0, _effects = []){
    var _id = __AESystemUniqueId();

    var _effectsArray = is_array(_effects) ? _effects : [_effects];

    // Feather ignore once GM1041 The enum value is correct
    return __AEGamePlay(_gameSoundInstance, _id, _x, _y, _z, _volumeOffset, _pitchOffset, _effectsArray);
}

/// @desc Play a spatialized game sound at a position. Position do nothing for non-spatialized sounds
/// @module Game
/// @param {Enum.AE_GAME_SOUND} _gameSoundInstance Sound key
/// @param {Id.Instance,Asset.GMObject} _instance Object instance used to get the position
/// @param {Real} [_z] Z position. Default to 0
/// @param {Real} [_volumeOffset] Optional offset for the volume
/// @param {Real} [_pitchOffset] Optional offset for the pitch
/// @param {Array<Struct.AudioEffect>,Struct.AudioEffect} [_effects] Default effet or array of effects to apply to the sound
/// @return {Struct.__AESystemPlaying} Sound reference
function AudioEngineGamePlayAtObject(_gameSoundInstance, _instance, _z = 0, _volumeOffset = 0, _pitchOffset = 0, _effects = []){

    var _x = _instance.x;
    var _y = _instance.y;
    var _id = real(_instance.id);

    var _effectsArray = is_array(_effects) ? _effects : [_effects];

    // Feather ignore once GM1041 The enum value is correct
    return __AEGamePlay(_gameSoundInstance, _id, _x, _y, _z, _volumeOffset, _pitchOffset, _effectsArray);
}