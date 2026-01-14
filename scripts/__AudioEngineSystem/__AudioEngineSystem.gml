#macro __AUDIOENGINE_MANAGER_DEPTH  16002

#macro __AUDIOENGINE_VERSION  "1.0.0"
#macro __AUDIOENGINE_DATE     "2026-01-10"

#macro __AUDIOENGINE_PREFIX_MUSIC                "music"
#macro __AUDIOENGINE_PREFIX_UI                    "ui"
#macro __AUDIOENGINE_PREFIX_STATIC_GAME            "static"
#macro __AUDIOENGINE_PREFIX_SPATIALIZED_GAME    "spatial"

// If true, volume calculation will be added in verbose logs
#macro __AUDIOENGINE_DEBUG_VOLUME false

// If true, stream will be checked on run mode
#macro __AUDIOENGINE_DEBUG_CHECK_STREAM false

/// @desc Get the AudioEngine System
/// @private
/// @return {Struct.__AESystem} AudioEngine System struct
function __AudioEngineSystem() {
    static _system = undefined;

    if (_system != undefined) {
        // Feather ignore once GM1045
        return _system;
    }

    _system = new __AESystem();

    __AudioEngineConfig();

    __AESystemInitManager();

    _system.initialized = true;

    return _system;
}

/// @desc Initialize the AudioEngine Manager Object
/// @private
/// @return {Undefined}
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
/// @private
/// @return {Real} Unique id
function __AESystemUniqueId() {
    static counter = 0;

    counter++;

    return counter;
}

/// @desc Filter and return all the sounds from a category
/// @private
/// @param {String} _type Type of bus
/// @param {Enum.AE_CATEGORIES,Undefined} [_category] Optional category
/// @return {Array<Struct.__AESystemPlaying>} Filtered sounds
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

/// @desc Find an item in an array by property value
/// @private
/// @pure
/// @param {Array<Struct>} _array Array to search in
/// @param {String} _property Property name to check
/// @param {Any} _value Value to find
/// @return {Struct,Undefined} Found item or undefined if not found
function __AESystemFindInArray(_array, _property, _value) {
    var _length = array_length(_array);

    for(var _i = 0; _i < _length; _i++) {
        var _item = _array[_i];

        if(_item[$ _property] == _value) {
            return _item;
        }
    }

    return undefined;
}

/// @desc Find a sound in the playing array
/// @private
/// @param {Id.Sound} _ref Reference to the sound
/// @return {Struct.__AESystemPlaying,Undefined} Found sound struct or undefined if not found
function __AESystemFindSound(_ref) {
    static _system = __AudioEngineSystem();

    return _system.playingMap[$ _ref];
}

#region Types

/// @desc System Volumes
/// @private
/// @param {Real} [_music] Music volume
/// @param {Real} [_ui] UI volume
/// @param {Real} [_game] Game volume
/// @param {Real} [_gameSpatialized] Spatialized game volume
function __AESystemVolumes(_music = 1, _ui = 1, _game = 1, _gameSpatialized = 1 ) constructor {
    music = _music;
    ui = _ui;
    game = _game;
    gameSpatialized = _gameSpatialized;

}

/// @desc Currently Playing Sound
/// @private
/// @param {Asset.GMSound,String} [_asset] Sound asset
/// @param {Id.Sound} [_ref] Reference to the sound
/// @param {String} [_busName] bus name
/// @param {Bool} [_spatialized] The sound is spatialized
/// @param {Real} [_volume] The sound volume
function __AESystemPlaying(_asset = noone, _ref = noone, _busName = undefined, _spatialized = false, _volume = 1) constructor {
    asset = _asset;
    ref = _ref;
    busName = _busName;
    spatialized = _spatialized;
    volume = _volume;

}

/// @desc Single-Track Music Definition
/// @private
/// @param {Asset.GMSound,String} [_asset] Sound asset
/// @param {Real} [_volume] Initial volume
/// @param {Real} [_priority] Sound priority
/// @param {Bool} [_isStream] Indicate if the track is a stream
function __AESystemLibraryMusicSingle(_asset = noone, _volume = 1, _priority = 1, _isStream = false ) constructor {
    asset = _asset;
    volume = _volume;
    priority = _priority;
    multi = false;
    isStream = _isStream;
}

