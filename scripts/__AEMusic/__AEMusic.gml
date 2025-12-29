/// @desc Get Current Music
/// @param {Enum.AUDIO_CATEGORIES} _category
/// @return {Struct.__AEMusicCurrentMusic}
function __AEMusicGetCurrentMusic(_category) {
	static _system = __AudioEngineSystem();
	
	if(_system.currentMusics[$ _category] == undefined) {
		_system.currentMusics[$ _category] = new __AEMusicCurrentMusic();
	}	
	
	return _system.currentMusics[$ _category];
}

/// @desc Reset Current Music
/// @param {Enum.AUDIO_CATEGORIES} _category
function __AEMusicResetCurrentMusic(_category) {
	static _system = __AudioEngineSystem();
	
	_system.currentMusics[$ _category] = new __AEMusicCurrentMusic();

}

/// @desc Directly Stop Current Music
/// @param {Enum.AUDIO_CATEGORIES} _category
function __AEMusicStop(_category) {
	var _currentMusic = __AEMusicGetCurrentMusic(_category);
	
	if(_currentMusic.id != -1) {
			
		if(_currentMusic.multi) {				
			for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
				var _track = _currentMusic.tracks[_i];
				
				audio_stop_sound(_track.asset);
				
				if(_track.isStream) {
					audio_destroy_stream(_track.asset);
				}
			}		
		} else {
			audio_stop_sound(_currentMusic.tracks[0].asset);
			
			if(_currentMusic.tracks[0].isStream) {
				audio_destroy_stream(_currentMusic.tracks[0].asset);
			}
		}
	}
}

/// @desc Stop Current Music with fade-out
/// @param {Enum.AUDIO_CATEGORIES} _category
/// @param {Real} _fade
function __AEMusicStopWithFade(_category, _fade) {
		
	var _currentMusic = __AEMusicGetCurrentMusic(_category);
	
	if(_currentMusic.id != -1) {
			
		if(_currentMusic.multi) {
			for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
				var _track = _currentMusic.tracks[_i];
				
				audio_sound_gain(_track.ref, 0, _fade);

			}	
		} else {
			audio_sound_gain(_currentMusic.tracks[0].ref, 0, _fade);
		}
		
		with(__oAudioEngineManager) {
			alarm_set(0, _fade);
		}		
	}
}

/// @desc Play a new music
/// @param {Enum.AUDIO_MUSIC} _musicInstance
/// @param {Enum.AUDIO_CATEGORIES} _category
/// @param {Real} _fade
/// @param {Array<Enum.AUDIO_MULTITRACK_MOOD>} _previousMoods
function __AEMusicPlayWithFade(_musicInstance, _category, _fade, _previousMoods) {
	
	static _system = __AudioEngineSystem();
	
	var _newMusic = _system.library.music[$ _musicInstance];
		
	if(!_newMusic) {
		// The music does not exists! Log it
		show_debug_message("Invalid music id: {0}", _musicInstance);
		return;	
	}
		
	
	var _bus = __AEBusGet($"music-{_category}");			
		
	if(_newMusic.multi) {
		// Multi-track music	
		var _currentMusic = new __AEMusicCurrentMusic(_musicInstance, [], true, _previousMoods);		
			
		for(var _i = 0; _i < array_length(_newMusic.assets); _i++) {
			var _music = _newMusic.assets[_i];
				
			var _musicAsset = __AEMusicReturnAsset(_music);

			var _ref = audio_play_sound_on(_bus.emitter, _musicAsset, true, _newMusic.priority);
			
			array_push(_currentMusic.tracks, new __AEMusicCurrentMusicTrack(_musicAsset, _music.isStream, _music.mood, _music.volume, _ref) );

			if(array_get_index(_currentMusic.moods, _music.mood) == -1) {
				audio_sound_gain(_ref, 0, 0);
			} else {
				if(_fade > 0) {
					// Immediate start at volume 0 then go to wanted volume on fade time
					audio_sound_gain(_ref, 0, 0);
					audio_sound_gain(_ref, _music.volume, _fade);				
				} else {
					audio_sound_gain(_ref, _music.volume, 0);	
				}
			}
		}
							
		_system.currentMusics[$ _category] = _currentMusic;		
	} else {
			
		var _music = __AEMusicReturnAsset(_newMusic);

		var _ref = audio_play_sound_on(_bus.emitter, _music, true, _newMusic.priority);
		
		if(_fade > 0) {
			audio_sound_gain(_ref, 0, 0);
			audio_sound_gain(_ref, _newMusic.volume, _fade);
		} else {
			audio_sound_gain(_ref, _newMusic.volume, 0);
		}
			
		var _currentMusic = new __AEMusicCurrentMusic(_musicInstance);
		_currentMusic.tracks = [new __AEMusicCurrentMusicTrack(_music, _newMusic.isStream, 0, _newMusic.volume, _ref)];
		_currentMusic.multi = false;
			
		_system.currentMusics[$ _category] = _currentMusic;
			
	}
}

/// @desc Return the sound asset
/// @param {Asset.GMSound,String} _asset
/// @return {Asset.GMSound}
function __AEMusicReturnAsset(_asset) {
	if(_asset.isStream) {
		return audio_create_stream(_asset.asset);
	}
	
	return _asset.asset;
	
}

/// @desc Current Music Track
/// @param {Asset.GMSound,String} _asset
/// @param {Bool} _isStream
/// @param {Enum.AUDIO_MULTITRACK_MOOD} _mood
/// @param {Real} _volume
/// @param {Id.Sound} _ref
function __AEMusicCurrentMusicTrack(_asset = noone, _isStream = false, _mood = 0, _volume = 1, _ref = noone) constructor {
	asset = _asset;
	isStream = _isStream;
	mood = _mood;
	volume = _volume;
	ref = _ref;
}

/// @desc Current Music
/// @param {Enum.AUDIO_MUSIC} _id
/// @param {Array<Struct.__AEMusicCurrentMusicTrack>} _tracks
/// @param {Bool} _multi
/// @param {Array<Enum.AUDIO_MULTITRACK_MOOD>} _moods
function __AEMusicCurrentMusic(_id = -1, _tracks = [], _multi = false, _moods = [0]) constructor {
	id = _id;
	tracks = _tracks
	multi = _multi;	
	moods = _moods;
	
	// Ensure mood 0 is set if moods are empty
	if(array_length(moods) == 0) {
		array_push(moods, 0)	
	}
}