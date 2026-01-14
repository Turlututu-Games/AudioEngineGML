# Binding

The library use enum to map a sound with a particular id, and with a specific context and parameters

This allow an easy use of the library, where, after configuring all your sound assets, you'll just need to call the corresponding function with the sound id

```gml
// Play the menu music
AudioEngineMusicPlay(AE_MUSIC.MENU);
```

The library also provide multi-channel supports, allowing to play, for example, two music on the same time

```gml
// Play the menu music
AudioEngineMusicPlay(AE_MUSIC.MENU);

// Play another music on a secondary channel
AudioEngineMusicPlay(AE_MUSIC.JUKBOX, AE_CATEGORIES.SECONDARY);
```

A sound can be a GameMaker asset, or a path to a external sounds that will be streamed. The library take care of clean-up for that!

Each type of sound has differents capability, listed on the next pages