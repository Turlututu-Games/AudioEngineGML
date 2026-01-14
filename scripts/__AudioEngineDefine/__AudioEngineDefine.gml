/// @desc Options for a single-track music
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineMusicOptions
/// @param {Real} [_priority] Sound Priority. Must be between 0 and 100. Lower is higher priority
/// @param {Real} [_volume] Initial volume. Must be between 0 and 1
function AudioEngineDefineMusicOptions(_priority = 1, _volume = 1) constructor {
    priority = _priority;
    volume = _volume;
}

/// @desc Define a single-track music
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineMusic
/// @example AudioEngineDefineMusic(AE_MUSIC.DECORATE, Interior_Birdecorator_Decorate, {volume: 0.8});
/// @param {Enum.AE_MUSIC} _musicIndex Music index
/// @param {Asset.GMSound,String} _asset Sound asset
/// @param {Struct.AudioEngineDefineMusicOptions} [_options] Options
/// @return {Undefined}
function AudioEngineDefineMusic(_musicIndex, _asset, _options = {}){

    static _system = __AudioEngineSystem();
    static _defaultOptions = new AudioEngineDefineMusicOptions();

    if(_system.initialized) {
         __AELogError("define function cannot be called after initialization");
         return;
    }

    if(!__AEDefineCheckOptionsValid(_options, [
        { name: "priority", type: OptionCheckType.Real, minValue: 0, maxValue: 100 },
        { name: "volume", type: OptionCheckType.Real, minValue: 0, maxValue: 1 }
    ])) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_options, "is not valid");
        return;
    }

    if(!__AEDefineCheckAssetValid(_asset)) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_asset, "is not valid");
        return;
    }

    if(!__AEDefineCheckIdValid(_musicIndex)) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_musicIndex, "is not valid");
        return;
    }

    with(_system) {
        var _newMusicSingle = new __AESystemLibraryMusicSingle();

        _newMusicSingle.asset = _asset;
        _newMusicSingle.volume = _options[$ "volume"] ?? _defaultOptions.volume;
        _newMusicSingle.priority = _options[$ "priority"] ?? _defaultOptions.priority;
        _newMusicSingle.isStream = is_string(_asset);

        library.music[$ _musicIndex] = _newMusicSingle;
    }
}

/// @desc Define a track for multi-track music
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineTrack
/// @param {Asset.GMSound,String} _asset Sound asset
/// @param {Enum.AE_MULTITRACK_MOOD} _mood Music Mood
/// @param {Real} [_volume] Initial volume
function AudioEngineDefineTrack(_asset, _mood, _volume = 1) constructor {
    asset = _asset;
    mood = _mood;
    volume = _volume;
}

/// @desc Options for a multi-track music
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineMultiTrackOptions
/// @param {Real} [_priority] Sound Priority
function AudioEngineDefineMultiTrackOptions(_priority = 1) constructor {
    priority = _priority;
}

/// @desc Define a multi-track music
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineMultiTrackMusic
/// @param {Enum.AE_MUSIC} _musicIndex Music index
/// @param {Array<Struct.AudioEngineDefineTrack>} _tracks Array of tracks
/// @param {Struct.AudioEngineDefineMultiTrackOptions} [_options] Options
/// @return {Undefined}
function AudioEngineDefineMultiTrackMusic(_musicIndex, _tracks, _options = {}){

    static _system = __AudioEngineSystem();
    static _defaultOptions = new AudioEngineDefineMultiTrackOptions();

    if(_system.initialized) {
         __AELogError("define function cannot be called after initialization");
         return;
    }

    if(!__AEDefineCheckOptionsValid(_options, [
        { name: "priority", type: OptionCheckType.Real, minValue: 0, maxValue: 100 }
    ])) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_options, "is not valid");
        return;
    }

    if(!__AEDefineCheckIdValid(_musicIndex)) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_musicIndex, "is not valid");
        return;
    }

    with(_system) {

        var _assets = [];
        for(var _i = 0; _i < array_length(_tracks); _i++) {
            var _track = _tracks[_i];

            if(!__AEDefineCheckAssetValid(_track.asset)) {
                // Feather ignore once GM1019 Ignore invalid type error
                __AELogError(_track.asset, "is not valid");
                continue;
            }

            if(!__AEDefineCheckIdValid(_track.mood)) {
                // Feather ignore once GM1019 Ignore invalid type error
                __AELogError(_track.mood, "is not valid");
                continue;
            }

            if(!__AEDefineCheckVolumeValid(_track.volume)) {
                // Feather ignore once GM1019 Ignore invalid type error
                __AELogError(_track.volume, "is not valid");
                continue;
            }

            // Feather ignore once GM1041
            var _newMusicTrack = new __AESystemLibraryMusicTrack(_track.asset, _track.mood);
            _newMusicTrack.isStream = is_string(_track.asset);
            _newMusicTrack.volume = _track.volume;

            _assets[@ _track.mood] = _newMusicTrack;
        }

        var _newMusicMulti = new __AESystemLibraryMusicMulti();

        _newMusicMulti.assets = _assets;
        _newMusicMulti.priority = _options[$ "priority"] ?? _defaultOptions.priority;

        library.music[$ _musicIndex] = _newMusicMulti;
    }
}

