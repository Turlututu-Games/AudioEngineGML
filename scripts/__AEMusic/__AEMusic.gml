/// @desc Get Current Music
/// @param {Enum.AE_CATEGORIES} _category Music category
/// @return {Struct.__AEMusicCurrentMusic} Current Music
function __AEMusicGetCurrentMusic(_category) {
    static _system = __AudioEngineSystem();

    if(_system.currentMusics[$ _category] == undefined) {
        _system.currentMusics[$ _category] = new __AEMusicCurrentMusic();
    }

    return _system.currentMusics[$ _category];
}

/// @desc Reset Current Music
/// @param {Enum.AE_CATEGORIES} _category Music category
/// @return {Undefined}
function __AEMusicResetCurrentMusic(_category) {
    static _system = __AudioEngineSystem();

    _system.currentMusics[$ _category] = new __AEMusicCurrentMusic();

}

/// @desc Directly Stop Current Music
/// @param {Enum.AE_CATEGORIES} _category Music category
/// @return {Undefined}
function __AEMusicStop(_category) {
    // Feather ignore once GM1041 The enum value is correct
    var _currentMusic = __AEMusicGetCurrentMusic(_category);

    if(_currentMusic.id != -1) {

        if(_currentMusic.multi) {
            for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
                var _track = _currentMusic.tracks[_i];

                audio_stop_sound(_track.asset);

            }
        } else {
            audio_stop_sound(_currentMusic.tracks[0].asset);

        }
    }
}

/// @desc Stop crossfaded sounds
/// @param {Array<Struct.__AEMusicCrossfaded>} _crossfadedSounds Crossfaded sounds to stop
/// @return {Array<Struct.__AEMusicCrossfaded>} Unfaded sounds
function __AEMusicStopCrossfaded(_crossfadedSounds) {

    var _unfaded = []

    // Stop fading sound with volume 0, store unfaded sounds
    for(var _i = 0; _i < array_length(_crossfadedSounds); _i++) {
        var _item = _crossfadedSounds[_i];
        var _sound = _item.ref;

        var _volume = audio_sound_get_gain(_sound);

        if(_volume == 0) {
            audio_stop_sound(_sound);
        } else {
            array_push(_unfaded, _item);
        }
    }

    return _unfaded;
}

/// @desc Stop Current Music with fade-out
/// @param {Enum.AE_CATEGORIES} _category Music category
/// @param {Real} _fade Fade duration
/// @return {Undefined}
function __AEMusicStopWithFade(_category, _fade) {

    // Feather ignore once GM1041
    var _currentMusic = __AEMusicGetCurrentMusic(_category);

    if(_currentMusic.id != -1) {
        with(__oAudioEngineManager) {

            if(_currentMusic.multi) {
                for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
                    var _track = _currentMusic.tracks[_i];

                    audio_sound_gain(_track.ref, 0, _fade);
                    array_push(crossfadedMusic, new __AEMusicCrossfaded(_track.ref, _category));

                }
            } else {
                audio_sound_gain(_currentMusic.tracks[0].ref, 0, _fade);
                array_push(crossfadedMusic, new __AEMusicCrossfaded(_currentMusic.tracks[0].ref, _category));
            }

            var _seconds = (_fade / 1000) * 5;
            var _fps = game_get_speed(gamespeed_fps);
            var _frames = _seconds * game_get_speed(gamespeed_fps);

            // Feather ignore once GM1019 Ignore invalid type error
            __AELogVerbose($"Triggering alarm for {_seconds} seconds (fps: {_fps}, frames: {_frames})")

            // Trigger the alarm for cleanup 5s after fadeout finish
            alarm_set(0, _seconds * game_get_speed(gamespeed_fps));
        }
    }
}

