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
		
	}
	
	enum AUDIO_GAME_SOUND {
		
	}	
		
	// Add your music here
	AudioEngineDefineMusic(AUDIO_MUSIC.DECORATE, Interior_Birdecorator_Decorate);
	AudioEngineDefineMusic(AUDIO_MUSIC.MENU, "Interior Birdecorator Menu_LOOP.ogg");

	AudioEngineDefineMultiTrackMusic(AUDIO_MUSIC.EXPLORE, [
		new AudioEngineDefineTrack(Interior_Birdecorator_Explore_CUTE, AUDIO_MULTITRACK_MOOD.CUTE),
		new AudioEngineDefineTrack(Interior_Birdecorator_Explore_FESTIVE, AUDIO_MULTITRACK_MOOD.FESTIVE),
		new AudioEngineDefineTrack(Interior_Birdecorator_Explore_SILLY, AUDIO_MULTITRACK_MOOD.SILLY),
	]);
	
	// Add your UI sounds here
	//AudioEngineDefineUISound();
	
	// Add your Game sounds here
	//AudioEngineDefineGameSound();
}