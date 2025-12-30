/// Options for a single-track music
/// @param {Real} _priority Sound Priority
/// @param {Real} _volume Initial _volume
function AudioEngineDefineMusicOptions(_priority = 1, _volume = 1) constructor {
	priority = _priority;
	volume = _volume;
}

/// Define a single-track music
/// @param {Enum.AUDIO_MUSIC} _musicIndex
/// @param {Asset.GMSound,String} _asset
/// @param {Struct.AudioEngineDefineMusicOptions} [_options] Options
function AudioEngineDefineMusic(_musicIndex, _asset, _options = {}){
	
	static _system = __AudioEngineSystem();
	static _defaultOptions = new AudioEngineDefineMusicOptions();
	
	with(_system) {	
		var _newMusicSingle = new __AESystemLibraryMusicSingle();
		
		_newMusicSingle.asset = _asset;
		_newMusicSingle.volume = _options[$ "volume"] ?? _defaultOptions.volume;
		_newMusicSingle.priority = _options[$ "priority"] ?? _defaultOptions.priority;
		_newMusicSingle.isStream = is_string(_asset);
		
		library.music[$ _musicIndex] = _newMusicSingle;
	}
}

/// @param {Asset.GMSound,String} _asset
/// @param {Enum.AUDIO_MULTITRACK_MOOD} _mood Music Mood
/// @param {Real} _volume Initial volume
function AudioEngineDefineTrack(_asset, _mood = 0, _volume = 1) constructor {
	asset = _asset;
	mood = _mood;
	volume = _volume;
}

/// Options for a multi-track music
/// @param {Real} _priority Sound Priority
function AudioEngineDefineMultiTrackOptions(_priority = 1) constructor {
	priority = _priority;
}

/// Define a multi-track music
/// @param {Enum.AUDIO_MUSIC} _musicIndex
/// @param {Array<Struct.AudioEngineDefineTrack>} _tracks
/// @param {Struct.AudioEngineDefineMultiTrackOptions} [_options] Options
function AudioEngineDefineMultiTrackMusic(_musicIndex, _tracks, _options = {}){
	
	static _system = __AudioEngineSystem();
	static _defaultOptions = new AudioEngineDefineMultiTrackOptions();
	
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
		_newMusicMulti.priority = _options[$ "priority"] ?? _defaultOptions.priority;
		
		library.music[$ _musicIndex] = _newMusicMulti;
	}
}

/// Options for a UI sound
/// @param {Real} _priority Sound Priority
/// @param {Real} _volume Initial volume
/// @param {Real} _volumeVariance Random volume variance
/// @param {Real} _pitch Initial pitch
/// @param {Real} _pitchVariance Random pitch variance
function AudioEngineDefineUISoundOptions(_priority = 1, _volume = 1, _volumeVariance = 0, _pitch = 1, _pitchVariance = 0) constructor {
	priority = _priority;
	volume = _volume;
	volumeVariance = _volumeVariance;
	pitch = _pitch;
	pitchVariance = _pitchVariance;
}

/// Define a UI sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundIndex
/// @param {Asset.GMSound|String} _asset
/// @param {Struct.AudioEngineDefineUISoundOptions} [_options] Options
function AudioEngineDefineUISound(_uiSoundIndex, _asset, _options = {}){
	
	static _system = __AudioEngineSystem();
	static _defaultOptions = new AudioEngineDefineUISoundOptions();
	
	with(_system) {	
		
		var _newUISound = new __AESystemLibrarySound();
		
		_newUISound.asset = _asset;
		_newUISound.isStream = is_string(_asset);
		_newUISound.pitch = _options[$ "pitch"] ?? _defaultOptions.pitch;
		_newUISound.pitchVariance = _options[$ "pitchVariance"] ?? _defaultOptions.pitchVariance;
		_newUISound.priority = _options[$ "priority"] ?? _defaultOptions.priority;
		_newUISound.volume = _options[$ "volume"] ?? _defaultOptions.volume;
		_newUISound.volumeVariance = _options[$ "volumeVariance"] ?? _defaultOptions.volumeVariance;
		
		library.ui[$ _uiSoundIndex] = _newUISound;
	}
}

