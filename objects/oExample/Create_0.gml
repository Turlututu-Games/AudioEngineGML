dbg_view("AudioEngineGML Demo", true, -1, -1, 800, 600);

__AEBusSetListenerPosition(room_width * 0.5, room_height * 0.5);

#region General
dbg_section("General");
// Crusher Effect
crusherEnabled = false;
debugCrusherPrevious = false;
crusherEffect = audio_effect_create(AudioEffectType.Bitcrusher, {
    gain: 1.1, factor: 20, resolution: 8, mix: 0.5
});

// Reverb Effect
reverbEnabled = false;
debugReberbPrevious = false;
reverbEffect = audio_effect_create(AudioEffectType.Reverb1, {
	size: 0.5, damp: 0.5, mix: 0.2
});

// Effects Count
debugEffectsCount = 0;


dbg_checkbox(ref_create(self, "crusherEnabled"), "Crusher Effect");
dbg_checkbox(ref_create(self, "reverbEnabled"), "Reverb Effect");
dbg_watch(ref_create(self, "debugEffectsCount"), "Effects Count");
#endregion

#region Music
dbg_section("Music", false);
musicIndex = AE_MUSIC.DECORATE;
musicVolume = 1;
musicMainVolume = 1;
musicSecondaryVolume = 1;

// Crossfade
crossfade = false;
crossfadeValue = 2000;
getCrossfade = function() {
    return crossfade ? crossfadeValue : 0;
};

// Music Played
debugMusicPlayed = "-";

dbg_drop_down(ref_create(self, "musicIndex"), "Solo:0,Multi:1,Stream:2");
dbg_checkbox(ref_create(self, "crossfade"), "Crossfade Music");
dbg_slider(ref_create(self, "crossfadeValue"), 0, 10_000, "Crossfade Time (ms)");

dbg_slider(ref_create(self, "musicVolume"), 0, 1, "Music Volumes", 0.1);
dbg_slider(ref_create(self, "musicMainVolume"), 0, 1, "Music Main Volume", 0.1);
dbg_slider(ref_create(self, "musicSecondaryVolume"), 0, 1, "Music Secondary Volume", 0.1);

dbg_button("[ ]", function() {
    AudioEngineMusicStop(AE_CATEGORIES.MAIN, oExample.getCrossfade());
}, 40);
dbg_same_line();
dbg_button(">", function() {
    AudioEngineMusicPlay(musicIndex, AE_CATEGORIES.MAIN, oExample.musicMainVolume, oExample.getCrossfade());
}, 40);
dbg_same_line();
dbg_button("||", function() {
    AudioEngineMusicPause(AE_CATEGORIES.MAIN);
}, 40);
dbg_same_line();
dbg_button(">||", function() {
    AudioEngineMusicResume(AE_CATEGORIES.MAIN);
}, 40);

dbg_button("Mood : Cute", function() {
    AudioEngineMusicMoodSet(AE_MULTITRACK_MOOD.CUTE, AE_CATEGORIES.MAIN, oExample.getCrossfade());
});
dbg_same_line();
dbg_button("Mood : Festive", function() {
    AudioEngineMusicMoodSet(AE_MULTITRACK_MOOD.FESTIVE, AE_CATEGORIES.MAIN, oExample.getCrossfade());
});
dbg_same_line();
dbg_button("Mood : Silly", function() {
    AudioEngineMusicMoodSet(AE_MULTITRACK_MOOD.SILLY, AE_CATEGORIES.MAIN, oExample.getCrossfade());
});

dbg_text("River (Secondary channel)");
dbg_button(">", function() {	

	
    AudioEngineMusicPlay(AE_MUSIC.RIVER_SOUNDSCAPE, AE_CATEGORIES.ALTERNATE, oExample.musicSecondaryVolume);

});
dbg_same_line();
dbg_button("[ ]", function() {
	AudioEngineMusicStop(AE_CATEGORIES.ALTERNATE);
});

dbg_watch(ref_create(self, "debugMusicPlayed"), "Music Played");
#endregion

#region UI Sound
dbg_section("UI Sound", true);
uiVolumeOffset = 0;
uiPitchOffset = 0;
uiVolume = 1;
uiMainVolume = 1;
uiSecondaryVolume = 1;

dbg_slider(ref_create(self, "uiVolumeOffset"), -1, 1, "Volume Offset");
dbg_slider(ref_create(self, "uiPitchOffset"), -1, 1, "Pitch Offset");

dbg_slider(ref_create(self, "uiVolume"), 0, 1, "UI Volumes", 0.1);
dbg_slider(ref_create(self, "uiMainVolume"), 0, 1, "UI Main Volume", 0.1);
dbg_slider(ref_create(self, "uiSecondaryVolume"), 0, 1, "UI Secondary Volume", 0.1);

