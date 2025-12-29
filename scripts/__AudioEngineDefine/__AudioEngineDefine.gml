/// Define a single-track music
/// @param {Enum.AUDIO_MUSIC} _musicIndex
/// @param {Asset.GMSound,String} _asset
/// @param {Real} _priority Sound Priority
/// @param {Real} _volume Initial _volume
function AudioEngineDefineMusic(_musicIndex, _asset, _priority = 1, _volume = 1){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		var _newMusicSingle = new __AESystemLibraryMusicSingle();
		
		_newMusicSingle.asset = _asset;
		_newMusicSingle.volume = _volume;
		_newMusicSingle.priority = _priority;
		_newMusicSingle.isStream = is_string(_asset);
		
		library.music[$ _musicIndex] = _newMusicSingle;
	}
}

/// @param {Asset.GMSound,String} _asset
/// @param {Enum.AUDIO_MULTITRACK_MOOD} _mood Music Mood
/// @param {Real} _volume Initial volume
function AudioEngineDefineTrack(_asset = noone, _mood = 0, _volume = 1) constructor {
	asset = _asset;
	mood = _mood;
	volume = _volume;
}

/// Define a multi-track music
/// @param {Enum.AUDIO_MUSIC} _musicIndex
/// @param {Array<Struct.AudioEngineDefineTrack>} _tracks
/// @param {Real} _priority Sound Priority
function AudioEngineDefineMultiTrackMusic(_musicIndex, _tracks, _priority = 1){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		
		var _assets = [];
		for(var _i = 0; _i < array_length(_tracks); _i++) {
			var _track = _tracks[_i];
			
			var _newMusicTrack = new __AESystemLibraryMusicTrack();
			_newMusicTrack.asset = _track.asset;
			_newMusicTrack.isStream = is_string(_track.asset);
			_newMusicTrack.mood = _track.mood;
			_newMusicTrack.volume = _track.volume;
			
			
			_assets[@ _track.mood] = _newMusicTrack;
		}
		
		var _newMusicMulti = new __AESystemLibraryMusicMulti();
		
		_newMusicMulti.assets = _assets;
		_newMusicMulti.priority = _priority;
		
		library.music[$ _musicIndex] = _newMusicMulti;
	}
}

/// Define a UI sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundIndex
/// @param {Asset.GMSound|String} _asset
/// @param {Real} _priority Sound Priority
/// @param {Real} _volume Initial volume
/// @param {Real} _volumeVariance Random volume variance
/// @param {Real} _pitch Initial pitch
/// @param {Real} _pitchVariance Random pitch variance
function AudioEngineDefineUISound(_uiSoundIndex, _asset, _priority = 1, _volume = 1, _volumeVariance = 0, _pitch = 1, _pitchVariance = 0){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		
		var _newUISound = new __AESystemLibrarySound();
		
		_newUISound.asset = _asset;
		_newUISound.isStream = is_string(_asset);
		_newUISound.pitch = _pitch;
		_newUISound.pitchVariance = _pitchVariance;
		_newUISound.priority = _priority;
		_newUISound.volume = _volume;
		_newUISound.volumeVariance = _volumeVariance;
		
		library.ui[$ _uiSoundIndex] = _newUISound;
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
function AudioEngineDefineUISoundArray(_uiSoundIndex, _assets, _priority = 1, _volume = 1, _volumeVariance = 0, _pitch = 1, _pitchVariance = 0){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		
		var _assetsList = [];
		for(var _i = 0; _i < array_length(_assets); _i++) {
			var _asset = _assets[_i];
			var _track = new __AESystemLibrarySoundTrack();
			_track.asset = _asset.asset;
			_track.isStream = is_string(_asset.asset);
			
			array_push(_assetsList, _track)
		}		
		
		var _newUISoundArray = new __AESystemLibrarySoundArray();
		
		_newUISoundArray.assets = _assetsList;
		_newUISoundArray.priority = _priority;
		_newUISoundArray.pitch = _pitch;
		_newUISoundArray.pitchVariance = _pitchVariance;
		_newUISoundArray.volume = _volume;
		_newUISoundArray.volumeVariance = _volumeVariance;
		
		
		library.ui[$ _uiSoundIndex] = _newUISoundArray;
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
function AudioEngineDefineGameSound(_uiSoundIndex, _asset, _spatialized = false, _priority = 1,  _volume = 1, _volumeVariance = 0, _pitch = 1, _pitchVariance = 0){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		
		var _newGameSound = new __AESystemLibrarySound();
		
		_newGameSound.asset = _asset;
		_newGameSound.isStream = is_string(_asset);
		_newGameSound.pitch = _pitch;
		_newGameSound.pitchVariance = _pitchVariance;
		_newGameSound.priority = _priority;
		_newGameSound.spatialized = _spatialized;
		_newGameSound.volume = _volume;
		_newGameSound.volumeVariance = _volumeVariance;
		
		library.game[$ _uiSoundIndex] = _newGameSound;
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
function AudioEngineDefineGameSoundArray(_uiSoundIndex, _assets, _spatialized = false,_priority = 1,  _volume = 1, _volumeVariance = 0, _pitch = 1, _pitchVariance = 0){
	
	static _system = __AudioEngineSystem();
	
	with(_system) {	
		
		var _assetsList = [];
		for(var _i = 0; _i < array_length(_assets); _i++) {
			var _asset = _assets[_i];
			var _track = new __AESystemLibrarySoundTrack();
			_track.asset = _asset.asset;
			_track.isStream = is_string(_asset.asset);			
			
			array_push(_assetsList, _track)
		}		
		
		var _newGameSoundArray = new __AESystemLibrarySoundArray();
		
		_newGameSoundArray.assets = _assetsList;
		_newGameSoundArray.pitch = _pitch;
		_newGameSoundArray.pitchVariance = _pitchVariance;
		_newGameSoundArray.priority = _priority;
		_newGameSoundArray.spatialized = _spatialized;
		_newGameSoundArray.volume = _volume;
		_newGameSoundArray.volumeVariance = _volumeVariance;
		
		library.game[$ _uiSoundIndex] = _newGameSoundArray;
	}
}