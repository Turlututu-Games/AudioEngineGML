var _bus1 = __AEBusGet("music", 0);
var _bus2 = __AEBusGet("music", 1);
var _busUI1 = __AEBusGet("ui", 0);
var _busUI2 = __AEBusGet("ui", 1);

var _busGame = __AEBusGet("game", 0);
// var _busGameSpatialized = __AEBusGetAll("game");

// Feather ignore once GM1041 The enum value is correct
var _currentMusic = __AEMusicGetCurrentMusic(0);
var _system = __AudioEngineSystem();

playing = _system.playing;
busCount = struct_names_count(_system.bus);
cachedStreamCount = struct_names_count(_system.streams);
defaultVolumes = _system.defaultBusVolumes;
buses = _system.bus;

if(musicVolume != _system.volumes.music) {
    AudioEngineMusicSetVolume(musicVolume);
}

if(uiVolume != _system.volumes.ui) {
    AudioEngineUISetVolume(uiVolume);
}

if(gameVolume != _system.volumes.game) {
    AudioEngineGameSetVolume(gameVolume);
}

if(musicMainVolume != _bus1.volume) {
    // Feather ignore once GM1041 The enum value is correct
    AudioEngineMusicSetCategoryVolume(musicMainVolume, 0);
}

if(musicSecondaryVolume != _bus2.volume) {
    // Feather ignore once GM1041 The enum value is correct
    AudioEngineMusicSetCategoryVolume(musicSecondaryVolume, 1);
}

if(uiMainVolume != _busUI1.volume) {
    // Feather ignore once GM1041 The enum value is correct
    AudioEngineUISetCategoryVolume(uiMainVolume, 0);
}

if(uiSecondaryVolume != _busUI2.volume) {
    // Feather ignore once GM1041 The enum value is correct
    AudioEngineUISetCategoryVolume(uiMainVolume, 1);
}

if(gameMainVolume != _busGame.volume) {
    // Feather ignore once GM1041 The enum value is correct
    AudioEngineGameSetStaticVolume(gameMainVolume, 0);
}

if(gameSpatializedVolume != gameSpatializedVolumePrevious) {
    gameSpatializedVolumePrevious = gameSpatializedVolume;
    AudioEngineGameSetSpatializedVolume(gameSpatializedVolume);
}

var count = 0;

for(var _i = 0; _i < 8; _i++) {
    if(_bus1.bus.effects[_i] != undefined) {
        count++;
    }
}

for(var _i = 0; _i < 8; _i++) {
    if(_bus2.bus.effects[_i] != undefined) {
        count++;
    }
}

debugEffectsCount = count;

if(_currentMusic.id != -1) {

    debugMusicPlayed = [];

    for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
        var _name = _currentMusic.tracks[_i].isStream ? "Stream" : audio_get_name(_currentMusic.tracks[_i].asset);
        var _len = audio_sound_length(_currentMusic.tracks[_i].asset);
        var _pos = audio_sound_get_track_position(_currentMusic.tracks[_i].ref)

        var _gain = audio_sound_get_gain(_currentMusic.tracks[_i].ref);

        if(_gain > 0) {
            array_push(debugMusicPlayed, $"{_name} ({_pos}/{_len})")
        }
    }

} else {
    debugMusicPlayed = "-"
}

if(debugCrusherPrevious != crusherEnabled) {
    if(crusherEnabled) {
        AudioEngineMusicEffectSet(crusherEffect);
        AudioEngineUIEffectSet(crusherEffect);
    } else {
        AudioEngineMusicEffectClear();
        AudioEngineUIEffectClear();
    }
    debugCrusherPrevious = crusherEnabled;
}

if(debugReberbPrevious != reverbEnabled) {
    if(reverbEnabled) {
        AudioEngineMusicEffectSet(reverbEffect, 1);
        AudioEngineUIEffectSet(reverbEffect, 1);
        AudioEngineUIEffectSet({}, 2);
        // Feather ignore once GM1041 The error is intended
        AudioEngineUIEffectSet(undefined, 3);
        // Feather ignore once GM1041 The error is intended
        AudioEngineUIEffectSet(riverSound, 4);
    } else {
        AudioEngineMusicEffectClear(1);
        AudioEngineUIEffectClear(1);
    }
    debugReberbPrevious = reverbEnabled;
}

if(listenerAtCursor) {
    __AEBusSetListenerPosition(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 0);
}

if(listenerAtCursor != listenerAtCursorPrevious) {
    listenerAtCursorPrevious = listenerAtCursor;
    if(!listenerAtCursor) {
        __AEBusSetListenerPosition(room_width * 0.5, room_height * 0.5);
    }
}

var _listenerInfo = audio_get_listener_info(0);
var _listenerData = audio_listener_get_data(_listenerInfo[? "index"]);
listener_x = _listenerData[? "x"];
listener_y = _listenerData[? "y"];
listener_z = _listenerData[? "z"];
ds_map_destroy(_listenerInfo);
ds_map_destroy(_listenerData);

if(riverSound != undefined) {
    AudioEngineGamePositionAtObject    (riverSound, oEmitterCircle, 0);
}