dbg_button("Play 'Click'", function() {
    AudioEngineUIPlay(AE_UI_SOUND.CLICK, AE_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
});

dbg_button("Play 'Attack' (random 8)", function() {
    AudioEngineUIPlay(AE_UI_SOUND.ATTACK, AE_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
});

dbg_button("Play 'Cough' (stream)", function() {
    AudioEngineUIPlay(AE_UI_SOUND.COUGH, AE_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
});

dbg_button("'Click' with pitch/volume variance", function() {
    AudioEngineUIPlay(AE_UI_SOUND.CLICK_VARIANCE, AE_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
});

dbg_button("Play 'River'", function() {
    AudioEngineUIPlay(AE_UI_SOUND.RIVER_SOUNDSCAPE, AE_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
});
#endregion

#region Game Sound
dbg_section("Game Sound", false);
gameVolumeOffset = 0;
gamePitchOffset = 0;
listenerAtCursor = false;
listenerAtCursorPrevious = false;
wiperSound = undefined;
engineSound = undefined;
riverSound = undefined;

gameVolume = 1;
gameMainVolume = 1;
gameSpatializedVolume = 1;
gameSpatializedVolumePrevious = 1;


dbg_checkbox(ref_create(self, "listenerAtCursor"), "Listener at cursor");

dbg_slider(ref_create(self, "gameVolume"), 0, 1, "Game Volumes", 0.1);
dbg_slider(ref_create(self, "gameMainVolume"), 0, 1, "Game Main Volume", 0.1);
dbg_slider(ref_create(self, "gameSpatializedVolume"), 0, 1, "Game Spatialized Volume", 0.1);

dbg_text("Wiper sound (loop, no auto-clean)");
dbg_button(">", function() {
	if(wiperSound != undefined) {
		// Restart sound
		AudioEngineGameStop(wiperSound);
	}
	
    wiperSound = AudioEngineGamePlay(AE_GAME_SOUND.WIPER, AE_CATEGORIES.MAIN, oExample.gameVolumeOffset, oExample.gamePitchOffset);
});
dbg_same_line();
dbg_button("[ ]", function() {
	if(wiperSound != undefined) {
		AudioEngineGameStop(wiperSound);
	}
	wiperSound = undefined;
});

dbg_text("Engine sound (loop, spatialized)");
dbg_button(">", function() {
	
	if(engineSound != undefined) {
		// Restart sound
		AudioEngineGameStop(engineSound);
	}	
	
    var _engineSound = AudioEngineGamePlayAtObject(AE_GAME_SOUND.ENGINE, oEmitterTop, 0, oExample.gameVolumeOffset, oExample.gamePitchOffset);
	// Check with direct ref instead of playing instance
	engineSound = _engineSound.ref;
});
dbg_same_line();
dbg_button("[ ]", function() {
	if(engineSound != undefined) {
		AudioEngineGameStop(engineSound);
	}
	engineSound = undefined;
});

dbg_text("Start Engine (random 2, stream)");
dbg_button(">", function() {
    AudioEngineGamePlay(AE_GAME_SOUND.START_ENGINE, AE_CATEGORIES.MAIN, oExample.gameVolumeOffset, oExample.gamePitchOffset);
});

dbg_text("Warning (spatialized)");
dbg_button("Left", function() {
    AudioEngineGamePlayAt(AE_GAME_SOUND.WARNING, oEmitterLeft.x, oEmitterLeft.y, 0, oExample.gameVolumeOffset, oExample.gamePitchOffset);
});
dbg_same_line();
dbg_button("Right", function() {
    AudioEngineGamePlayAt(AE_GAME_SOUND.WARNING, oEmitterRight.x, oEmitterRight.y, 0, oExample.gameVolumeOffset, oExample.gamePitchOffset);
});

dbg_text("River (circling object)");
dbg_button(">", function() {	
	if(riverSound != undefined) {
		// Restart sound
		AudioEngineGameStop(riverSound);
	}	
	
    riverSound = AudioEngineGamePlayAtObject(AE_GAME_SOUND.RIVER, oEmitterCircle, 0, oExample.gameVolumeOffset, oExample.gamePitchOffset);

});
dbg_same_line();
dbg_button("[ ]", function() {
	if(riverSound != undefined) {
		AudioEngineGameStop(riverSound);
	}
	riverSound = undefined;
});
#endregion

#region Info
dbg_section("Info", true);
playing = [];
busCount = 0;
cachedStreamCount = 0;
listener_x = 0;
listener_y = 0;
listener_z = 0;
defaultVolumes = [];
buses = [];

dbg_watch(ref_create(self, "playing"), "Playing");
dbg_watch(ref_create(self, "listener_x"), "Listener X");
dbg_watch(ref_create(self, "listener_y"), "Listener Y");
dbg_watch(ref_create(self, "listener_z"), "Listener Z");
dbg_watch(ref_create(self, "busCount"), "Bus Count");
dbg_watch(ref_create(self, "cachedStreamCount"), "Cached Stream Count");
dbg_watch(ref_create(self, "defaultVolumes"), "Default volumes");
dbg_watch(ref_create(self, "buses"), "Buses");


#endregion
//playing: _system.playing
//dbg_section("Current music", false);

//ref_to_text = ref_create(currentMusicMulti, "text");

//dbg_text(ref_to_text);
