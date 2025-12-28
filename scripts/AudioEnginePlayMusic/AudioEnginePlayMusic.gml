function AudioEnginePlayMusic(_musicInstance, _crossfadeTime = 0) {
	static _system = __AudioEngineSystem();
	
	// If the new track is the same than the old, do nothing
	if(_system.currentMusic != undefined && _system.currentMusic.id == _musicInstance) {
		return;	
	}
	
	if(_crossfadeTime <= 0) {
		__AudioEnginePlayMusicStop(_system);
	} else {
		__AudioEnginePlayMusicStopWithFade(_system, _crossfadeTime);
	}
	
	__AudioEnginePlayMusicPlayWithFade(_system, _musicInstance, _crossfadeTime);
}

function AudioEngineStopMusic(_crossfadeTime = 0) {
	static _system = __AudioEngineSystem();
	
	if(_crossfadeTime <= 0) {
		__AudioEnginePlayMusicStop(_system);
	} else {
		__AudioEnginePlayMusicStopWithFade(_system, _crossfadeTime);
	}
	
	_system.currentMusic = undefined;
}

function AudioEngineSetStateMusic(_state, _crossfadeTime = 0) {
	static _system = __AudioEngineSystem();
			
	if(is_array(_state)) {
		_system.currentState = _state;
	} else {
		_system.currentState = [_state];
	}
	
	if(_system.currentMusic != undefined && _system.currentMusic.multi) {
		for(var _i = 0; _i < array_length(_system.currentMusic.assets); _i++) {
			var _music = _system.currentMusic.assets[_i];
			
			if(array_get_index(_system.currentState, _music.state) == -1) {
				audio_sound_gain(_music.asset, 0, _crossfadeTime);
			} else {
				audio_sound_gain(_music.asset, _music.volume, _crossfadeTime);
			}			
			
		}	
	}
}


function __AudioEnginePlayMusicStop(_system) {
	if(_system.currentMusic != undefined) {
			
		if(_system.currentMusic.multi) {
			audio_stop_sync_group(_system.currentMusic.group);
				
			for(var _i = 0; _i < array_length(_system.currentMusic.assets); _i++) {
				var _music = _system.currentMusic.assets[_i];
				if(_music.isStream) {
					audio_destroy_stream(_music.asset);
				}
			}		
			
			audio_destroy_sync_group(_system.currentMusic.group);
		} else {
			audio_stop_sound(_system.currentMusic.asset);
			
			if(_system.currentMusic.isStream) {
				audio_destroy_stream(_system.currentMusic.asset);
			}
		}
	}
}

function __AudioEnginePlayMusicStopWithFade(_system, _fade) {
	if(_system.currentMusic != undefined) {
			
		if(_system.currentMusic.multi) {
			for(var _i = 0; _i < array_length(_system.currentMusic.assets); _i++) {
				var _music = _system.currentMusic.assets[_i];
				
				audio_sound_gain(_music.asset, 0, _fade);

			}	
		} else {
			audio_sound_gain(_system.currentMusic.asset, 0, _fade);
		}
		
		with(oAudioEngineManager) {
			alarm_set(0, _fade);
		}		
	}
}

function __AudioEnginePlayMusicPlayWithFade(_system, _musicInstance, _fade) {
	var _newMusic = _system.library.music[@ _musicInstance];
		
	if(!_newMusic) {
		// The music does not exists! Log it
		return;	
	}
		
	if(_newMusic.multi) {
		// Multi-track music	
		var _currentMusic = new __AudioEngineSystemCurrentMusic(_musicInstance);
		
		var _group = audio_create_sync_group(true);
			
		for(var _i = 0; _i < array_length(_newMusic.assets); _i++) {
			var _music = _newMusic.assets[_i];
				
			var _musicAsset = __AudioEngineReturnAsset(_music);
				
			array_push(_currentMusic.assets, {
				asset: _musicAsset, 
				isStream: _music.isStream,
				state: _music.state,
				volume: _music.volume
			});
				
			audio_play_in_sync_group(_group, _musicAsset);
			if(array_get_index(_system.currentState, _music.state) == -1) {
				audio_sound_gain(_musicAsset, 0, 0);
			} else {
				audio_sound_gain(_musicAsset, _music.volume, _fade);
			}
		}
			
		audio_start_sync_group(_group);
			
			
		_currentMusic.multi = true;
		_currentMusic.group = _group;
			
		_system.currentMusic = _currentMusic;			
	} else {
			
		var _music = __AudioEngineReturnAsset(_newMusic);
		audio_play_sound(_music, _newMusic.priority, true);
		audio_sound_gain(_music, 0, 0);
		audio_sound_gain(_music, _newMusic.volume, _fade);
			
		var _currentMusic = new __AudioEngineSystemCurrentMusic(_musicInstance);
		_currentMusic.asset = _music;
		_currentMusic.isStream = _newMusic.isStream;
		_currentMusic.multi = false;
			
		_system.currentMusic = _currentMusic;
			
	}
}

function __AudioEngineReturnAsset(_asset) {
	if(_asset.isStream) {
		return audio_create_stream(_asset.asset);
	}
	
	return _asset.asset;
	
}

function __AudioEngineSystemCurrentMusic(_id, _asset = noone, _assets = [], _group = undefined, _isStream = false, _multi = false) constructor {
	id = _id;
	asset = _asset;
	assets = _assets
	group = _group
	isStream = _isStream
	multi = _multi
}