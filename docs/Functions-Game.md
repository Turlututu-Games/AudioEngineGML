# Game

## AudioEngineGameEffectClear

`AudioEngineGameEffectClear([_effectIndex=0], [_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_effectIndex] | Real | Optional canal to clear the effect. Must be a number between 0 and 7. 0 by default |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Clear an effect from a game static category

<!-- tabs:end -->

&nbsp;


## AudioEngineGameEffectClearAll

`AudioEngineGameEffectClearAll([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Clear all effects from a game static category

<!-- tabs:end -->

&nbsp;


## AudioEngineGameEffectSet

`AudioEngineGameEffectSet(_effect, [_effectIndex=0], [_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _effect | Struct.AudioEffect | Effect to apply |
| [_effectIndex] | Real | Optional canal to apply the effect. Must be a number between 0 and 7. 0 by default |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Set an effect to a game static category

<!-- tabs:end -->

&nbsp;


## AudioEngineGamePause

`AudioEngineGamePause(_ref)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _ref | Id.Sound,Struct.__AESystemPlaying | Sound reference |

Pause a game sound

<!-- tabs:end -->

&nbsp;


## AudioEngineGamePauseCategory

`AudioEngineGamePauseCategory([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Pause all game static sounds from a category

<!-- tabs:end -->

&nbsp;


## AudioEngineGamePauseAllStatic

`AudioEngineGamePauseAllStatic()`

<!-- tabs:start -->

#### **Description**

Pause all game static sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGamePauseAllSpatialized

`AudioEngineGamePauseAllSpatialized()`

<!-- tabs:start -->

#### **Description**

Pause all game spatialized sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGamePauseAll

`AudioEngineGamePauseAll()`

<!-- tabs:start -->

#### **Description**

Pause all game sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGamePlay

`AudioEngineGamePlay(_gameSoundInstance, [_category=0], [_volumeOffset=0], [_pitchOffset=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct.__AESystemPlaying - Sound reference

|Name | Datatype | Purpose |
|---|---|---|
| _gameSoundInstance | Enum.AE_GAME_SOUND | Sound key |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |
| [_volumeOffset] | Real | Optional offset for the volume |
| [_pitchOffset] | Real | Optional offset for the pitch |

Play a game sound

<!-- tabs:end -->

&nbsp;


## AudioEngineGamePlayAt

`AudioEngineGamePlayAt(_gameSoundInstance, _x, _y, [_z=0], [_volumeOffset=0], [_pitchOffset=0], [_effects=[]])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct.__AESystemPlaying - Sound reference

|Name | Datatype | Purpose |
|---|---|---|
| _gameSoundInstance | Enum.AE_GAME_SOUND | Sound key |
| _x | Real | X position |
| _y | Real | Y position |
| [_z] | Real | Z position. Default to 0 |
| [_volumeOffset] | Real | Optional offset for the volume |
| [_pitchOffset] | Real | Optional offset for the pitch |
| [_effects] | Array<Struct.AudioEffect>,Struct.AudioEffect | Default effet or array of effects to apply to the sound |

Play a spatialized game sound at a position. Position do nothing for non-spatialized sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGamePlayAtObject

`AudioEngineGamePlayAtObject(_gameSoundInstance, _instance, [_z=0], [_volumeOffset=0], [_pitchOffset=0], [_effects=[]])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct.__AESystemPlaying - Sound reference

|Name | Datatype | Purpose |
|---|---|---|
| _gameSoundInstance | Enum.AE_GAME_SOUND | Sound key |
| _instance | Id.Instance,Asset.GMObject | Object instance used to get the position |
| [_z] | Real | Z position. Default to 0 |
| [_volumeOffset] | Real | Optional offset for the volume |
| [_pitchOffset] | Real | Optional offset for the pitch |
| [_effects] | Array<Struct.AudioEffect>,Struct.AudioEffect | Default effet or array of effects to apply to the sound |

Play a spatialized game sound at a position. Position do nothing for non-spatialized sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGamePosition

`AudioEngineGamePosition(_ref, _x, _y, [_z=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _ref | Id.Sound,Struct.__AESystemPlaying | Sound reference |
| _x | Real | X position |
| _y | Real | Y position |
| [_z] | Real | Z position. Default to 0 |

Change the position of an emitter

<!-- tabs:end -->

&nbsp;


## AudioEngineGamePositionAtObject

`AudioEngineGamePositionAtObject(_ref, _instance, [_z=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _ref | Id.Sound,Struct.__AESystemPlaying | Sound reference |
| _instance | Id.Instance,Asset.GMObject | Object instance used to get the position |
| [_z] | Real | Z position. Default to 0 |

Change the position of an emitter to match an object

<!-- tabs:end -->

&nbsp;


## AudioEngineGameResume

`AudioEngineGameResume(_ref)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _ref | Id.Sound,Struct.__AESystemPlaying | Sound reference |

Resume a game sound

<!-- tabs:end -->

&nbsp;


## AudioEngineGameResumeCategory

`AudioEngineGameResumeCategory([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Resume all game static sounds from a category

<!-- tabs:end -->

&nbsp;


## AudioEngineGameResumeAllStatic

`AudioEngineGameResumeAllStatic()`

<!-- tabs:start -->

#### **Description**

Resume all game static sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGameResumeAllSpatialized

`AudioEngineGameResumeAllSpatialized()`

<!-- tabs:start -->

#### **Description**

Resume all game spatialized sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGameResumeAll

`AudioEngineGameResumeAll()`

<!-- tabs:start -->

#### **Description**

Resume all game sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGameStop

`AudioEngineGameStop(_ref)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _ref | Id.Sound,Struct.__AESystemPlaying | Sound reference |

Stop a game sound

<!-- tabs:end -->

&nbsp;


## AudioEngineGameStopCategory

`AudioEngineGameStopCategory([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Stop game static sounds from a category

<!-- tabs:end -->

&nbsp;


## AudioEngineGameStopAllStatic

`AudioEngineGameStopAllStatic()`

<!-- tabs:start -->

#### **Description**

Stop all game static sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGameStopAllSpatialized

`AudioEngineGameStopAllSpatialized()`

<!-- tabs:start -->

#### **Description**

Stop all game spatialized sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGameStopAll

`AudioEngineGameStopAll()`

<!-- tabs:start -->

#### **Description**

Stop all game sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineGameSetVolume

`AudioEngineGameSetVolume(_newVolume)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _newVolume | Real | New Volume |

Set the global music volume

<!-- tabs:end -->

&nbsp;


## AudioEngineGameSetSpatializedVolume

`AudioEngineGameSetSpatializedVolume(_newVolume)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _newVolume | Real | New Volume |

Set the global music volume

<!-- tabs:end -->

&nbsp;


## AudioEngineGameSetStaticVolume

`AudioEngineGameSetStaticVolume(_newVolume, [_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _newVolume | Real | New Volume |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Set the music volume for a category

<!-- tabs:end -->

&nbsp;


## AudioEngineGameStaticGetCategoryVolume

`AudioEngineGameStaticGetCategoryVolume([_category=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real - Category volume

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Get the music volume for a category

<!-- tabs:end -->

&nbsp;


