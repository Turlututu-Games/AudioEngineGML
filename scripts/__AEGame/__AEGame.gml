/// @desc Play a game sound
/// @param {Enum.AE_GAME_SOUND} _gameSoundInstance Sound key
/// @param {Enum.AE_CATEGORIES,Real} _id Id for the category or position
/// @param {Real} _x X position
/// @param {Real} _y Y position
/// @param {Real} _z Z position
/// @param {Real} _volumeOffset Volume offset
/// @param {Real} _pitchOffset Pitch offset
/// @param {Array<Struct.AudioEffect>} _effects Audio effects to apply
/// @return {Struct.__AESystemPlaying,Undefined} Sound reference
function __AEGamePlay(_gameSoundInstance, _id, _x, _y, _z, _volumeOffset, _pitchOffset, _effects) {
    static _system = __AudioEngineSystem();

    // Feather ignore once GM1041 The enum value is correct
    var _newSound = __AEGameLibraryGetSound(_gameSoundInstance);

    if(!_newSound) {
        // The sound does not exists! Log it
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError($"Invalid game sound id: {_gameSoundInstance}");
        return;
    }

    var _busType = __AUDIOENGINE_PREFIX_STATIC_GAME;

    if(_newSound.spatialized) {
        _busType = __AUDIOENGINE_PREFIX_SPATIALIZED_GAME
    }

    var _busName = $"{_busType}-{_id}"
    var _bus = __AEBusGet(_busType, _id, _newSound.cleanOnRoomEnd);

    if(_newSound.spatialized) {
        audio_emitter_position(_bus.emitter, _x, _y, _z);
    }

    if(array_length(_effects) > 0) {
        __AEBusEffectsSet(_effects, _busName);
    }

    if(_newSound.multi) {
        return __AEGamePlayMulti(_volumeOffset, _pitchOffset, _newSound, _bus, _busName);
    }

    return __AEGamePlaySingle(_volumeOffset, _pitchOffset, _newSound, _bus, _busName);

}

/// @desc Play a game sound from an array
/// @param {Real} _volumeOffset Volume offset
/// @param {Real} _pitchOffset Pitch offset
/// @param {Struct.__AESystemLibrarySoundArray} _newSound Sound to play
/// @param {Struct.__AEBus} _bus Bus to play the sound on
/// @param {String} _prefix Bus prefix
/// @return {Struct.__AESystemPlaying} Sound reference
function __AEGamePlayMulti(_volumeOffset, _pitchOffset, _newSound, _bus, _prefix) {
    static _system = __AudioEngineSystem();

    var _index = irandom_range(0, array_length(_newSound.assets) - 1);
    var _selectedAsset = _newSound.assets[_index];
    var _sound = __AEStreamReturnAsset(_selectedAsset);

    // Feather ignore once GM1041 The enum value is correct
    var _volume = __AEGameResolveVolume(_bus.category, _newSound, _bus)

    var _ref = __AEGamePlaySound(_sound, _bus, _newSound.loop, _volume, _newSound.pitch, _newSound.volumeVariance, _newSound.pitchVariance, _volumeOffset, _pitchOffset, _newSound.priority);

    var _playing = new __AESystemPlaying(_selectedAsset.asset, _ref, _prefix, _newSound.spatialized, _newSound.volume);

    _system.playingMap[$ _ref] = _playing;
    array_push(_system.playing, _playing);

    return _playing;

}

/// @desc Play a game sound from an single track
/// @param {Real} _volumeOffset Volume offset
/// @param {Real} _pitchOffset Pitch offset
/// @param {Struct.__AESystemLibrarySound} _newSound Sound to play
/// @param {Struct.__AEBus} _bus Bus to play the sound on
/// @param {String} _prefix Bus prefix
/// @return {Struct.__AESystemPlaying} Sound reference
function __AEGamePlaySingle(_volumeOffset, _pitchOffset, _newSound, _bus, _prefix) {
    static _system = __AudioEngineSystem();

    var _sound = __AEStreamReturnAsset(_newSound);

    // Feather ignore once GM1041 The enum value is correct
    var _volume = __AEGameResolveVolume(_bus.category, _newSound, _bus)

    var _ref = __AEGamePlaySound(_sound, _bus, _newSound.loop, _volume, _newSound.pitch, _newSound.volumeVariance, _newSound.pitchVariance, _volumeOffset, _pitchOffset, _newSound.priority);

    var _playing = new __AESystemPlaying(_newSound.asset, _ref, _prefix, _newSound.spatialized, _newSound.volume);

    _system.playingMap[$ _ref] = _playing;
    array_push(_system.playing, _playing);

    return _playing;
}

