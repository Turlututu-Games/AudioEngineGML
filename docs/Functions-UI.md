# UI

## AudioEngineUIEffectClear

`AudioEngineUIEffectClear([_effectIndex=0], [_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_effectIndex] | Real | Optional canal to clear the effect. Must be a number between 0 and 7. 0 by default |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Clear a music effect from a ui category

<!-- tabs:end -->

&nbsp;


## AudioEngineUIEffectClearAll

`AudioEngineUIEffectClearAll([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Clear all effects from a ui category

<!-- tabs:end -->

&nbsp;


## AudioEngineUIEffectSet

`AudioEngineUIEffectSet(_effect, [_effectIndex=0], [_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _effect | Struct.AudioEffect | Effect to apply |
| [_effectIndex] | Real | Optional canal to apply the effect. Must be a number between 0 and 7. 0 by default |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Set an effect to a ui category

<!-- tabs:end -->

&nbsp;


## AudioEngineUIGetCategoryVolume

`AudioEngineUIGetCategoryVolume([_category=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real - Category volume

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Get the music volume for a category

<!-- tabs:end -->

&nbsp;


## AudioEngineUIPause

`AudioEngineUIPause(_ref)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _ref | Id.Sound,Struct.__AESystemPlaying | Sound reference |

Pause a ui sound

<!-- tabs:end -->

&nbsp;


## AudioEngineUIPauseAll

`AudioEngineUIPauseAll()`

<!-- tabs:start -->

#### **Description**

Pause all ui sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineUIPauseCategory

`AudioEngineUIPauseCategory([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Pause all ui sounds from a category

<!-- tabs:end -->

&nbsp;


## AudioEngineUIPlay

`AudioEngineUIPlay(_uiSoundInstance, [_category=0], [_volumeOffset=0], [_pitchOffset=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct.__AESystemPlaying - Sound reference

|Name | Datatype | Purpose |
|---|---|---|
| _uiSoundInstance | Enum.AE_UI_SOUND | Sound key |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |
| [_volumeOffset] | Real | Optional offset for the volume |
| [_pitchOffset] | Real | Optional offset for the pitch |

Play a ui sound

<!-- tabs:end -->

&nbsp;


## AudioEngineUIResume

`AudioEngineUIResume(_ref)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _ref | Id.Sound,Struct.__AESystemPlaying | Sound reference |

Resume a ui sound

<!-- tabs:end -->

&nbsp;


## AudioEngineUIResumeAll

`AudioEngineUIResumeAll()`

<!-- tabs:start -->

#### **Description**

Pause all ui sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineUIResumeCategory

`AudioEngineUIResumeCategory([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Resume all ui sounds from a category

<!-- tabs:end -->

&nbsp;


## AudioEngineUISetCategoryVolume

`AudioEngineUISetCategoryVolume(_newVolume, [_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _newVolume | Real | New Volume |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Set the music volume for a category

<!-- tabs:end -->

&nbsp;


## AudioEngineUISetVolume

`AudioEngineUISetVolume(_newVolume)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _newVolume | Real | New Volume |

Set the global music volume

<!-- tabs:end -->

&nbsp;


## AudioEngineUIStop

`AudioEngineUIStop(_ref)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _ref | Id.Sound,Struct.__AESystemPlaying | Sound reference |

Stop a ui sound

<!-- tabs:end -->

&nbsp;


## AudioEngineUIStopAll

`AudioEngineUIStopAll()`

<!-- tabs:start -->

#### **Description**

Stop all ui sounds

<!-- tabs:end -->

&nbsp;


## AudioEngineUIStopCategory

`AudioEngineUIStopCategory([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Stop ui sounds from a category

<!-- tabs:end -->

&nbsp;


