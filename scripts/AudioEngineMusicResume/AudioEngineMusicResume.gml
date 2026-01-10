/// @desc Resume the current paused music
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
// Feather ignore once GM1045
function AudioEngineMusicResume(_category = 0) {
	// Feather ignore once GM1041 The enum value is correct
	var _currentMusic = __AEMusicGetCurrentMusic(_category);
	
	if(_currentMusic.id != -1) {
		
		array_foreach(_currentMusic.tracks, __AEResume);
	
	}
}

/// @desc Resume all current music
function AudioEngineMusicResumeAll() {
	
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_MUSIC);

	array_foreach(_filtered, __AEResume);

}