/// @desc Play the prepared sound
/// @param {Asset.GMSound} _sound Sound asset
/// @param {Struct.__AEBus} _bus Bus to play the sound on
/// @param {Bool} _loop Loop the sound
/// @param {Real} _volume Volume
/// @param {Real} _pitch Pitch
/// @param {Real} _volumeVariance Volume variance
/// @param {Real} _pitchVariance Pitch variance
/// @param {Real} _volumeOffset Volume offset
/// @param {Real} _pitchOffset Pitch offset
/// @param {Real} _priority Sound priority
/// @return {Id.Sound} Sound reference
function __AEGamePlaySound(_sound, _bus, _loop, _volume, _pitch, _volumeVariance, _pitchVariance, _volumeOffset, _pitchOffset, _priority) {
    var _baseVolume = _volume;
    var _basePitch = _pitch;

    if(_volumeVariance > 0) {
        _baseVolume += random_range(-_volumeVariance, _volumeVariance);
    }

    if(_pitchVariance > 0) {
        _basePitch += random_range(-_pitchVariance, _pitchVariance);
    }

    _baseVolume += _volumeOffset;
    _basePitch += _pitchOffset;

    return audio_play_sound_on(_bus.emitter, _sound, _loop, _priority, _baseVolume, 0, _basePitch);
}

/// @desc Set the position for an object
/// @param {Struct.__AESystemPlaying} _sound Sound playing
/// @param {Real} _x X position
/// @param {Real} _y Y position
/// @param {Real} _z Z position
/// @return {Undefined}
function __AEGamePositionFound(_sound, _x, _y, _z) {
    if(_sound == undefined || !_sound.spatialized) {
        // No sound, or the sound is not spatialized
        return;
    }

    var _bus = __AEBusGetByName(_sound.busName);

    if(!_bus) {
        // The bus does not exists
        return;
    }

    audio_emitter_position(_bus.emitter, _x, _y, _z);

}

/// @desc Get a game sound library item
/// @param {Enum.AE_GAME_SOUND} _gameSoundInstance Game sound instance
/// @return {Struct.__AESystemLibrarySound,Struct.__AESystemLibrarySoundArray} Sound library item
function __AEGameLibraryGetSound(_gameSoundInstance) {
    static _system = __AudioEngineSystem();

    // Feather ignore once GM1045
    return _system.library.game[$ _gameSoundInstance];
}

/// @desc Update the volume of all static game sounds in a category
/// @param {Enum.AE_CATEGORIES} _category Game sound category
/// @param {Struct.__AEBus} _bus Bus to update volume on
/// @return {Undefined}
function __AEGameUpdateStaticVolume(_category, _bus) {
    // Feather ignore once GM1041 The enum value is correct
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME, _category);

    for(var _i = 0; _i < array_length(_filtered); _i++) {
        var _currentSound = _filtered[_i];
        // Feather ignore once GM1041 The enum value is correct
        var _volume = __AEGameResolveStaticVolume(_category, _currentSound, _bus);

        audio_sound_gain(_currentSound.ref, _volume, 0);

    }
}

/// @desc Resolve the final volume for a static game sound
/// @param {Enum.AE_CATEGORIES} _category Game sound category
/// @param {Struct.__AEBus} _bus Bus to update volume on
/// @return {Undefined}
function __AEGameUpdateSpatializedVolume(_category, _bus) {
    // Feather ignore once GM1041 The enum value is correct
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_SPATIALIZED_GAME, _category);

    for(var _i = 0; _i < array_length(_filtered); _i++) {
        var _currentSound = _filtered[_i];
        // Feather ignore once GM1041 The enum value is correct
        var _volume = __AEGameResolveSpatializedVolume(_category, _currentSound, _bus);

        audio_sound_gain(_currentSound.ref, _volume, 0);

    }
}

/// @desc Resolve the final volume for a static game sound
/// @param {Enum.AE_CATEGORIES} _category Game sound category
/// @param {Struct.__AESystemPlaying} _sound Current playing sound
/// @param {Struct.__AEBus} [_busParam] Optional bus parameter
/// @return {Real} Calculated volume
function __AEGameResolveStaticVolume(_category, _sound, _busParam = undefined) {
    // Feather ignore once GM1041 The enum value is correct
    return __AEVolumeResolve(__AUDIOENGINE_PREFIX_STATIC_GAME, "game", _category, _sound, _busParam);
}

/// @desc Resolve the final volume for a spatialized game sound
/// @param {Enum.AE_CATEGORIES} _category Game sound category
/// @param {Struct.__AESystemPlaying} _sound Current playing sound
/// @param {Struct.__AEBus} [_busParam] Optional bus parameter
/// @return {Real} Calculated volume
function __AEGameResolveSpatializedVolume(_category, _sound, _busParam = undefined) {
    // Feather ignore once GM1041 The enum value is correct
    return __AEVolumeResolve(__AUDIOENGINE_PREFIX_SPATIALIZED_GAME, "game", _category, _sound, _busParam);
}

/// @desc Resolve the final volume for a game sound
/// @param {Enum.AE_CATEGORIES} _category Game sound category
/// @param {Struct.__AESystemPlaying} _sound Current playing sound
/// @param {Struct.__AEBus} [_busParam] Optional bus parameter
/// @return {Real} Calculated volume
function __AEGameResolveVolume(_category, _sound, _busParam = undefined) {
    if(_sound.spatialized) {
        // Feather ignore once GM1041 The enum value is correct
        return __AEGameResolveSpatializedVolume(_category, _sound, _busParam);
    }
    // Feather ignore once GM1041 The enum value is correct
    return __AEGameResolveStaticVolume(_category, _sound, _busParam);
}