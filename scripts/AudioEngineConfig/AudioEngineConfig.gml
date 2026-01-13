#macro __AUDIOENGINE_MUSIC_DEFAULT_FADE  0

/// @desc Configure AudioEngine
/// @return {Undefined}
function __AudioEngineConfig() {

    // Add your music here
    AudioEngineDefineMusic(AE_MUSIC.DECORATE, Interior_Birdecorator_Decorate, {volume: 0.8});
    AudioEngineDefineMusic(AE_MUSIC.MENU, "Interior Birdecorator Menu_LOOP.ogg");
    AudioEngineDefineMusic(AE_MUSIC.RIVER_SOUNDSCAPE, Ambiance_River_Moderate_Loop_Stereo)

    AudioEngineDefineMultiTrackMusic(AE_MUSIC.EXPLORE, [
        new AudioEngineDefineTrack(Interior_Birdecorator_Explore_CUTE, AE_MULTITRACK_MOOD.CUTE),
        new AudioEngineDefineTrack(Interior_Birdecorator_Explore_FESTIVE, AE_MULTITRACK_MOOD.FESTIVE),
        new AudioEngineDefineTrack(Interior_Birdecorator_Explore_SILLY, AE_MULTITRACK_MOOD.SILLY),
    ]);

    // Add your UI sounds here
    AudioEngineDefineUISound(AE_UI_SOUND.CLICK, Household_Closet_Key_Insertion_Stereo);
    AudioEngineDefineUISoundArray(AE_UI_SOUND.ATTACK, [
        Voice_Male_V1_Attack_Mono_01,
        Voice_Male_V1_Attack_Mono_02,
        Voice_Male_V1_Attack_Mono_03,
        Voice_Male_V1_Attack_Mono_04,
        Voice_Male_V1_Attack_Mono_05,
        Voice_Male_V1_Attack_Mono_06,
        Voice_Male_V1_Attack_Mono_07,
        Voice_Male_V1_Attack_Mono_08,
    ]);
    AudioEngineDefineUISound(AE_UI_SOUND.COUGH, "Voice_Male_V1_Cough_Multiple_Mono_04.ogg");
    AudioEngineDefineUISound(AE_UI_SOUND.CLICK_VARIANCE, Household_Closet_Key_Insertion_Stereo, { pitchVariance: 0.2, volumeVariance: 0.3 });
    AudioEngineDefineUISound(AE_UI_SOUND.RIVER_SOUNDSCAPE, Ambiance_River_Moderate_Loop_Stereo)

    // Add your Game sounds here
    AudioEngineDefineGameSound(AE_GAME_SOUND.WIPER, Vehicle_Car_Wiper_Exterior_Loop_Mono, { loop: true, cleanOnRoomEnd: false });
    AudioEngineDefineGameSound(AE_GAME_SOUND.ENGINE, Vehicle_Car_Engine_Idle_Exterior_Loop_Mono_01, { loop: true, spatialized: true });
    AudioEngineDefineGameSoundArray(AE_GAME_SOUND.START_ENGINE, [Vehicle_Car_Start_Engine_Exterior_Mono, "Vehicle_Car_Start_Engine_Exterior_Mono.ogg"]);
    AudioEngineDefineGameSound(AE_GAME_SOUND.WARNING, Vehicle_Car_Warning_Interior_Loop_Mono_01, { spatialized: true });
    AudioEngineDefineGameSound(AE_GAME_SOUND.RIVER, Ambiance_River_Moderate_Loop_Stereo, { loop: true, spatialized: true });
}