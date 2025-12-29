/// @desc Resume the current paused music
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineMusicResume(_category = 0) {
	var _currentMusic = __AEMusicGetCurrentMusic(_category);
	
	if(_currentMusic.id != -1) {
		for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
			var _track = _currentMusic.tracks[_i];
			
			if(audio_is_paused(_track.ref)) {
				audio_resume_sound(_track.ref);
			}

		}	
	}
}
