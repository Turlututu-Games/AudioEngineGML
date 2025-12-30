#macro __AUDIOENGINE_MANAGER_DEPTH  16002

#macro __AUDIOENGINE_VERSION  "1.0.0"
#macro __AUDIOENGINE_DATE     "2025-12-29"

/// @desc Get the AudioEngine System
/// @return {Struct.__AESystem}
function __AudioEngineSystem() {
	static _system = undefined;
    
	if (_system != undefined) {
		return _system;
	}
	
	_system = new __AESystem();
	
	__AudioEngineConfig();
	
	__AudioEngineSystemInitManager();

	
	return _system;
}

/// @desc Initialize the AudioEngine Manager Object
function __AudioEngineSystemInitManager() {
	
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
	
	if(!__oAudioEngineManager.depth != __AUDIOENGINE_MANAGER_DEPTH) {
		__oAudioEngineManager.depth = __AUDIOENGINE_MANAGER_DEPTH;
	}
}

function __AudioEngineSystemUniqueId() {
    static counter = 0;
	
    counter++;
	
    return counter;
}

/// @desc Get a music library item
/// @param {Enum.AUDIO_MUSIC} _musicInstance
/// @return {Struct.__AESystemLibraryMusicSingle,Struct.__AESystemLibraryMusicMulti}
function __AudioEngineLibraryMusicGet(_musicInstance) {
	static _system = __AudioEngineSystem();
	
	return _system.library.music[$ _musicInstance];
}

/// @desc Get a ui sound library item
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundInstance
/// @return {Struct.__AESystemLibrarySound,Struct.__AESystemLibrarySoundArray}
function __AudioEngineLibraryUISoundGet(_uiSoundInstance) {
	static _system = __AudioEngineSystem();
	
	return _system.library.ui[$ _uiSoundInstance];
}

/// @desc Get a game sound library item
/// @param {Enum.AUDIO_GAME_SOUND} _gameSoundInstance
/// @return {Struct.__AESystemLibrarySound,Struct.__AESystemLibrarySoundArray}
function __AudioEngineLibraryGameSoundGet(_gameSoundInstance) {
	static _system = __AudioEngineSystem();
	
	return _system.library.game[$ _gameSoundInstance];
}

#region Types

/// @desc System Volumes
/// @param {Real} _music
/// @param {Real} _ui
/// @param {Real} _game
function __AESystemVolumes(_music = 1, _ui = 1, _game = 1 ) constructor {
	music = _music;
	ui = _ui;
	game = _game;
}

/// @param {Asset.GMSound,String} _asset
/// @param {Id.Sound} _ref Reference to the sound
/// @param {String} _busName bus name
/// @param {Bool} The sound is spatialized
function __AESystemPlaying(_asset = noone, _ref = noone, _busName = undefined, _spatialized = false ) constructor {
	asset = _asset;
	ref = _ref;
	busName = _busName;
	spatialized = _spatialized;
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
/// @param {Enum.AUDIO_MULTITRACK_MOOD} _mood Music Mood
/// @param {Real} _volume Initial volume
/// @param {Bool} _isStream Indicate if the track is a stream
function __AESystemLibraryMusicTrack(_asset = noone, _mood = 0, _volume = 1, _isStream = false) constructor {
	asset = _asset;
	mood = _mood;
	volume = _volume;
	isStream = _isStream;
}

/// @param {Array<Struct.__AESystemLibraryMusicTrack>} _assets
/// @param {Enum.AUDIO_MULTITRACK_MOOD} _mood Music Mood
/// @param {Real} _priority Sound priority
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
/// @param {Bool} _isStream Indicate if the sound is a stream
/// @param {Bool} _spatialized Indicate if the sound is spatialized
/// @param {Bool} _loop Indicate if the sound is a loop
function __AESystemLibrarySound(_asset = noone, _volume = 1,_volumeVariance = 0, _pitch = 1, _pitchVariance = 0, _priority = 1, _spatialized = false, _isStream = false, _loop = false ) constructor {
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
/// @param {Struct.__AEMusicCurrentMusic} _currentMusics
/// @param {Struct.__AESystemLibrary} _library
/// @param {Struct.__AESystemPosition} _position
function __AESystem(_volumes = new __AESystemVolumes(), _streams = {}, _playing = [], _bus = {}, _currentMusics = {}, _library = new __AESystemLibrary(), _position = new __AESystemPosition()) constructor {
	volumes = _volumes;
	streams = _streams;
	playing = _playing;
	bus = _bus;
	currentMusics = _currentMusics;
	library = _library;
	position = _position;
	
	audio_listener_position(_position.x, _position.y, _position.z);
	// Fix default inverted stereo
	audio_listener_orientation(0, 0, 1000, 0, -1 ,0);
}

#endregion
