/// @desc Play a ui sound
/// @module UI
/// @param {Enum.AE_UI_SOUND} _uiSoundInstance Sound key
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real} [_volumeOffset] Optional offset for the volume
/// @param {Real} [_pitchOffset] Optional offset for the pitch
/// @return {Struct.__AESystemPlaying} Sound reference
// Feather ignore once GM1045
function AudioEngineUIPlay(_uiSoundInstance, _category = 0, _volumeOffset = 0, _pitchOffset = 0){
    // Feather ignore once GM1041 The enum value is correct
    return __AEUIPlay(_uiSoundInstance, _category, _volumeOffset, _pitchOffset);
}