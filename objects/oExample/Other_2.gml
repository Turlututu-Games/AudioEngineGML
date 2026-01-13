event_user(0);

// Normally, calling define functions after initialization is forbidden,
// but for keeping the example configuration clean, the definition of sounds are done here

// Don't do that at home!

var _system = __AudioEngineSystem();

_system.initialized = false;

AudioEngineDefineMusic(AE_MUSIC_DECORATE, Interior_Birdecorator_Decorate, {volume: 0.8});
AudioEngineDefineMusic(AE_MUSIC_MENU, "Interior Birdecorator Menu_LOOP.ogg");
AudioEngineDefineMusic(AE_MUSIC_RIVER_SOUNDSCAPE, Ambiance_River_Moderate_Loop_Stereo)

AudioEngineDefineMultiTrackMusic(AE_MUSIC_EXPLORE, [
    new AudioEngineDefineTrack(Interior_Birdecorator_Explore_CUTE, AE_MULTITRACK_MOOD_CUTE),
    new AudioEngineDefineTrack(Interior_Birdecorator_Explore_FESTIVE, AE_MULTITRACK_MOOD_FESTIVE),
    new AudioEngineDefineTrack(Interior_Birdecorator_Explore_SILLY, AE_MULTITRACK_MOOD_SILLY),
]);

AudioEngineDefineUISound(AE_UI_SOUND_CLICK, Household_Closet_Key_Insertion_Stereo);
AudioEngineDefineUISoundArray(AE_UI_SOUND_ATTACK, [
    Voice_Male_V1_Attack_Mono_01,
    Voice_Male_V1_Attack_Mono_02,
    Voice_Male_V1_Attack_Mono_03,
    Voice_Male_V1_Attack_Mono_04,
    Voice_Male_V1_Attack_Mono_05,
    Voice_Male_V1_Attack_Mono_06,
    Voice_Male_V1_Attack_Mono_07,
    Voice_Male_V1_Attack_Mono_08,
]);
AudioEngineDefineUISound(AE_UI_SOUND_COUGH, "Voice_Male_V1_Cough_Multiple_Mono_04.ogg");
AudioEngineDefineUISound(AE_UI_SOUND_CLICK_VARIANCE, Household_Closet_Key_Insertion_Stereo, { pitchVariance: 0.2, volumeVariance: 0.3 });
AudioEngineDefineUISound(AE_UI_SOUND_RIVER_SOUNDSCAPE, Ambiance_River_Moderate_Loop_Stereo)

AudioEngineDefineGameSound(AE_GAME_SOUND_WIPER, Vehicle_Car_Wiper_Exterior_Loop_Mono, { loop: true, cleanOnRoomEnd: false });
AudioEngineDefineGameSound(AE_GAME_SOUND_ENGINE, Vehicle_Car_Engine_Idle_Exterior_Loop_Mono_01, { loop: true, spatialized: true });
AudioEngineDefineGameSoundArray(AE_GAME_SOUND_START_ENGINE, [Vehicle_Car_Start_Engine_Exterior_Mono, "Vehicle_Car_Start_Engine_Exterior_Mono.ogg"]);
AudioEngineDefineGameSound(AE_GAME_SOUND_WARNING, Vehicle_Car_Warning_Interior_Loop_Mono_01, { spatialized: true });
AudioEngineDefineGameSound(AE_GAME_SOUND_RIVER, Ambiance_River_Moderate_Loop_Stereo, { loop: true, spatialized: true });

// Invalid define, to test how exception are managed
AudioEngineDefineMusic(AE_MUSIC_INVALID1, sEmitter); // Not a sound
AudioEngineDefineMusic(AE_MUSIC_INVALID2, "test.md"); // Not a valid stream
AudioEngineDefineMusic(AE_MUSIC_INVALID2, "test2.md"); // Not exists
AudioEngineDefineMusic(AE_MUSIC_INVALID1, Interior_Birdecorator_Decorate, { invalid: true});  // Invalid option
AudioEngineDefineMusic(AE_MUSIC_INVALID1, Interior_Birdecorator_Decorate, { priority: "1", volume: false});  // Invalid types
AudioEngineDefineMusic(AE_MUSIC_INVALID1, Interior_Birdecorator_Decorate, { priority: -1, volume: 5});  // Invalid values

_system.initialized = true;