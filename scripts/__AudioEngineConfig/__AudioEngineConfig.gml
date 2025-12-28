function __AudioEngineConfig(){
	enum AUDIO_MUSIC {
		DECORATE,
		EXPLORE
	}
	
	enum AUDIO_MULTITRACK_STATE {
		CUTE,
		FESTIVE,
		SILLY,
	}	
	
	enum AUDIO_UI_SOUND {
		
	}
	
	enum AUDIO_GAME_SOUND {
		
	}	
		
	// Add your music here
	/* Parameters:
	 * _musicIndex: AUDIO_MUSIC
	 * _asset: asset or filename to a music file
	 * _volume: initial volume
	 */
	AudioEngineDefineMusic(AUDIO_MUSIC.DECORATE, Interior_Birdecorator_Decorate);
	
	/* Parameters:
	 * _musicIndex: AUDIO_MUSIC
	 * 
	 * _volume: initial volume
	 */
	AudioEngineDefineMultiTrackMusic(AUDIO_MUSIC.EXPLORE, [
		new AudioEngineTrack(Interior_Birdecorator_Explore_CUTE, AUDIO_MULTITRACK_STATE.CUTE),
		new AudioEngineTrack(Interior_Birdecorator_Explore_FESTIVE, AUDIO_MULTITRACK_STATE.FESTIVE),
		new AudioEngineTrack(Interior_Birdecorator_Explore_SILLY, AUDIO_MULTITRACK_STATE.SILLY),
	]);
	
	// Add your UI sounds here
	//AudioEngineDefineUISound();
	
	// Add your Game sounds here
	//AudioEngineDefineGameSound();
}