/// @desc Sound Track Definition
/// @private
/// @param {Asset.GMSound,String} _asset Sound asset
/// @param {Enum.AE_MULTITRACK_MOOD} _mood Music Mood
/// @param {Real} [_volume] Initial volume
/// @param {Bool} [_isStream] Indicate if the track is a stream
function __AESystemLibraryMusicTrack(_asset, _mood, _volume = 1, _isStream = false) constructor {
    asset = _asset;
    mood = _mood;
    volume = _volume;
    isStream = _isStream;
}

/// @desc Multi-Track Music Definition
/// @private
/// @param {Array<Struct.__AESystemLibraryMusicTrack>} [_assets] Array of music tracks
/// @param {Real} [_priority] Sound priority
function __AESystemLibraryMusicMulti(_assets = [], _priority = 1 ) constructor {
    assets = _assets;
    priority = _priority;
    multi = true;
}

/// @desc Sound Definition
/// @private
/// @param {Asset.GMSound,String} [_asset] Sound asset
/// @param {Real} [_volume] Initial volume
/// @param {Real} [_volumeVariance] Volume random variation
/// @param {Real} [_pitch] Initial pitch
/// @param {Real} [_pitchVariance] Pitch random variation
/// @param {Real} [_priority] Sound priority
/// @param {Bool} [_spatialized] Indicate if the sound is spatialized
/// @param {Bool} [_isStream] Indicate if the sound is a stream
/// @param {Bool} [_loop] Indicate if the sound is a loop
/// @param {Bool} [_cleanOnRoomEnd] Indicate if the sound should be cleaned on room end
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

/// @desc Sound Track Definition
/// @private
/// @param {Asset.GMSound,String} [_asset] Sound asset
/// @param {Bool} [_isStream] Indicate if the track is a stream
function __AESystemLibrarySoundTrack(_asset = noone, _isStream = false ) constructor {
    asset = _asset;
    isStream = _isStream;
}

/// @desc Sound Array Definition
/// @private
/// @param {Array<Struct.__AESystemLibrarySoundTrack>} [_assets] Array of sound tracks
/// @param {Real} [_volume] Initial volume
/// @param {Real} [_volumeVariance] Volume random variation
/// @param {Real} [_pitch] Initial pitch
/// @param {Real} [_pitchVariance] Pitch random variation
/// @param {Real} [_priority] Sound priority
/// @param {Bool} [_spatialized] Indicate if the sound is spatialized
/// @param {Bool} [_loop] Indicate if the sound is a loop
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
/// @private
/// @param {Array<Struct.__AESystemLibraryMusicSingle,Struct.__AESystemLibraryMusicMulti>} [_music] Music sound library
/// @param {Array<Struct.__AESystemLibrarySound,Struct.__AESystemLibrarySoundArray>} [_ui] UI sound library
/// @param {Array<Struct.__AESystemLibrarySound,Struct.__AESystemLibrarySoundArray>} [_game] Game sound library
function __AESystemLibrary(_music = {}, _ui = {}, _game = {} ) constructor {
    music = _music;
    ui = _ui;
    game = _game;
}

/// @desc System Position
/// @private
/// @param {Real} [_x] X position
/// @param {Real} [_y] Y position
/// @param {Real} [_z] Z position
function __AESystemPosition(_x = 0, _y = 0, _z = 0 ) constructor {
    x = _x;
    y = _y;
    z = _z;
}

/// @desc System
/// @private
/// @param {Struct.__AESystemVolumes} [_volumes] System volumes
/// @param {Struct} [_streams] Stream cache
/// @param {Array<Struct.__AESystemPlaying>} [_playing] List of currently played sounds
/// @param {Struct} [_bus] Bus definitions
/// @param {Struct} [_defaultBusVolumes] Default bus volumes
/// @param {Struct.__AEMusicCurrentMusic} [_currentMusics] Current musics
/// @param {Struct.__AESystemLibrary} [_library] Sound library
/// @param {Struct.__AESystemPosition} [_position] Listener position
/// @param {Struct} [_playingMap] Map of currently played sounds by reference
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

    initialized = false;

    audio_listener_position(_position.x, _position.y, _position.z);

    // Fix default inverted stereo
    audio_listener_orientation(0, 0, 1000, 0, -1 ,0);
}

#endregion
