/// Define a single-track music
/// @param {Enum.AUDIO_MUSIC} _musicIndex
/// @param {Asset.GMSound,String} _asset
/// @param {Real} _priority Sound Priority
/// @param {Real} _volume Initial _volume
function AudioEngineDefineMusic(_musicIndex, _asset, _priority = 1, _volume = 1){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		library.music[$ _musicIndex] = {
			asset: _asset, 
			volume: _volume, 
			priority: _priority, 
			multi: false, 
			isStream: is_string(_asset)
		};
	}
}

/// @param {Asset.GMSound,String} _asset
/// @param {Enum.AUDIO_MULTITRACK_MOOD} _mood Music Mood
/// @param {Real} _volume Initial volume
function AudioEngineTrack(_asset = noone, _mood = 0, _volume = 1) constructor {
	asset = _asset;
	mood = _mood;
	volume = _volume;
}

/// Define a multi-track music
/// @param {Enum.AUDIO_MUSIC} _musicIndex
/// @param {Array.AudioEngineTrack} _tracks
/// @param {Real} _priority Sound Priority
function AudioEngineDefineMultiTrackMusic(_musicIndex, _tracks, _priority = 1){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		
		var _assets = [];
		for(var _i = 0; _i < array_length(_tracks); _i++) {
			var _track = _tracks[_i];
			_assets[@ _track.mood] = {
				asset: _track.asset, 
				mood: _track.mood, 
				volume: _track.volume, 
				isStream: is_string(_track.asset)
			}
		}
		library.music[$ _musicIndex] = {
			assets: _assets, 
			priority: _priority, 
			multi: true
		};
	}
}

/// Define a UI sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundIndex
/// @param {Asset.GMSound|String} _asset
/// @param {Real} _priority Sound Priority
/// @param {Real} _volume Initial volume
/// @param {Real} _pitch Initial pitch
/// @param {Real} _volumeVariance Random volume variance
/// @param {Real} _pitchVariance Random volume variance
function AudioEngineDefineUISound(_uiSoundIndex, _asset, _priority = 1, _volume = 1, _volumeVariance = 0){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		library.ui[$ _uiSoundIndex] = {
			asset: _asset, 
			priority: _priority, 
			volume: _volume, 
			volumeVariance: _volumeVariance, 
			isStream: is_string(_asset),
			multi: false
		};
	}
}

/// Define a UI sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundIndex
/// @param {Array<Asset.GMSound,String>} _assets
/// @param {Real} _priority Sound Priority
/// @param {Real} _volume Initial volume
/// @param {Real} _pitch Initial pitch
/// @param {Real} _volumeVariance Random volume variance
/// @param {Real} _pitchVariance Random volume variance
function AudioEngineDefineUISoundArray(_uiSoundIndex, _assets, _priority = 1, _volume = 1, _volumeVariance = 0){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		
		var _assetsList = [];
		for(var _i = 0; _i < array_length(_assets); _i++) {
			var _asset = _assets[_i];
			array_push(_assetsList, {
				asset: _asset.asset, 
				isStream: is_string(_asset.asset)
			})
		}		
		
		library.ui[$ _uiSoundIndex] = {
			asset: _assetsList, 
			priority: _priority, 
			volume: _volume, 
			volumeVariance: _volumeVariance, 
			multi: true
		};
	}
}

/// Define a Game sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundIndex
/// @param {Asset.GMSound|String} _asset
/// @param {Bool} _spatialized Indicate if the sound is spatialized
/// @param {Real} _priority Sound Priority
/// @param {Real} _volume Initial volume
/// @param {Real} _pitch Initial pitch
/// @param {Real} _volumeVariance Random volume variance
/// @param {Real} _pitchVariance Random volume variance
function AudioEngineDefineGameSound(_uiSoundIndex, _asset, _spatialized = false, _priority = 1,_volume = 1, _volumeVariance = 0){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		library.game[$ _uiSoundIndex] = {
			asset: _asset, 
			spatialized: _spatialized, 
			priority: _priority, 
			volume: _volume, 
			volumeVariance: _volumeVariance, 
			isStream: is_string(_asset)
		};
	}
}

/// Define a UI sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundIndex
/// @param {Array<Asset.GMSound,String>} _assets
/// @param {Bool} _spatialized Indicate if the sound is spatialized
/// @param {Real} _priority Sound Priority
/// @param {Real} _volume Initial volume
/// @param {Real} _pitch Initial pitch
/// @param {Real} _volumeVariance Random volume variance
/// @param {Real} _pitchVariance Random volume variance
function AudioEngineDefineGameSoundArray(_uiSoundIndex, _assets, _spatialized = false,_priority = 1, _volume = 1, _volumeVariance = 0){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		
		var _assetsList = [];
		for(var _i = 0; _i < array_length(_assets); _i++) {
			var _asset = _assets[_i];
			array_push(_assetsList, {
				asset: _asset.asset, 
				isStream: is_string(_asset.asset)
			})
		}		
		
		library.game[$ _uiSoundIndex] = {
			asset: _assetsList, 
			priority: _priority, 
			spatialized: _spatialized, 
			volume: _volume, 
			volumeVariance: _volumeVariance, 
			multi: true
		};
	}
}