/// @desc Play music with fade-in
/// @param {Enum.AE_MUSIC} _musicInstance Music instance
/// @param {Enum.AE_CATEGORIES} _category Music category
/// @param {Real} _fade Fade duration
/// @param {Array<Enum.AE_MULTITRACK_MOOD>} _previousMoods Previous moods
/// @param {Real,Undefined} _volume Volume
/// @return {Undefined}
function __AEMusicPlayWithFade(_musicInstance, _category, _fade, _previousMoods, _volume) {

    static _system = __AudioEngineSystem();

    // Feather ignore once GM1041
    var _newMusic = __AEMusicLibraryGetSound(_musicInstance);

    if(!_newMusic) {
        // The music does not exists! Log it
        // Feather ignore once GM1019 Ignore invalid type error
        __AELogError($"Invalid music id: {_musicInstance}");
        return;
    }

    var _bus = __AEBusGet(__AUDIOENGINE_PREFIX_MUSIC, _category);

    if(_volume != undefined) {
        _bus.volume = _volume;
    }

    if(_newMusic.multi) {
        // Feather ignore once GM1041
        __AEMusicPlayMultiTrackWithFade(_musicInstance, _category, _fade, _previousMoods, _newMusic, _bus);
    } else {
        // Feather ignore once GM1041
        __AEMusicPlaySingleTrackWithFade(_musicInstance, _category, _fade, _newMusic, _bus);
    }
}

/// @desc Play multi-track music with fade-in
/// @param {Enum.AE_MUSIC} _musicInstance Music instance
/// @param {Enum.AE_CATEGORIES} _category Music category
/// @param {Real} _fade Fade duration
/// @param {Array<Enum.AE_MULTITRACK_MOOD>} _previousMoods Previous moods
/// @param {Struct.__AESystemLibraryMusicMulti} _newMusic New music to play
/// @param {Struct.__AEBus} _bus Bus to play the sound on
/// @return {Undefined}
function __AEMusicPlayMultiTrackWithFade(_musicInstance, _category, _fade, _previousMoods, _newMusic, _bus) {
    static _system = __AudioEngineSystem();

    // Feather ignore once GM1041
    var _currentMusic = new __AEMusicCurrentMusic(_musicInstance, [], true, _previousMoods);

    for(var _i = 0; _i < array_length(_newMusic.assets); _i++) {
        var _music = _newMusic.assets[_i];

        // Feather ignore once GM1041
        var _volume = __AEMusicResolveVolume(_category, _music, _bus)

        var _musicAsset = __AEStreamReturnAsset(_music);

        var _ref = audio_play_sound_on(_bus.emitter, _musicAsset, true, _newMusic.priority);

        var _playing = new __AESystemPlaying(_music.asset, _ref, $"{__AUDIOENGINE_PREFIX_MUSIC}-{_category}", false, _music.volume);
        _system.playingMap[$ _ref] = _playing;
        array_push(_system.playing, _playing);

        // Feather ignore once GM1041 The enum value is correct
        array_push(_currentMusic.tracks, new __AEMusicCurrentMusicTrack(_musicAsset, _music.isStream, _music.mood, _music.volume, _ref) );

        if(array_get_index(_currentMusic.moods, _music.mood) == -1) {
            audio_sound_gain(_ref, 0, 0);
        } else {
            if(_fade > 0) {
                // Immediate start at volume 0 then go to wanted volume on fade time
                audio_sound_gain(_ref, 0, 0);
                audio_sound_gain(_ref, _volume, _fade);
            } else {
                audio_sound_gain(_ref, _volume, 0);
            }
        }
    }

    _system.currentMusics[$ _category] = _currentMusic;
}

/// @desc Play single-track music with fade-in
/// @param {Enum.AE_MUSIC} _musicInstance Music instance
/// @param {Enum.AE_CATEGORIES} _category Music category
/// @param {Real} _fade Fade duration
/// @param {Struct.__AESystemLibraryMusicSingle} _newMusic New music to play
/// @param {Struct.__AEBus} _bus Bus to play the sound on
/// @return {Undefined}
function __AEMusicPlaySingleTrackWithFade(_musicInstance, _category, _fade, _newMusic, _bus) {
    static _system = __AudioEngineSystem();

    var _music = __AEStreamReturnAsset(_newMusic);

    var _ref = audio_play_sound_on(_bus.emitter, _music, true, _newMusic.priority);

    // Feather ignore once GM1041
    var _volume = __AEMusicResolveVolume(_category, _newMusic, _bus)

    if(_fade > 0) {
        audio_sound_gain(_ref, 0, 0);
        audio_sound_gain(_ref, _volume, _fade);
    } else {
        audio_sound_gain(_ref, _volume, 0);
    }

    var _playing = new __AESystemPlaying(_newMusic.asset, _ref, $"{__AUDIOENGINE_PREFIX_MUSIC}-{_category}", false, _newMusic.volume);
    _system.playingMap[$ _ref] = _playing;
    array_push(_system.playing, _playing);

    // Feather ignore once GM1041
    var _currentMusic = new __AEMusicCurrentMusic(_musicInstance);
    // Feather ignore once GM1041
    _currentMusic.tracks = [new __AEMusicCurrentMusicTrack(_music, _newMusic.isStream, 0, _newMusic.volume, _ref)];
    _currentMusic.multi = false;

    _system.currentMusics[$ _category] = _currentMusic;

}

