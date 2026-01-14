# Configuration

## __AudioEngineConfig

`__AudioEngineConfig()`

<!-- tabs:start -->

#### **Description**

Configure AudioEngine

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineMusicOptions

`AudioEngineDefineMusicOptions([_priority=1], [_volume=1])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_priority] | Real | Sound Priority |
| [_volume] | Real | Initial _volume |

Options for a single-track music

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineMusic

`AudioEngineDefineMusic(_musicIndex, _asset, [_options={}])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _musicIndex | Enum.AE_MUSIC | Music index |
| _asset | Asset.GMSound,String | Sound asset |
| [_options] | Struct.AudioEngineDefineMusicOptions | Options |

Define a single-track music

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineTrack

`AudioEngineDefineTrack(_asset, _mood, [_volume=1])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _asset | Asset.GMSound,String | Sound asset |
| _mood | Enum.AE_MULTITRACK_MOOD | Music Mood |
| [_volume] | Real | Initial volume |

Define a track for multi-track music

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineMultiTrackOptions

`AudioEngineDefineMultiTrackOptions([_priority=1])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_priority] | Real | Sound Priority |

Options for a multi-track music

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineMultiTrackMusic

`AudioEngineDefineMultiTrackMusic(_musicIndex, _tracks, [_options={}])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _musicIndex | Enum.AE_MUSIC | Music index |
| _tracks | Array<Struct.AudioEngineDefineTrack> | Array of tracks |
| [_options] | Struct.AudioEngineDefineMultiTrackOptions | Options |

Define a multi-track music

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineUISoundOptions

`AudioEngineDefineUISoundOptions([_priority=1], [_volume=1], [_volumeVariance=0], [_pitch=1], [_pitchVariance=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_priority] | Real | Sound Priority |
| [_volume] | Real | Initial volume |
| [_volumeVariance] | Real | Random volume variance |
| [_pitch] | Real | Initial pitch |
| [_pitchVariance] | Real | Random pitch variance |

Options for a UI sound

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineUISound

`AudioEngineDefineUISound(_uiSoundIndex, _asset, [_options={}])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _uiSoundIndex | Enum.AE_UI_SOUND | UI sound index |
| _asset | Asset.GMSound,String | Sound asset |
| [_options] | Struct.AudioEngineDefineUISoundOptions | Options |

Define a UI sound

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineUISoundArray

`AudioEngineDefineUISoundArray(_uiSoundIndex, _assets, [_options={}])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _uiSoundIndex | Enum.AE_UI_SOUND | UI sound index |
| _assets | Array<Asset.GMSound,String> | Array of sound assets |
| [_options] | Struct.AudioEngineDefineUISoundOptions | Options |

Define a UI sound

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineGameSoundOptions

`AudioEngineDefineGameSoundOptions([_loop=false], [_cleanOnRoomEnd=true], [_spatialized=false], [_priority=1], [_volume=1], [_volumeVariance=0], [_pitch=1], [_pitchVariance=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_loop] | Bool | Indicate if the sound is a loop |
| [_cleanOnRoomEnd] | Bool | The sound will be cleaned on room_end event |
| [_spatialized] | Bool | Indicate if the sound is spatialized |
| [_priority] | Real | Sound Priority |
| [_volume] | Real | Initial volume |
| [_volumeVariance] | Real | Random volume variance |
| [_pitch] | Real | Initial pitch |
| [_pitchVariance] | Real | Random pitch variance |

Options for a Game sound

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineGameSound

`AudioEngineDefineGameSound(_gameSoundIndex, _asset, [_options={}])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _gameSoundIndex | Enum.AE_GAME_SOUND | Game sound index |
| _asset | Asset.GMSound|String | Sound asset |
| [_options] | Struct.AudioEngineDefineGameSoundOptions | Options |

Define a Game sound

<!-- tabs:end -->

&nbsp;


## AudioEngineDefineGameSoundArray

`AudioEngineDefineGameSoundArray(_gameSoundIndex, _assets, [_options={}])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _gameSoundIndex | Enum.AE_GAME_SOUND | Game sound index |
| _assets | Array<Asset.GMSound,String> | Array of sound assets |
| [_options] | Struct.AudioEngineDefineGameSoundOptions | Options |

Define a Game sound

<!-- tabs:end -->

&nbsp;


## AudioEngineLoggerSetLogLevel

`AudioEngineLoggerSetLogLevel(_level)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _level | Enum.AE_LOGGER_LEVEL | Logger level |

Set Logger Level

#### **Example**

```gml
@example AudioEngineLoggerSetLogLevel(AE_LOGGER_LEVEL.ERROR);
```

<!-- tabs:end -->

&nbsp;


## AudioEngineLoggerSetTarget

`AudioEngineLoggerSetTarget(_target, _errorCallback, _warningCallback, _verboseCallback)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _target | Enum.AE_LOGGER_TARGET | Logger target |
| _errorCallback | Function,Undefined | Error callback |
| _warningCallback | Function,Undefined | Warning callback |
| _verboseCallback | Function,Undefined | Verbose callback |

Set Logger Target

#### **Example**

```gml
@example AudioEngineLoggerSetTarget(AE_LOGGER_TARGET.SNITCH);
```

<!-- tabs:end -->

&nbsp;