/// Define a UI sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundIndex
/// @param {Array<Asset.GMSound,String>} _assets
/// @param {Struct.AudioEngineDefineUISoundOptions} [_options] Options
function AudioEngineDefineUISoundArray(_uiSoundIndex, _assets, _options = {}){
	
	static _system = __AudioEngineSystem();
	static _defaultOptions = new AudioEngineDefineUISoundOptions();
	
	with(_system) {	
		
		var _assetsList = [];
		for(var _i = 0; _i < array_length(_assets); _i++) {
			var _asset = _assets[_i];
			var _track = new __AESystemLibrarySoundTrack();
			_track.asset = _asset;
			_track.isStream = is_string(_asset);
			
			array_push(_assetsList, _track)
		}		
		
		var _newUISoundArray = new __AESystemLibrarySoundArray();
		
		_newUISoundArray.assets = _assetsList;
		_newUISoundArray.pitch = _options[$ "pitch"] ?? _defaultOptions.pitch;
		_newUISoundArray.pitchVariance = _options[$ "pitchVariance"] ?? _defaultOptions.pitchVariance;
		_newUISoundArray.priority = _options[$ "priority"] ?? _defaultOptions.priority;
		_newUISoundArray.volume = _options[$ "volume"] ?? _defaultOptions.volume;
		_newUISoundArray.volumeVariance = _options[$ "volumeVariance"] ?? _defaultOptions.volumeVariance;
		
		
		library.ui[$ _uiSoundIndex] = _newUISoundArray;
	}
}

/// Options for a Game sound
/// @param {Bool} _loop Indicate if the sound is a loop
/// @param {Bool} _cleanOnRoomEnd The sound will be cleaned on room_end event
/// @param {Bool} _spatialized Indicate if the sound is spatialized
/// @param {Real} _priority Sound Priority
/// @param {Real} _volume Initial volume
/// @param {Real} _volumeVariance Random volume variance
/// @param {Real} _pitch Initial pitch
/// @param {Real} _pitchVariance Random pitch variance
function AudioEngineDefineGameSoundOptions(_loop = false, _cleanOnRoomEnd = true, _spatialized = false, _priority = 1, _volume = 1, _volumeVariance = 0, _pitch = 1, _pitchVariance = 0) constructor {
	loop = _loop;
	cleanOnRoomEnd = _cleanOnRoomEnd;
	spatialized = _spatialized;
	priority = _priority;
	volume = _volume;
	volumeVariance = _volumeVariance;
	pitch = _pitch;
	pitchVariance = _pitchVariance;
}

/// Define a Game sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundIndex
/// @param {Asset.GMSound|String} _asset
/// @param {Struct.AudioEngineDefineGameSoundOptions} [_options] Options
function AudioEngineDefineGameSound(_uiSoundIndex, _asset, _options = {}){
	
	static _system = __AudioEngineSystem();
	static _defaultOptions = new AudioEngineDefineGameSoundOptions();
	
	with(_system) {	
		
		var _newGameSound = new __AESystemLibrarySound();
		
		_newGameSound.asset = _asset;
		_newGameSound.isStream = is_string(_asset);
		_newGameSound.pitch = _options[$ "pitch"] ?? _defaultOptions.pitch;
		_newGameSound.pitchVariance = _options[$ "pitchVariance"] ?? _defaultOptions.pitchVariance;
		_newGameSound.priority = _options[$ "priority"] ?? _defaultOptions.priority;
		_newGameSound.volume = _options[$ "volume"] ?? _defaultOptions.volume;
		_newGameSound.volumeVariance = _options[$ "volumeVariance"] ?? _defaultOptions.volumeVariance;
		_newGameSound.spatialized = _options[$ "spatialized"] ?? _defaultOptions.spatialized;
		_newGameSound.loop = _options[$ "loop"] ?? _defaultOptions.loop;
		
		library.game[$ _uiSoundIndex] = _newGameSound;
	}
}

/// Define a UI sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundIndex
/// @param {Array<Asset.GMSound,String>} _assets
/// @param {Struct.AudioEngineDefineGameSoundOptions} [_options] Options
function AudioEngineDefineGameSoundArray(_uiSoundIndex, _assets, _options = {}){
	
	static _system = __AudioEngineSystem();
	static _defaultOptions = new AudioEngineDefineGameSoundOptions();
	
	with(_system) {	
		
		var _assetsList = [];
		for(var _i = 0; _i < array_length(_assets); _i++) {
			var _asset = _assets[_i];
			var _track = new __AESystemLibrarySoundTrack();
			_track.asset = _asset;
			_track.isStream = is_string(_asset);			
			
			array_push(_assetsList, _track)
		}		
		
		var _newGameSoundArray = new __AESystemLibrarySoundArray();
		
		_newGameSoundArray.assets = _assetsList;
		_newGameSoundArray.pitch = _options[$ "pitch"] ?? _defaultOptions.pitch;
		_newGameSoundArray.pitchVariance = _options[$ "pitchVariance"] ?? _defaultOptions.pitchVariance;
		_newGameSoundArray.priority = _options[$ "priority"] ?? _defaultOptions.priority;
		_newGameSoundArray.volume = _options[$ "volume"] ?? _defaultOptions.volume;
		_newGameSoundArray.volumeVariance = _options[$ "volumeVariance"] ?? _defaultOptions.volumeVariance;
		_newGameSoundArray.spatialized = _options[$ "spatialized"] ?? _defaultOptions.spatialized;
		_newGameSoundArray.loop = _options[$ "loop"] ?? _defaultOptions.loop;
		
		library.game[$ _uiSoundIndex] = _newGameSoundArray;
	}
}