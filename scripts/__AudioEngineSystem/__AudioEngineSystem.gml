#macro __AUDIOENGINE_MANAGER_DEPTH  16002

#macro __AUDIOENGINE_VERSION  "1.0.0"
#macro __AUDIOENGINE_DATE     "2026-01-10"

#macro __AUDIOENGINE_PREFIX_MUSIC				"music"
#macro __AUDIOENGINE_PREFIX_UI					"ui"
#macro __AUDIOENGINE_PREFIX_STATIC_GAME			"static"
#macro __AUDIOENGINE_PREFIX_SPATIALIZED_GAME    "spatial"

// If true, volume calculation will be added in verbose logs
#macro __AUDIOENGINE_DEBUG_VOLUME false

// If true, stream will be checked on run mode
#macro __AUDIOENGINE_DEBUG_CHECK_STREAM false


/// @desc Get the AudioEngine System
/// @return {Struct.__AESystem}
function __AudioEngineSystem() {
	static _system = undefined;
    
	if (_system != undefined) {
		// Feather ignore once GM1045
		return _system;
	}
	
	_system = new __AESystem();
	
	__AudioEngineConfig();
	
	__AESystemInitManager();

	
	return _system;
}

/// @desc Initialize the AudioEngine Manager Object
function __AESystemInitManager() {
	
	var _exists = true;
	
	if(!instance_exists(__oAudioEngineManager)) {
		
		instance_activate_object(__oAudioEngineManager);
		
		if(!instance_exists(__oAudioEngineManager)) {
		
			instance_create_depth(0, -__AUDIOENGINE_MANAGER_DEPTH, __AUDIOENGINE_MANAGER_DEPTH, __oAudioEngineManager);
		
		}
	}
	
	if (!__oAudioEngineManager.persistent) {
		__oAudioEngineManager.persistent = true;
    }	
	
	if(__oAudioEngineManager.depth != __AUDIOENGINE_MANAGER_DEPTH) {
		__oAudioEngineManager.depth = __AUDIOENGINE_MANAGER_DEPTH;
	}
}

/// @desc Get an auto-incremented id
function __AESystemUniqueId() {
    static counter = 0;
	
    counter++;
	
    return counter;
}


/// @desc Filter and return all the sounds from a category
/// @param {String} _type
/// @param {Enum.AE_CATEGORIES,Undefined} _category
/// @return {Array<Struct.__AESystemPlaying>}
function __AESystemFilterSoundByTypeAndCategory(_type, _category = undefined) {
	static _system = __AudioEngineSystem();
			
	var _playingLength = array_length(_system.playing);
	
	var _term = is_undefined(_category) ? $"{_type}-" : $"{_type}-{_category}"
	
	var _filtered = [];
	
	for(var _i = 0; _i < _playingLength; _i++) {
		var _playing = _system.playing[_i];
		
		// Feather ignore once GM1041
		if(string_starts_with(_playing.busName, _term) ) {
			array_push(_filtered, _playing)
		}
	}
	
	return _filtered
}

/// @desc Find a sound in the playing array
/// @param {Id.Sound} _ref
/// @return {Struct.__AESystemPlaying,Undefined}
function __AESystemFindSound(_ref) {
	static _system = __AudioEngineSystem();
			
	return _system.playingMap[$ _ref];
}

#region Types

/// @desc System Volumes
/// @param {Real} _music
/// @param {Real} _ui
/// @param {Real} _game
function __AESystemVolumes(_music = 1, _ui = 1, _game = 1, _gameSpatialized = 1 ) constructor {
	music = _music;
	ui = _ui;
	game = _game;	
	gameSpatialized = _gameSpatialized;

}

/// @param {Asset.GMSound,String} _asset
/// @param {Id.Sound} _ref Reference to the sound
/// @param {String} _busName bus name
/// @param {Bool} _spatialized The sound is spatialized
/// @param {Real} _volume The sound volume
function __AESystemPlaying(_asset = noone, _ref = noone, _busName = undefined, _spatialized = false, _volume = 1) constructor {
	asset = _asset;
	ref = _ref;
	busName = _busName;
	spatialized = _spatialized;	
	volume = _volume;

}


/// @param {Asset.GMSound,String} _asset
/// @param {Real} _volume Initial volume
/// @param {Real} _priority Sound priority
/// @param {Bool} _isStream Indicate if the track is a stream
function __AESystemLibraryMusicSingle(_asset = noone, _volume = 1, _priority = 1, _isStream = false ) constructor {
	asset = _asset;
	volume = _volume;
	priority = _priority;
	multi = false;
	isStream = _isStream;
}

/// @param {Asset.GMSound,String} _asset
/// @param {Enum.AE_MULTITRACK_MOOD} _mood Music Mood
/// @param {Real} _volume Initial volume
/// @param {Bool} _isStream Indicate if the track is a stream
function __AESystemLibraryMusicTrack(_asset, _mood, _volume = 1, _isStream = false) constructor {
	asset = _asset;
	mood = _mood;
	volume = _volume;
	isStream = _isStream;
}