/// @desc Options for a UI sound
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineUISoundOptions
/// @param {Real} [_priority] Sound Priority
/// @param {Real} [_volume] Initial volume
/// @param {Real} [_volumeVariance] Random volume variance
/// @param {Real} [_pitch] Initial pitch
/// @param {Real} [_pitchVariance] Random pitch variance
function AudioEngineDefineUISoundOptions(_priority = 1, _volume = 1, _volumeVariance = 0, _pitch = 1, _pitchVariance = 0) constructor {
    priority = _priority;
    volume = _volume;
    volumeVariance = _volumeVariance;
    pitch = _pitch;
    pitchVariance = _pitchVariance;
}

/// @desc Define a UI sound
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineUISound
/// @param {Enum.AE_UI_SOUND} _uiSoundIndex UI sound index
/// @param {Asset.GMSound,String} _asset Sound asset
/// @param {Struct.AudioEngineDefineUISoundOptions} [_options] Options
/// @return {Undefined}
function AudioEngineDefineUISound(_uiSoundIndex, _asset, _options = {}){

    static _system = __AudioEngineSystem();
    static _defaultOptions = new AudioEngineDefineUISoundOptions();

    if(_system.initialized) {
         __AELogError("define function cannot be called after initialization");
         return;
    }

    if(!__AEDefineCheckOptionsValid(_options, [
        { name: "priority", type: OptionCheckType.Real, minValue: 0, maxValue: 100 },
        { name: "volume", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "volumeVariance", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "pitch", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "pitchVariance", type: OptionCheckType.Real, minValue: 0, maxValue: 1 }
    ])) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_options, "is not valid");
        return;
    }

    if(!__AEDefineCheckAssetValid(_asset)) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_asset, "is not valid");
        return;
    }

    if(!__AEDefineCheckIdValid(_uiSoundIndex)) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_uiSoundIndex, "is not valid");
        return;
    }

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

/// @desc Define a UI sound
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineUISoundArray
/// @param {Enum.AE_UI_SOUND} _uiSoundIndex UI sound index
/// @param {Array<Asset.GMSound,String>} _assets Array of sound assets
/// @param {Struct.AudioEngineDefineUISoundOptions} [_options] Options
/// @return {Undefined}
function AudioEngineDefineUISoundArray(_uiSoundIndex, _assets, _options = {}) {

    static _system = __AudioEngineSystem();
    static _defaultOptions = new AudioEngineDefineUISoundOptions();

    if(_system.initialized) {
         __AELogError("define function cannot be called after initialization");
         return;
    }

    if(!__AEDefineCheckOptionsValid(_options, [
        { name: "priority", type: OptionCheckType.Real, minValue: 0, maxValue: 100 },
        { name: "volume", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "volumeVariance", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "pitch", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "pitchVariance", type: OptionCheckType.Real, minValue: 0, maxValue: 1 }
    ])) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_options, "is not valid");
        return;
    }

    if(!__AEDefineCheckIdValid(_uiSoundIndex)) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_uiSoundIndex, "is not valid");
        return;
    }

    with(_system) {

        var _assetsList = [];
        for(var _i = 0; _i < array_length(_assets); _i++) {
            var _asset = _assets[_i];

            if(!__AEDefineCheckAssetValid(_asset)) {
                // Feather ignore once GM1019 Ignore invalid type error
                __AELogError(_asset, "is not valid");
                continue;
            }

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

/// @desc Options for a Game sound
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineGameSoundOptions
/// @param {Bool} [_loop] Indicate if the sound is a loop
/// @param {Bool} [_cleanOnRoomEnd] The sound will be cleaned on room_end event
/// @param {Bool} [_spatialized] Indicate if the sound is spatialized
/// @param {Real} [_priority] Sound Priority
/// @param {Real} [_volume] Initial volume
/// @param {Real} [_volumeVariance] Random volume variance
/// @param {Real} [_pitch] Initial pitch
/// @param {Real} [_pitchVariance] Random pitch variance
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

/// @desc Define a Game sound
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineGameSound
/// @param {Enum.AE_GAME_SOUND} _gameSoundIndex Game sound index
/// @param {Asset.GMSound|String} _asset Sound asset
/// @param {Struct.AudioEngineDefineGameSoundOptions} [_options] Options
/// @return {Undefined}
function AudioEngineDefineGameSound(_gameSoundIndex, _asset, _options = {}){

    static _system = __AudioEngineSystem();
    static _defaultOptions = new AudioEngineDefineGameSoundOptions();

    if(_system.initialized) {
         __AELogError("define function cannot be called after initialization");
         return;
    }

    if(!__AEDefineCheckOptionsValid(_options, [
        { name: "priority", type: OptionCheckType.Real, minValue: 0, maxValue: 100 },
        { name: "volume", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "volumeVariance", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "pitch", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "pitchVariance", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "spatialized", type: OptionCheckType.Boolean },
        { name: "loop", type: OptionCheckType.Boolean },
        { name: "cleanOnRoomEnd", type: OptionCheckType.Boolean }
    ])) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_options, "is not valid");
        return;
    }

    if(!__AEDefineCheckAssetValid(_asset)) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_asset, "is not valid");
        return;
    }

    if(!__AEDefineCheckIdValid(_gameSoundIndex)) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_gameSoundIndex, "is not valid");
        return;
    }

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
        _newGameSound.cleanOnRoomEnd = _options[$ "cleanOnRoomEnd"] ?? _defaultOptions.cleanOnRoomEnd;

        library.game[$ _gameSoundIndex] = _newGameSound;
    }
}

