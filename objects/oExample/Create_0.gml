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
dbg_section("Music");
musicIndex = AUDIO_MUSIC.DECORATE;

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

dbg_button("[ ]", function() {
    AudioEngineMusicStop(AUDIO_CATEGORIES.MAIN, oExample.getCrossfade());
}, 40);
dbg_same_line();
dbg_button(">", function() {
    AudioEngineMusicPlay(musicIndex, AUDIO_CATEGORIES.MAIN, oExample.getCrossfade());
}, 40);
dbg_same_line();
dbg_button("||", function() {
    AudioEngineMusicPause(AUDIO_CATEGORIES.MAIN);
}, 40);
dbg_same_line();
dbg_button(">||", function() {
    AudioEngineMusicResume(AUDIO_CATEGORIES.MAIN);
}, 40);

dbg_button("Mood : Cute", function() {
    AudioEngineMusicMoodSet(AUDIO_MULTITRACK_MOOD.CUTE, AUDIO_CATEGORIES.MAIN, oExample.getCrossfade());
});
dbg_same_line();
dbg_button("Mood : Festive", function() {
    AudioEngineMusicMoodSet(AUDIO_MULTITRACK_MOOD.FESTIVE, AUDIO_CATEGORIES.MAIN, oExample.getCrossfade());
});
dbg_same_line();
dbg_button("Mood : Silly", function() {
    AudioEngineMusicMoodSet(AUDIO_MULTITRACK_MOOD.SILLY, AUDIO_CATEGORIES.MAIN, oExample.getCrossfade());
});

dbg_watch(ref_create(self, "debugMusicPlayed"), "Music Played");
#endregion

#region UI Sound
dbg_section("UI Sound", false);
uiVolumeOffset = 0;
uiPitchOffset = 0;

dbg_slider(ref_create(self, "uiVolumeOffset"), -1, 1, "Volume Offset");
dbg_slider(ref_create(self, "uiPitchOffset"), -1, 1, "Pitch Offset");

dbg_button("Play 'Click'", function() {
    AudioEngineUIPlay(AUDIO_UI_SOUND.CLICK, AUDIO_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
});

dbg_button("Play 'Attack' (random 8)", function() {
    AudioEngineUIPlay(AUDIO_UI_SOUND.ATTACK, AUDIO_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
});

dbg_button("Play 'Cough' (stream)", function() {
    AudioEngineUIPlay(AUDIO_UI_SOUND.COUGH, AUDIO_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
});

dbg_button("'Click' with pitch/volume variance", function() {
    AudioEngineUIPlay(AUDIO_UI_SOUND.CLICK_VARIANCE, AUDIO_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
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


dbg_checkbox(ref_create(self, "listenerAtCursor"), "Listener at cursor");

dbg_text("Wiper sound (loop, no auto-clean)");
dbg_button(">", function() {
	if(wiperSound != undefined) {
		// Restart sound
		AudioEngineGameStop(wiperSound);
	}
	
    wiperSound = AudioEngineGamePlay(AUDIO_GAME_SOUND.WIPER, AUDIO_CATEGORIES.MAIN, oExample.gameVolumeOffset, oExample.gamePitchOffset);
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
	
    var _engineSound = AudioEngineGamePlayAtObject(AUDIO_GAME_SOUND.ENGINE, oEmitterTop, 0, oExample.gameVolumeOffset, oExample.gamePitchOffset);
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
    AudioEngineGamePlay(AUDIO_GAME_SOUND.START_ENGINE, AUDIO_CATEGORIES.MAIN, oExample.gameVolumeOffset, oExample.gamePitchOffset);
});

dbg_text("Warning (spatialized)");
dbg_button("Left", function() {
    AudioEngineGamePlayAt(AUDIO_GAME_SOUND.WARNING, oEmitterLeft.x, oEmitterLeft.y, 0, oExample.gameVolumeOffset, oExample.gamePitchOffset);
});
dbg_same_line();
dbg_button("Right", function() {
    AudioEngineGamePlayAt(AUDIO_GAME_SOUND.WARNING, oEmitterRight.x, oEmitterRight.y, 0, oExample.gameVolumeOffset, oExample.gamePitchOffset);
});

dbg_text("River (circling object)");
dbg_button(">", function() {	
	if(riverSound != undefined) {
		// Restart sound
		AudioEngineGameStop(riverSound);
	}	
	
    riverSound = AudioEngineGamePlayAtObject(AUDIO_GAME_SOUND.RIVER, oEmitterCircle, 0, oExample.gameVolumeOffset, oExample.gamePitchOffset);

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

dbg_watch(ref_create(self, "playing"), "Playing");
dbg_watch(ref_create(self, "listener_x"), "Listener X");
dbg_watch(ref_create(self, "listener_y"), "Listener Y");
dbg_watch(ref_create(self, "listener_z"), "Listener Z");
dbg_watch(ref_create(self, "busCount"), "Bus Count");
dbg_watch(ref_create(self, "cachedStreamCount"), "Cached Stream Count");
#endregion
//playing: _system.playing
//dbg_section("Current music", false);

//ref_to_text = ref_create(currentMusicMulti, "text");

//dbg_text(ref_to_text);