/// @param {Array<Struct.__AESystemLibraryMusicTrack>} [_assets]
/// @param {Real} [_priority] Sound priority
function __AESystemLibraryMusicMulti(_assets = [], _priority = 1 ) constructor {
	assets = _assets;
	priority = _priority;
	multi = true;
}

/// @param {Asset.GMSound,String} _asset
/// @param {Real} _volume Initial volume
/// @param {Real} _volumeVariance Volume random variation
/// @param {Real} _pitch Initial pitch
/// @param {Real} _pitchVariance Pitch random variation
/// @param {Real} _priority Sound priority
/// @param {Bool} _spatialized Indicate if the sound is spatialized
/// @param {Bool} _isStream Indicate if the sound is a stream
/// @param {Bool} _loop Indicate if the sound is a loop
function __AESystemLibrarySound(_asset = noone, _volume = 1,_volumeVariance = 0, _pitch = 1, _pitchVariance = 0, _priority = 1, _spatialized = false, _isStream = false, _loop = false, _cleanOnRoomEnd = false ) constructor {
	asset = _asset;
	volume = _volume;
	volumeVariance = _volumeVariance;
	pitch = _pitch;
	pitchVariance = _pitchVariance;	
	priority = _priority;
	multi = false;
	isStream = _isStream;
	spatialized = _spatialized;
	loop = _loop;
	cleanOnRoomEnd = _cleanOnRoomEnd;
}

/// @param {Asset.GMSound,String} _asset
/// @param {Bool} _isStream Indicate if the track is a stream
function __AESystemLibrarySoundTrack(_asset = noone, _isStream = false ) constructor {
	asset = _asset;
	isStream = _isStream;
}

/// @param {Array<Struct.__AESystemLibrarySoundTrack>} _assets
/// @param {Real} _volume Initial volume
/// @param {Real} _volumeVariance Volume random variation
/// @param {Real} _pitch Initial pitch
/// @param {Real} _pitchVariance Pitch random variation
/// @param {Real} _priority Sound priority
/// @param {Bool} _spatialized Indicate if the sound is spatialized
/// @param {Bool} _loop Indicate if the sound is a loop
function __AESystemLibrarySoundArray(_assets = [], _volume = 1,_volumeVariance = 0, _pitch = 1, _pitchVariance = 0, _priority = 1, _spatialized = false, _loop = false) constructor {
	assets = _assets;
	volume = _volume;
	volumeVariance = _volumeVariance;
	pitch = _pitch;
	pitchVariance = _pitchVariance;	
	priority = _priority;
	multi = true;
	spatialized = _spatialized;
	loop = _loop;
}

/// @desc System Libraries
/// @param {Array<Struct.__AESystemLibraryMusicSingle,Struct.__AESystemLibraryMusicMulti>} _music
/// @param {Array<Struct.__AESystemLibrarySound,Struct.__AESystemLibrarySoundArray>} _ui
/// @param {Array<Struct.__AESystemLibrarySound,Struct.__AESystemLibrarySoundArray>} _game
function __AESystemLibrary(_music = {}, _ui = {}, _game = {} ) constructor {
	music = _music;
	ui = _ui;
	game = _game;
}

/// @desc System Position
/// @param {Real} _x
/// @param {Real} _y
/// @param {Real} _z
function __AESystemPosition(_x = 0, _y = 0, _z = 0 ) constructor {
	x = _x;
	y = _y;
	z = _z;
}

/// @desc System
/// @param {Struct.__AESystemVolumes} _volumes
/// @param {Struct} _streams Stream cache
/// @param {Array<Struct.__AESystemPlaying>} _playing List of currently played sounds
/// @param {Struct} _bus
/// @param {Struct} _defaultBusVolumes
/// @param {Struct.__AEMusicCurrentMusic} _currentMusics
/// @param {Struct.__AESystemLibrary} _library
/// @param {Struct.__AESystemPosition} _position
/// @param {Struct} _playingMap
function __AESystem(_volumes = new __AESystemVolumes(), _streams = {}, _playing = [], _bus = {}, _defaultBusVolumes = {}, _currentMusics = {}, _library = new __AESystemLibrary(), _position = new __AESystemPosition(), _playingMap = {}) constructor {
	volumes = _volumes;
	streams = _streams;
	playing = _playing;
	bus = _bus;
	defaultBusVolumes = _defaultBusVolumes;
	currentMusics = _currentMusics;
	library = _library;
	position = _position;
	playingMap = _playingMap;
	
	audio_listener_position(_position.x, _position.y, _position.z);
	
	// Fix default inverted stereo
	audio_listener_orientation(0, 0, 1000, 0, -1 ,0);
}

#endregion
