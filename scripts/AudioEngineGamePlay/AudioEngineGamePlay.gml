/// @desc Play a game sound
/// @param {Enum.AUDIO_GAME_SOUND} _gameSoundInstance Sound key
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real} [_volumeOffset] Optional offset for the volume
/// @param {Real} [_pitchOffset] Optional offset for the pitch
/// @return {Struct.__AESystemPlaying} Sound reference
function AudioEngineGamePlay(_gameSoundInstance, _category = 0, _volumeOffset = 0, _pitchOffset = 0){
	return __AEUIGamePlay(_gameSoundInstance, _category, 0, 0, 0, 0, _volumeOffset, _pitchOffset);
}

/// @desc Play a spatialized game sound at a position. Position do nothing for non-spatialized sounds
/// @param {Enum.AUDIO_GAME_SOUND} _gameSoundInstance Sound key
/// @param {Real} _x X position
/// @param {Real} _y Y position
/// @param {Real} [_z] Z position. Default to 0
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real} [_volumeOffset] Optional offset for the volume
/// @param {Real} [_pitchOffset] Optional offset for the pitch
/// @return {Struct.__AESystemPlaying} Sound reference
function AudioEngineGamePlayAt(_gameSoundInstance, _x, _y, _z = 0, _category = 0, _volumeOffset = 0, _pitchOffset = 0){
	var _id = __AudioEngineSystemUniqueId();
	return __AEUIGamePlay(_gameSoundInstance, _category, _id, _x, _y, _z, _volumeOffset, _pitchOffset);
}

/// @desc Play a spatialized game sound at a position. Position do nothing for non-spatialized sounds
/// @param {Enum.AUDIO_GAME_SOUND} _gameSoundInstance Sound key
/// @param {Id.Instance,Asset.GMObject} _instance Object instance used to get the position
/// @param {Real} [_z] Z position. Default to 0
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real} [_volumeOffset] Optional offset for the volume
/// @param {Real} [_pitchOffset] Optional offset for the pitch
/// @return {Struct.__AESystemPlaying} Sound reference
function AudioEngineGamePlayAtObject(_gameSoundInstance, _instance, _z = 0, _category = 0, _volumeOffset = 0, _pitchOffset = 0){
	
	var _x = _instance.x;
	var _y = _instance.y;
	var _id = real(_instance.id);
	
	return __AEUIGamePlay(_gameSoundInstance, _category, _id, _x, _y, _z, _volumeOffset, _pitchOffset);
}