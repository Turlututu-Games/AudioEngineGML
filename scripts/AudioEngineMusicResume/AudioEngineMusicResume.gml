/// @desc Resume the current paused music
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineMusicResume(_category = 0) {
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