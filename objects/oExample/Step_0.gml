var _bus = __AEBusGet($"music-0");
var _currentMusic = __AEMusicGetCurrentMusic(0);
var _system = __AudioEngineSystem();

playing = _system.playing;
busCount = struct_names_count(_system.bus);
cachedStreamCount = struct_names_count(_system.streams);

var count = 0;

for(var _i = 0; _i < 8; _i++) {
	if(_bus.bus.effects[_i] != undefined) {
		count++;	
	}
}

debugEffectsCount = count;

if(_currentMusic.id != -1) {
	
	debugMusicPlayed = [];
	
	for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
		var _name = _currentMusic.tracks[_i].isStream ? "Steam" : audio_get_name(_currentMusic.tracks[_i].asset);
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
		AudioEngineUIEffectSet(undefined, 3);
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
	AudioEngineGamePositionAtObject	(riverSound, oEmitterCircle, 0, AUDIO_CATEGORIES.MAIN);
}

/*var _system = __AudioEngineSystem()

currentMusicAsset = _system.currentMusic[@ "asset"];
currentMusicAssets = _system.currentMusic[@ "assets"];
currentMusicGroup = _system.currentMusic[@ "group"];
currentMusicIsSteam = string(_system.currentMusic[@ "isSteam"]);
currentMusicMulti = string(_system.currentMusic[@ "multi"]);*/