/// @desc Define a Game sound
/// @module Configuration
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Configuration?id=AudioEngineDefineGameSoundArray
/// @param {Enum.AE_GAME_SOUND} _gameSoundIndex Game sound index
/// @param {Array<Asset.GMSound,String>} _assets Array of sound assets
/// @param {Struct.AudioEngineDefineGameSoundOptions} [_options] Options
/// @return {Undefined}
function AudioEngineDefineGameSoundArray(_gameSoundIndex, _assets, _options = {}){

    static _system = __AudioEngineSystem();
    static _defaultOptions = new AudioEngineDefineGameSoundOptions();

    if(_system.initialized) {
         __AELogError("define function cannot be called after initialization");
         return;
    }

    if(!__AEDefineCheckOptionsValid(_options, [
        { name: "priority", type: OptionCheckType.Real, minValue: 0, maxValue: 100 },
        { name: "volume", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "volumeVariance", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "pitch", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "pitchVariance", type: OptionCheckType.Real, minValue: 0, maxValue: 1 },
        { name: "spatialized", type: OptionCheckType.Boolean },
        { name: "loop", type: OptionCheckType.Boolean },
        { name: "cleanOnRoomEnd", type: OptionCheckType.Boolean }
    ])) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_options, "is not valid");
        return;
    }

    if(!__AEDefineCheckIdValid(_gameSoundIndex)) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError(_gameSoundIndex, "is not valid");
        return;
    }

    with(_system) {

        var _assetsList = [];
        for(var _i = 0; _i < array_length(_assets); _i++) {
            var _asset = _assets[_i];

            if(!__AEDefineCheckAssetValid(_asset)) {
                // Feather ignore once GM1019 Ignore invalid type error
                __AELogError(_asset, "is not valid");
                continue;
            }

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

        library.game[$ _gameSoundIndex] = _newGameSoundArray;
    }
}

enum OptionCheckType {
    Real = 0,
    Boolean = 1,
    String = 2
}

/// @desc Option to check
/// @private
/// @param {String} _name Name of the option
/// @param {Enum.OptionCheckType} _type Type of the option
/// @param {Real} [_maxValue] Maximum value (for Real type)
/// @param {Real} [_minValue] Minimum value (for Real type)
function __AEDefineOptionCheck(_name, _type, _maxValue = 1, _minValue = 0) constructor {
    name = _name;
    type = _type;
    maxValue = _maxValue;
    minValue = _minValue;
}

/// @desc Check if an asset is valid. Only executed in "run" mode (development)
/// @private
/// @param {Struct} _options Options to check
/// @param {Array<Struct.__AEDefineOptionCheck>} _list List of valid options
/// @return {Bool} True if valid, false otherwise
function __AEDefineCheckOptionsValid(_options, _list) {
    if(GM_build_type == "exe") {
        // No check on production
        return true;
    }

    try {
        var _optionsKeys = struct_get_names(_options);

        var _errors = false;

        for(var _i = 0; _i < array_length(_optionsKeys); _i++) {
            var _optionKey = _optionsKeys[_i];
            var _option = _options[$ _optionKey];

            var _foundOption = __AESystemFindInArray(_list, "name", _optionKey);

            if(!_foundOption) {
                __AELogWarning(_optionKey, "is not a valid option");
                _errors = true;
            } else {

                switch(_foundOption.type) {
                    case OptionCheckType.Boolean:
                        if(!is_bool(_option)) {
                            _errors = true;
                            __AELogWarning(_optionKey, "is not a valid boolean value");
                        }
                        break;
                    case OptionCheckType.String:
                        if(!is_string(_option)) {
                            _errors = true;
                            __AELogWarning(_optionKey, "is not a valid string value");
                        }
                        break;
                    case OptionCheckType.Real:
                        if(!is_real(_option)) {
                            _errors = true;
                            __AELogWarning(_optionKey, "is not a valid real value");
                        }
                        if(_option < _foundOption.minValue) {
                            _errors = true;
                            __AELogWarning(_optionKey, "is less than minimum value of", _foundOption.minValue);
                        }
                        if(_option > _foundOption.maxValue) {
                            _errors = true;
                            __AELogWarning(_optionKey, "is greater than maximum value of", _foundOption.maxValue);
                        }
                        break;

                }

            }
        }

        return !_errors;
    } catch(_exception) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogWarning(_options, "Option validation failed:", _exception.message);

        return false;
    }
}

