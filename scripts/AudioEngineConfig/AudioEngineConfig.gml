#macro __AUDIOENGINE_MUSIC_DEFAULT_FADE  0

/// @desc Configure AudioEngine
function __AudioEngineConfig() {
	
	enum AUDIO_CATEGORIES {
		MAIN
	}
	
	enum AUDIO_MUSIC {
		DECORATE,
		EXPLORE,
		MENU
	}
	
	enum AUDIO_MULTITRACK_MOOD {
		CUTE,
		FESTIVE,
		SILLY,
	}	
	
	enum AUDIO_UI_SOUND {
		CLICK,
		ATTACK,
	}
	
	enum AUDIO_GAME_SOUND {
		
	}	
		
	// Add your music here
	AudioEngineDefineMusic(AUDIO_MUSIC.DECORATE, Interior_Birdecorator_Decorate, {volume: 0.8});
	AudioEngineDefineMusic(AUDIO_MUSIC.MENU, "Interior Birdecorator Menu_LOOP.ogg");

	AudioEngineDefineMultiTrackMusic(AUDIO_MUSIC.EXPLORE, [
		new AudioEngineDefineTrack(Interior_Birdecorator_Explore_CUTE, AUDIO_MULTITRACK_MOOD.CUTE),
		new AudioEngineDefineTrack(Interior_Birdecorator_Explore_FESTIVE, AUDIO_MULTITRACK_MOOD.FESTIVE),
		new AudioEngineDefineTrack(Interior_Birdecorator_Explore_SILLY, AUDIO_MULTITRACK_MOOD.SILLY),
	]);
	
	// Add your UI sounds here
	AudioEngineDefineUISound(AUDIO_UI_SOUND.CLICK, Household_Closet_Key_Insertion_Stereo);
	AudioEngineDefineUISoundArray(AUDIO_UI_SOUND.ATTACK, [
		Voice_Male_V1_Attack_Mono_01,
		Voice_Male_V1_Attack_Mono_02,
		Voice_Male_V1_Attack_Mono_03,
		Voice_Male_V1_Attack_Mono_04,
		Voice_Male_V1_Attack_Mono_05,
		Voice_Male_V1_Attack_Mono_06,
		Voice_Male_V1_Attack_Mono_07,
		Voice_Male_V1_Attack_Mono_08,
	]);
	
	// Add your Game sounds here
	//AudioEngineDefineGameSound();
}