/// @desc Current Music Track
/// @param {Asset.GMSound,String} [_asset] Sound asset
/// @param {Bool} [_isStream] Is stream
/// @param {Enum.AE_MULTITRACK_MOOD} [_mood] Mood
/// @param {Real} [_volume] Volume
/// @param {Id.Sound} [_ref] Sound reference
// Feather ignore once GM1045
function __AEMusicCurrentMusicTrack(_asset = noone, _isStream = false, _mood = 0, _volume = 1, _ref = noone) constructor {
    asset = _asset;
    isStream = _isStream;
    mood = _mood;
    volume = _volume;
    ref = _ref;
}

/// @desc Current Music
/// @param {Enum.AE_MUSIC} [_id] Music id
/// @param {Array<Struct.__AEMusicCurrentMusicTrack>} [_tracks] Tracks
/// @param {Bool} [_multi] Is multi-track
/// @param {Array<Enum.AE_MULTITRACK_MOOD>} [_moods] Active moods
/// @param {Real} [_volume] Volume
// Feather ignore once GM1045
function __AEMusicCurrentMusic(_id = -1, _tracks = [], _multi = false, _moods = [0], _volume = 1) constructor {
    id = _id;
    tracks = _tracks
    multi = _multi;
    moods = _moods;
    volume = _volume;

    // Ensure mood 0 is set if moods are empty
    if(array_length(moods) == 0) {
        array_push(moods, 0)
    }
}

/// @desc Get a music library item
/// @param {Enum.AE_MUSIC} _musicInstance Music instance
/// @return {Struct.__AESystemLibraryMusicSingle,Struct.__AESystemLibraryMusicMulti} Music library item
function __AEMusicLibraryGetSound(_musicInstance) {
    static _system = __AudioEngineSystem();

    // Feather ignore once GM1045
    return _system.library.music[$ _musicInstance];
}

/// @desc Crossfaded sound reference
/// @param {Id.Sound} _ref Sound reference
/// @param {String} _category Music category
function __AEMusicCrossfaded(_ref, _category) constructor {
    ref = _ref
    category = _category
}

/// @desc Update the volume of all music sounds in a category
/// @param {Enum.AE_CATEGORIES} _category Music category
/// @param {Struct.__AEBus} _bus Bus to update
/// @return {Undefined}
function __AEMusicUpdateVolume(_category, _bus) {
    // Feather ignore once GM1041
    var _currentMusic = __AEMusicGetCurrentMusic(_category);

    for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
        var _track = _currentMusic.tracks[_i];
        // Feather ignore once GM1041
        var _volume = __AEMusicResolveVolume(_category, _track, _bus);

        if(array_get_index(_currentMusic.moods, _track.mood) == -1) {
            audio_sound_gain(_track.ref, 0, 0);
        } else {
            audio_sound_gain(_track.ref, _volume, 0);
        }

    }
}

/// @desc Resolve the final volume for a music sound
/// @param {Enum.AE_CATEGORIES} _category Music category
/// @param {Struct.__AEMusicCurrentMusicTrack} _music Music track
/// @param {Struct.__AEBus} [_busParam] Optional bus parameter
/// @return {Real} Calculated volume
function __AEMusicResolveVolume(_category, _music, _busParam = undefined) {
    // Feather ignore once GM1041
    return __AEVolumeResolve(__AUDIOENGINE_PREFIX_MUSIC, "music", _category, _music, _busParam);
}
