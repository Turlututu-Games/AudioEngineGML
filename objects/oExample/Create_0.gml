crossfade = false;
crusherEnabled = false;
reverbEnabled = false;
crossfadeValue = 2000;
uiVolumeOffset = 0;
uiPitchOffset = 0;

reverbEffect = audio_effect_create(AudioEffectType.Reverb1, {
	size: 0.5, damp: 0.5, mix: 0.2
});

crusherEffect = audio_effect_create(AudioEffectType.Bitcrusher, {
    gain: 1.1, factor: 20, resolution: 8, mix: 0.5
})


getCrossfade = function() {
    return crossfade ? crossfadeValue : 0;
};

musicIndex = AUDIO_MUSIC.DECORATE;


debugCrusherPrevious = false;
debugReberbPrevious = false;

debugMusicPlayed = "-";
debugEffectsCount = 0;

playing = [];


dbg_view("AudioEngineGML Demo", true, -1, -1, 800, 600);

dbg_section("General");
dbg_checkbox(ref_create(self, "crusherEnabled"), "Crusher Effect");
dbg_checkbox(ref_create(self, "reverbEnabled"), "Reverb Effect");
dbg_watch(ref_create(self, "debugEffectsCount"), "Effects Count");

dbg_section("Music");

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

dbg_button("State : Cute", function() {
    AudioEngineMusicMoodSet(AUDIO_MULTITRACK_MOOD.CUTE, AUDIO_CATEGORIES.MAIN, oExample.getCrossfade());
});
dbg_same_line();
dbg_button("State : Festive", function() {
    AudioEngineMusicMoodSet(AUDIO_MULTITRACK_MOOD.FESTIVE, AUDIO_CATEGORIES.MAIN, oExample.getCrossfade());
});
dbg_same_line();
dbg_button("State : Silly", function() {
    AudioEngineMusicMoodSet(AUDIO_MULTITRACK_MOOD.SILLY, AUDIO_CATEGORIES.MAIN, oExample.getCrossfade());
});

dbg_watch(ref_create(self, "debugMusicPlayed"), "Music Played");


dbg_section("UI Sound", false);
dbg_slider(ref_create(self, "uiVolumeOffset"), -1, 1, "Volume Offset");
dbg_slider(ref_create(self, "uiPitchOffset"), -1, 1, "Pitch Offset");
dbg_button("Play 'Hit'", function() {
    AudioEngineUIPlay(AUDIO_UI_SOUND.CLICK, AUDIO_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
});
dbg_button("Play 'Attack'", function() {
    AudioEngineUIPlay(AUDIO_UI_SOUND.ATTACK, AUDIO_CATEGORIES.MAIN, oExample.uiVolumeOffset, oExample.uiPitchOffset);
});

dbg_section("Playback", false);
dbg_watch(ref_create(self, "playing"), "Playing");
//playing: _system.playing
//dbg_section("Current music", false);

//ref_to_text = ref_create(currentMusicMulti, "text");

//dbg_text(ref_to_text);
