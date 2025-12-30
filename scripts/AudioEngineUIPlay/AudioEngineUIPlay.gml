/// @desc Play a ui sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundInstance Sound key
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real} [_volumeOffset] Optional offset for the volume
/// @param {Real} [_pitchOffset] Optional offset for the pitch
/// @return {Struct.__AESystemPlaying} Sound reference
function AudioEngineUIPlay(_uiSoundInstance, _category = 0, _volumeOffset = 0, _pitchOffset = 0){
	return __AEUIPlay(_uiSoundInstance, _category, _volumeOffset, _pitchOffset);
}