crossfade = false;
//volume = 1;
crossfadeValue = 5000;

getCrossfade = function() {
    return crossfade ? crossfadeValue : 0;
};

currentMusicAsset = "currentMusicAsset: ";
currentMusicAssets = "currentMusicAssets: ";
currentMusicGroup = "currentMusicGroup: ";
currentMusicIsSteam = "currentMusicIsSteam: ";
currentMusicMulti = "currentMusicMulti: ";

dbg_view("AudioEngineGML Demo", true);



dbg_section("Music");
dbg_checkbox(ref_create(self, "crossfade"), "Crossfade Music");

dbg_slider(ref_create(self, "crossfadeValue"), 0, 10_000, "Crossfade Time (ms)");

dbg_button("Stop Music", function() {
    AudioEngineStopMusic(oExample.getCrossfade());
});
dbg_button("Play Solo Track", function() {
    AudioEnginePlayMusic(AUDIO_MUSIC.DECORATE, oExample.getCrossfade());
});
dbg_button("Play Multi Track", function() {
    AudioEnginePlayMusic(AUDIO_MUSIC.EXPLORE, oExample.getCrossfade());
});

dbg_button("State : Cute", function() {
    AudioEngineSetStateMusic(AUDIO_MULTITRACK_STATE.CUTE, oExample.getCrossfade());
});
dbg_same_line();
dbg_button("State : Festive", function() {
    AudioEngineSetStateMusic(AUDIO_MULTITRACK_STATE.FESTIVE, oExample.getCrossfade());
});
dbg_same_line();
dbg_button("State : Silly", function() {
    AudioEngineSetStateMusic(AUDIO_MULTITRACK_STATE.SILLY, oExample.getCrossfade());
});

//dbg_section("Current music", false);

//ref_to_text = ref_create(currentMusicMulti, "text");

//dbg_text(ref_to_text);