/// @desc Check if an asset is valid. Only executed in "run" mode (development)
/// @private
/// @param {Asset.GMSound,String} _asset Asset to check
/// @return {Bool} True if valid, false otherwise
function __AEDefineCheckAssetValid(_asset) {
    if(GM_build_type == "exe") {
        // No check on production
        return true;
    }

    try {

        if(is_undefined(_asset)) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_asset, "is undefined");
            return false;
        }

        if(is_string(_asset)) {
            // check validity of the stream asset
            return __AEDefineCheckAssetStreamValid(_asset);
        }

        if(!is_handle(_asset)) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_asset, "is not a handle");
            return false;
        }

        if(!audio_exists(_asset)) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_asset, "is not a audio asset");
            return false;
        }

        if(audio_get_type(_asset) != 0) {

            audio_destroy_stream(_asset);

            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_asset, "is not a audio asset");
            return false;
        }

        return true;
    } catch(_exception) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogWarning(_asset, "Asset validation failed:", _exception.message);

        return false;
    }
}

/// @desc Check if an stream asset is valid.
/// @private
/// @param {String} _asset Path to the stream asset
/// @return {Bool} True if valid, false otherwise
function __AEDefineCheckAssetStreamValid(_asset) {

    var _cleanupStream;

    try {

        if(!file_exists(_asset)) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_asset, "does not exists");
            return false
        }

        if(!__AUDIOENGINE_DEBUG_CHECK_STREAM) {
            return true;
        }

        _cleanupStream = audio_create_stream(_asset);

        if(!is_handle(_cleanupStream)) {

            audio_destroy_stream(_cleanupStream);

            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_asset, "stream is not a handle");
            return false;
        }

        if(!audio_exists(_cleanupStream)) {

            audio_destroy_stream(_cleanupStream);

            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_asset, "stream is not a audio asset");
            return false;
        }

        if(audio_get_type(_cleanupStream) != 1) {

            audio_destroy_stream(_cleanupStream);

            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_asset, "stream is not a audio asset");
            return false;
        }

        audio_destroy_stream(_cleanupStream);

        return true;
    } catch(_exception) {

        if(_cleanupStream != undefined) {
            audio_destroy_stream(_cleanupStream);
        }

        // Feather ignore once GM1019 Ignore invalid type error
        __AELogWarning(_asset, "Stream Asset validation failed:", _exception.message);

        return false;
    }
}

/// @desc Check if an id is valid. Only executed in "run" mode (development)
/// @private
/// @param {Real} _id Id to check
/// @return {Bool} True if valid, false otherwise
function __AEDefineCheckIdValid(_id) {
    if(GM_build_type == "exe") {
        // No check on production
        return true;
    }

    try {
        if(is_undefined(_id)) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_id, "is undefined");
            return false;
        }

        if(!is_numeric(_id)) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_id, "is not a number");
            return false;
        }

        if(_id < 0) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_id, "is negative");
            return false;
        }

        return true
    } catch(_exception) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogWarning(_id, "Id validation failed:", _exception.message);

        return false;
    }
}

/// @desc Check if a volume value is valid. Only executed in "run" mode (development)
/// @private
/// @param {Real} _volume Volume to check
/// @return {Bool} True if valid, false otherwise
function __AEDefineCheckVolumeValid(_volume) {
    if(GM_build_type == "exe") {
        // No check on production
        return true;
    }

    try {
        if(is_undefined(_volume)) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_volume, "is undefined");
            return false;
        }

        if(!is_numeric(_volume)) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_volume, "is not a number");
            return false;
        }

        if(_volume < 0) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_volume, "is negative");
            return false;
        }

        if(_volume > 1) {
            // Feather ignore once GM1019 Ignore invalid type error
            __AELogWarning(_volume, "is greater than 1");
            return false;
        }

        return true
    } catch(_exception) {
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogWarning(_volume, "Volume validation failed:", _exception.message);

        return false;
    }
}