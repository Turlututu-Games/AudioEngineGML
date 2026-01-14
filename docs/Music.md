# Music

Music type of sound are designed to run in loop, and persist accross room

When a music start on a channel, it automatically stops the previous music. It can also use a crossfading effect to smooth the change

Two types of music can be configured: Basic musics and multi-track musics

Multi-track musics use something called `mood`. The `moods` indicate which tracks of the multi-track will be played.

For example, you have configured a multi-track like this : 
```gml
AudioEngineDefineMultiTrackMusic(AE_MUSIC.EXPLORE, [
    new AudioEngineDefineTrack(musicAssetCute, AE_MULTITRACK_MOOD.CUTE),
    new AudioEngineDefineTrack(musicAssetFestive, AE_MULTITRACK_MOOD.FESTIVE),
    new AudioEngineDefineTrack(musicAssetSilly, AE_MULTITRACK_MOOD.SILLY),
]);
```

You can now decide to play the `AE_MULTITRACK_MOOD.CUTE` track, the `AE_MULTITRACK_MOOD.FESTIVE` or even `AE_MULTITRACK_MOOD.CUTE` and `AE_MULTITRACK_MOOD.SILLY` at the same time.

If you have crossfading configured, changing the mood will apply the crossfading too

Not every multi-track musics need to use each `moods`, and the `moods` persist when switching to another multi-track music