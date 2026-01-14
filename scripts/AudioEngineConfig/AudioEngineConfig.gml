// Crossfading length, in milliseconds
#macro __AUDIOENGINE_MUSIC_DEFAULT_FADE  0

// If true, stream will be checked on run mode
#macro __AUDIOENGINE_DEBUG_CHECK_STREAM false

/// @desc Configure AudioEngine
/// @module Configuration
/// @return {Undefined}
function __AudioEngineConfig() {
	
	#region Logger configuration (Optional)
	//AudioEngineLoggerSetTarget(AE_LOGGER_TARGET.SNITCH);
	//AudioEngineLoggerSetLogLevel(AE_LOGGER_LEVEL.ERROR);
	#endregion

    #region Add your music here
    // Simple music with slightly reduced volume
    //AudioEngineDefineMusic(AE_MUSIC.DECORATE, Interior_Birdecorator_Decorate, {volume: 0.8});

    // Music streamed from included file
    //AudioEngineDefineMusic(AE_MUSIC.MENU, "Interior Birdecorator Menu_LOOP.ogg");

    // Multi-track music with three moods
    /*AudioEngineDefineMultiTrackMusic(AE_MUSIC.EXPLORE, [
        new AudioEngineDefineTrack(Interior_Birdecorator_Explore_CUTE, AE_MULTITRACK_MOOD.CUTE),
        new AudioEngineDefineTrack(Interior_Birdecorator_Explore_FESTIVE, AE_MULTITRACK_MOOD.FESTIVE),
        new AudioEngineDefineTrack(Interior_Birdecorator_Explore_SILLY, AE_MULTITRACK_MOOD.SILLY),
    ]);*/

    #endregion

    #region Add your UI sounds here
    // Simple UI sound
    //AudioEngineDefineUISound(AE_UI_SOUND.CLICK, Household_Closet_Key_Insertion_Stereo);

    // Sound array with random selection
    /*AudioEngineDefineUISoundArray(AE_UI_SOUND.ATTACK, [
        Voice_Male_V1_Attack_Mono_01,
        Voice_Male_V1_Attack_Mono_02,
        Voice_Male_V1_Attack_Mono_03,
        Voice_Male_V1_Attack_Mono_04,
        Voice_Male_V1_Attack_Mono_05,
        Voice_Male_V1_Attack_Mono_06,
        Voice_Male_V1_Attack_Mono_07,
        Voice_Male_V1_Attack_Mono_08,
    ]);*/

    // UI sound streamed from included file
    //AudioEngineDefineUISound(AE_UI_SOUND.COUGH, "Voice_Male_V1_Cough_Multiple_Mono_04.ogg");

    // UI sound with volume and pitch randomness
    //AudioEngineDefineUISound(AE_UI_SOUND.CLICK_VARIANCE, Household_Closet_Key_Insertion_Stereo, { pitchVariance: 0.2, volumeVariance: 0.3 });
    #endregion

    #region Add your Game sounds here

    // Game sound looping, not cleaned on room_end
    //AudioEngineDefineGameSound(AE_GAME_SOUND.WIPER, Vehicle_Car_Wiper_Exterior_Loop_Mono, { loop: true, cleanOnRoomEnd: false });

    // Spatialized looped sound
    //AudioEngineDefineGameSound(AE_GAME_SOUND.ENGINE, Vehicle_Car_Engine_Idle_Exterior_Loop_Mono_01, { loop: true, spatialized: true });

    // Game sound streamed from included file
    //AudioEngineDefineGameSoundArray(AE_GAME_SOUND.START_ENGINE, [Vehicle_Car_Start_Engine_Exterior_Mono, "Vehicle_Car_Start_Engine_Exterior_Mono.ogg"]);

    // Simple spatialized sound
    //AudioEngineDefineGameSound(AE_GAME_SOUND.WARNING, Vehicle_Car_Warning_Interior_Loop_Mono_01, { spatialized: true });

    #endregion

}