--// Profile Service

--[=[
@class ProfileService

A useful datastore wrapper which allows for things such as session locking and global updates.
 [Download](https://create.roblox.com/store/asset/5331689994/ProfileService?externalSource=www) and [API](https://madstudioroblox.github.io/ProfileService/api/) links are available here.
 Please note that most of the content in these pages is paraphrased from the afforementioned API page, check that out for a more in-depth look.
 This is also a library which I didn't make, it simply has its own category due to having multiple components.
]=]

--[=[
@interface profile_store_index_table
@within ProfileService
.Name string -- The name of the DataStore, required
.Scope string? -- The scope used to search, optional, defaults to global

A table specifying a DataStore name, and an optional scope
]=]

--[=[
@prop ServiceLocked boolean
@within ProfileService
@readonly

A read-only property which indicates if the server is shutting down, if it is [ProfileStore](/api/ProfileStore) methods shouldnt be used anymore.
]=]

--[=[
@prop IssueSignal RBXScriptSignal
@within ProfileService
@readonly

An analytics endpoint for error logging. This uses a scripted implementation of an RBXScriptSignal, so not all methods may be available.
```lua
-- Example:
ProfileService.IssueSignal:Connect(function(error_message, profile_store_name, profile_key)
    pcall(function()
        AnalyticsService:FireEvent(
            "ProfileServiceIssue",
            error_message,
            profile_store_name,
            profile_key
        )
    end)
end)
```
:::info
The RBXScriptSignal parses a string representing the error message, a string for the profile store name, and lastly a string for the profile key.
:::
]=]

--[=[
@prop CorruptionSignal RBXScriptSignal
@within ProfileService
@readonly

An analytics endpoint for when a DataStore key returns invalid profile compontents. This uses a scripted implementation of an RBXScriptSignal, so not all methods may be available.
:::info
The RBXScriptSignal parses a string representing the profile store name, and a string for the profile key.
:::
]=]

--[=[
@prop CriticalStateSignal RBXScriptSignal
@within ProfileService
@readonly

An analytics endpoint for when too many errors are thrown, and it is likely affecting the game. This uses a scripted implementation of an RBXScriptSignal, so not all methods may be available.
:::info
The RBXScriptSignal parses a boolean for if it is a critical state or not.
:::
]=]

--[=[
@function GetProfileStore
@within ProfileService

@param profile_store_index string | profile_store_index_table -- The name of the profile store
@param profile_template DataTemplate -- The template used when the player has no previous data

@return ProfileStore -- The profile store with the given Name and Scope
]=]




--// Profile Store




--[=[
@class ProfileStore

The ProfileService equivalent of a DataStore, allowing you to interact with [Profiles](/api/Profile) under the ProfileStore
]=]

--[=[
@type not_released_handler_function (place_id: number, game_job_id: number) -> ("Repeat", "Cancel", "ForceLoad", "Steal")
@within ProfileStore

A function used to determine what to do when a profile which was attempted to be loaded is session locked.
- ```Repeat``` will try load the profile again, potentially recalling this function.
- ```Cancel``` will return nil to the caller.
- ```ForceLoad``` will constantly try load the profile, if a session lock is present it will be released or stolen.
- ```Steal``` will load the profile regardless of the session lock, and can be used to clear dead session locks.

:::caution
Steal should usually only be used when the server holding a session lock has been crashed.
:::
]=]

--[=[
@type global_update_handler (global_updates) -> nil
@within ProfileStore

A function used when globally updating a [profile](/api/Profile). It is passed a global_updates object, and is expected to add the update itself.
:::warning
Yielding inside a global_update_handler will cause it to error.
:::
]=]

--[=[
@prop Mock ProfileStore
@within ProfileStore
@readonly
```ProfileStore.Mock``` is a mock-copy of methods available within a ```ProfileStore```, with the exception that profile operations are performed on
 "fake" DataStores, and are forgotten once the game ends. You may load profiles of the same key from ```ProfileStore``` and ```ProfileStore.Mock```
 in parallel, as they will be two completely different profiles since regular and mock profile stores are completely isolated from each other.

```ProfileStore.Mock``` is useful for customizing your testing environment in cases when you want to
 [enable Roblox API services](https://create.roblox.com/docs/cloud-services/data-stores#enabling-studio-access) in studio, but
 don't want ProfileService to save to live keys.

```lua
-- Example
local RunService = game:GetService("RunService")
local GameProfileStore = ProfileService.GetProfileStore("PlayerData", ProfileTemplate)
if RunService:IsStudio() == true then
  GameProfileStore = GameProfileStore.Mock
end
```

A few more things:
- Even when Roblox API services are disabled, ```ProfileStore``` and ```ProfileStore.Mock``` will store profiles in seperate locations.
- It's better to thing of ```ProfileStore``` and ```ProfileStore.Mock``` as two different ```ProfileStore``` instances unrelated to each other in any way.
- It's possible to create a project that utilizes both live and mock profiles on live servers!

]=]

--[=[
@method LoadProfileAsync
@within ProfileStore
@yields

@param profile_key string -- The key for the profile, should be unique to the player if it is being loaded for a player
@param not_released_handler not_released_handler_function --  The handler for if the profile is session locked

@return Profile? -- Returns the profile which has been loaded or nil if it was canceled in the not_released_handler.

```lua
local Profile = ProfileStore:LoadProfileAsync(
    "Player_2312310",
    function(place_id, game_job_id)
      -- place_id and game_job_id identify the Roblox server that has
      -- this profile currently locked. In rare cases, if the server
      -- crashes, the profile will stay locked until ForceLoaded by
      -- a new session.
      return "Repeat" or "Cancel" or "ForceLoad" or "Steal"
    end
  )
```
:::info
[ProfileService](/api/ProfileService) saves [profiles](/api/Profile) to live [DataStore](https://create.roblox.com/docs/cloud-services/data-stores)
 keys in [Roblox Studio](https://create.roblox.com/docs/studio)
 when [Roblox API services are enabled](https://create.roblox.com/docs/cloud-services/data-stores#enabling-studio-access). See [```ProfileStore.Mock```](#Mock) if saving to live keys during testing is not desired.
:::
:::caution
```:LoadProfileAsync()``` can return ```nil``` when another remote Roblox server attempts to load the profile at the same time.
 This case should be extremely rare and it wouldn't be recommended to [```:Kick()```](https://create.roblox.com/docs/reference/engine/classes/Player#Kick)
 the player if ```:LoadProfileAsync()``` doesn't return a [Profile](/api/Profile).
:::
:::warning
Trying to load a [profile](/api/Profile) that has already been session-locked on the same server will result in an error. You may, 
however, instantly load the profile again after releasing it with [```Profile:Release()```](/api/Profile#Release).
:::
]=]

--[=[
@method GlobalUpdateProfileAsync
@within ProfileStore
@yields

@param profile_key string -- The key used to identify the profile
@param update_handler global_update_handler -- The global_update_handler used to update the Profile

@return global_updates? -- Returns either a global_updates object or nil

Used to create and manage ```active``` global updates for profiles. It can be called on any Roblox server and updates can be expected within 30 seconds, regardless of whether it was called on the same server the profile is on or not.
 Refer to [Global Updates](https://madstudioroblox.github.io/ProfileService/api/#global-updates) for more info.

```lua
-- Example usage
ProfileStore:GlobalUpdateProfileAsync(
    "Player_2312310",
    function(global_updates)
      global_updates:AddActiveUpdate({
        Type = "AdminGift",
        Item = "Coins",
        Amount = 1000,
      })
    end
  )
```
:::warning
Avoid rapid usage of this function as it can cause dead session locks and loss of data. Read [The Official Documentation](https://madstudioroblox.github.io/ProfileService/api/#profilestoreglobalupdateprofileasync)
 for more info
:::
]=]

--[=[
@method ViewProfileAsync
@within ProfileStore
@yields

@param profile_key string -- The key used to identify the profile
@param version string? -- The version to view, or nil for the current version

@return Profile? -- Returns either a profile or nil
:::info
Passing ```version``` to a mock or offline profile will throw an error as Mock versioning isn't supported.
:::

Attempts to load either the latest version of a profile or the specified version if one is passed without creating a session-lock. Returns ```nil``` if the specified version doesn't exist. The returned [```Profile```](/api/Profile)
 won't auto-save, and releasing won't do anything. The data in the returned [```Profile```](/api/Profile) can be changed to create a payload for [```Profile:OverwriteAsync()```](/api/Profile#OverwriteAsync).

```:ViewProfileAsync()``` is the prefered way of viewing profile data without editing it.
]=]

--[=[
@method ProfileVersionQuery
@within ProfileStore
@yields

@param profile_key string -- The key used to identify the profile
@param sort_direction SortDirection -- The sort direction to use, defaults to [Enum.SortDirection.Ascending](https://create.roblox.com/docs/reference/engine/enums/SortDirection)
@param min_date DateTime? | number? -- The minimum date used, when number is provided it is assumed to be in milliseconds
@param max_date DateTime? | number? -- the maximum date used, when number is provided it is assumed to be in milliseconds

@return ProfileVersionQuery -- Returns a [profile version query](https://madstudioroblox.github.io/ProfileService/api/#profilestoreprofileversionquery) (I will not be documenting this myself)

Creates a ProfileVersionQuery for the specified profile, please refer to the [official documentation](https://madstudioroblox.github.io/ProfileService/api/#profilestoreprofileversionquery)
 for a more indepth explanation of this function
]=]

--[=[
@method WipeProfileAsync
@within ProfileStore
@yields

@param profile_key string -- The key used to identify the profile

@return boolean -- Returns a boolean indicating whether the wipe was successful or not

Use ```:WipeProfileASync()``` to erase user data when complying with right of erasure requests. In live roblox servers, ```:WipeProfileAsync()``` must be used on profiles created through
 [```ProfileStore.Mock```](#Mock) after [```Profile:Release()```](/api/Profile/Release)
 and it's known the Profile will no longer be loaded again.
]=]




--// Profile




--[=[
@class Profile

Profiles are the main storage for data in ProfileService, they are created through [```ProfileStore:LoadProfileAsync()```](/api/ProfileStore#LoadProfileAsync)
]=]

--[=[
@interface ProfileMetaData
@within Profile
.ProfileCreateTime number -- Read-only
.SessionLoadCount number -- Read-only
.ActiveSession table? -- Read-only
.MetaTags table -- Writable
.MetaTagsLatest table -- Read-only
]=]

--[=[
@prop MetaData ProfileMetaData
@within Profile
@readonly

```Profile.MetaData``` is a table containing data about the profile itself
```Profile.MetaData.MetaTags``` is saved on the same DataStore key together with [```Profile.Data```](#Data)
]=]

--[=[
@prop MetaTagsUpdated RBXScriptSignal
@within Profile
@readonly

A signal which fires every auto-save in which the profile has different ```Profile.MetaData.MetaTags```. Uses a custom implementation of an RBXScriptSignal so some methods may not be available.

**```Profile.MetaTagsUpdated``` will also fire when a profile is saved for the last time and released**
]=]

--[=[
@prop RobloxMetaData table
@within Profile

:::warning There are harsh limits for RobloxMetaData size, at the time of writing this RobloxMetaData cant exceed 300 characters.
:::
Similiar to setting the metadata in a DataStoreOptions instance, read the [official documentation](https://madstudioroblox.github.io/ProfileService/api/#profilerobloxmetadata) for more info
]=]

--[=[
@prop UserIds table
@within Profile
@readonly

User ids associated with this profile. Entries must be added with [```Profile:AddUserId()```](#AddUserId)
 and removed with [```Profile:RemoveUserId()```](#RemoveUserId).
]=]

--[=[
@prop KeyInfo DataStoreKeyInfo
@within Profile

The [DataStoreKeyInfo](https://developer.roblox.com/en-us/api-reference/class/DataStoreKeyInfo) instance related to this profile.
]=]

--[=[
@prop KeyInfoUpdated RBXScriptSignal
@within Profile
@readonly

A signal that gets triggered every time [```Profile.KeyInfo```](#KeyInfo) is updated
 with a new [DataStoreKeyInfo](https://developer.roblox.com/en-us/api-reference/class/DataStoreKeyInfo)
 instance reference after every auto-save or profile release. This uses a custom implementation of
 an RBXScriptSignal, so some methods may not be available.
]=]

--[=[
@prop GlobalUpdates global_updates
@within Profile
@readonly

This is the [```global_updates```](/api/global_updates) object tied to the specific ```Profile```. It exposes methods for update processing. (See [```Global Updates```](/api/global_updates) for more info)
]=]

--[=[
@method IsActive
@within Profile

@return boolean -- Whether the Profile is session-locked or not

Returns ```true``` while the profile is session-locked and saving of changes to [```Profile.Data```](#Data) is guarenteed.
]=]

--[=[
@method GetMetaTag
@within Profile

@param tag_name string -- The name of the tag to retrieve

@return any -- The value associated with the requested tag

Equivalent of ```Profile.MetaData.MetaTags[tag_name]```. See [```Profile:SetMetaTag()```](#SetMetaTag) for more info.
]=]

--[=[
@method Reconcile
@within Profile

@return nil

Fills in missing variables inside [```Profile.Data```](#Data) from the [```profile_template```](/api/DatastoreTemplateService#DataTemplate) that was provided
 when calling [```ProfileService.GetProfileStore()```](/api/ProfileService#GetProfileStore). It's often necessary to use ```:Reconcile()``` if
 you're applying changes to your profile_template over the course of your game's development after release.

Read the [API Documentation](https://madstudioroblox.github.io/ProfileService/api/#profilereconcile) for more info
]=]

--[=[
@method ListenToRelease
@within Profile

@param listener () -> () -- A listener which is called when the profile is released

@return RBXScriptConnection -- A connection which can be used to disconnect the listener

Listener functions subscribed to ```Profile:ListenToRelease()``` will be called when the profile
 is remotely released (Being ```ForceLoad```'ed on a remote server) or locally ([```Profile:Release()```](#Release)).
 In common practice, the profile will rarely be released before the player leaves the game so it's recommended to simply
 [:Kick()](https://developer.roblox.com/en-us/api-reference/function/Player/Kick) the Player when this happens.

:::caution
After ```Profile:ListenToRelease()``` is triggered, it is too late to change ```Profile.Data``` for the final time. As long as the profile
 is active ([```Profile:IsActive()```](#IsActive) == ```true```), you should store all profile related data immediately after it becomes
 available.
:::
]=]

--[=[
@method Release
@within Profile

@return nil

Removes the session lock for this profile on the Roblox server. Call this method after you're done working
 with the ```Profile``` object. Profile data will be immediately saved for the last tiem.
]=]

--[=[
@method ListenToHopReady
@within Profile

@param listener () -> () -- The listener which is called when the profile has released it's session-lock

@return RBXScriptConnection -- The connection which can be used to disconnect the listener

```Profile:ListenToHopReady()``` is in many ways similiar to [```Profile:ListenToRelease()```](#ListenToRelease) however,
 ```Profile:ListenToHopReady()``` is called when the session-lock on the profile is released. In most cases, this should be within a second,
 however, if a ```Profile``` is released next to an auto-update, it may take up to 7 seconds to be called.

For more information on this method, visit the [Profile Service API](https://madstudioroblox.github.io/ProfileService/api/#profilelistentohopready).
]=]

--[=[
@method AddUserId
@within Profile

@param user_id number -- The UserId to associate with the profile

@return nil

Associates a ```UserId``` with the profile. Multiple users can be associated with a single profile by
 calling this method for each individual ```UserId```. The primary use of this method is to comply with [GDPR](https://gdpr-info.eu/art-17-gdpr/) (The right to erasure).
]=]

--[=[
@method RemoveUserId
@within Profile

@param user_id number -- The UserId to remove from the DataStore

@return nil

Unassociates ```UserId``` with the profile, if it was initially associated.
]=]

--[=[
@method Identify
@within Profile

@return string -- A string containing the Store, Scope, and Key

Returns a string containing DataStore name, scope and key. Used for debugging.

```lua
-- Example return: "[Store:"GameData";Scope:"Live";Key:"Player_2312310"]"
```
]=]

--[=[
@method SetMetaTag
@within Profile

@param tag_name string
@param value any -- Any DataStore supported value, typically a primative

@return nil

Equivalent of ```Profile.MetaData.MetaTags[tag_name] = value```. Use for tagging your profile with information about itself
 such as:

- ```Profile:SetMetaTag("DataVersion", 1)```to let your game know whether ```Profile.Data``` needs to be converted after massive changes to your game
- Anything set through ```Profile:SetMetaTag(tag_name, value)``` will be available through
 ```Profile.MetaData.MetaTagsLatest[tag_name] after an auto-save or a [```:Save()```](#Save) call -
 ```Profile.MetaData.MetaTagsLatest``` is a version of ```Profile.MetaData.MetaTags``` that has
 been successfully saved to the DataStore.
]=]

--[=[
@method Save
@within Profile

@return nil

Call ```Profile:Save()``` to quickly progress ```GlobalUpdates``` state or to speed up the progagation
 of ```Profile.MetaData.MetaTags``` changes to ```Profile.MetaData.MetaTagsLatest```.

```Profile:Save()``` **should not be called for saving** ```Profile.Data``` or
 ```Profile.MetaData.MetaTags``` - this is already done for you automatically.

:::caution
Calling ```Profile:Save()``` when the ```Profile``` is released will throw an error. You can check [```Profile:IsActive()```](#IsActive)
 before using this method.
:::
]=]

--[=[
@method ClearGlobalUpdates
@within Profile

@return nil

:::warning
Only works on profiles loaded through [```ProfileStore:ViewProfileAsync()```](/api/ProfileStore#ViewProfileAsync) or
 [```ProfileStore:ProfileVersionQuery()```](/api/ProfileStore#ProfileVersionQuery)
:::

Clears all global update data (active or locked) for a profile payload. It may be desirable to clear potential "residue"
 global updates (e.g. pending gifts) which were existing in a snapshot which is being used to recover player data through
 [```ProfileStore:ProfileVersionQuery()```](/api/ProfileStore#ProfileVersionQuery)
]=]

--[=[
@method OverwriteAsync
@within Profile
@yields

:::warning
Only works on profiles loaded through [```ProfileStore:ViewProfileAsync()```](/api/ProfileStore#ViewProfileAsync) or
 [```ProfileStore:ProfileVersionQuery()```](/api/ProfileStore#ProfileVersionQuery)
:::

:::warning Only use for rollback payloads (Setting latest version to a copy of a previous version)!
Using this method for editing latest player data when the player is in-game can lead to several minutes of lost progress -
 it should be replaced by [```:LoadProfileAsync```](/api/ProfileStore/LoadProfileAsync) which will wait for
 the next live profile auto-save if the player is in-game, allowing the remote server to release the profile
 and save latest data.
:::

Pushes the ```Profile``` payload to the DataStore (saves the profile) and releases the session lock for the profile.
]=]




--// GlobalUpdates




--[=[
@class global_updates

A powerful feature of profile service, allowing for sending information across servers, or to a Profile which isn't loaded in any server.

Global Updates can be ```Active```, ```Locked```, or ```Cleared```:
- Whenever a global update is created, it will be ```Active``` by default
- ```Active``` updates can be **changed** or **cleared** within a [```:GlobalUpdateProfileAsync()```](/api/ProfileStore#GlobalUpdateProfileAsync) call
- Normally, when the profile is active on a Roblox server, you should always progress all ```Active``` updates to the ```Locked``` state
- ```Locked``` updates can no longer be **changed** or **cleared** within a ```:GlobalUpdateProfileAsync()``` call
- ```Locked``` updates are ready to be processed (e.g. add gift to player inventory) and immediately ```Locked``` by calling
 [```:LockActiveUpdate(update_id)```](#LockActiveUpdate)
- ```Cleared``` updates will immediately disappear from the profile forever

:::warning
Some methods are only available in certain contexts, these will be marked with a tag or explicitly stated in the description
:::
]=]

--[=[
@type ProfileServiceGlobalUpdate {update_id: string, update_data: any}
@within global_updates
]=]

--[=[
@method GetActiveUpdates
@within global_updates
@tag Always Available

@return {ProfileServiceGlobalUpdate}

Should be used immediately after a [```Profile```](/api/Profile) is loaded to scan and progress any pending ```Active``` updates
 to a ```Locked``` state

```lua
-- Example usage
for _, update in ipairs(profile.GlobalUpdates:GetActiveUpdates()) do
  profile.GlobalUpdates:LockActiveUpdate(update[1])
end
```
]=]

--[=[
@method GetLockedUpdates
@within global_updates
@tag Always Available

@return {ProfileServiceGlobalUpdate}

Should be used immediately after a [```Profile```](/api/Profile) is loaded to scan and progress any pending ```Locked``` updates
 to a ```Cleared``` state

```lua
-- Example usage
for _, update in ipairs(profile.GlobalUpdates:GetLockedUpdates()) do
  local update_id = update[1]
  local update_data = update[2]
  if update_data.Type == "AdminGift" and update_data.Item == "Coins" then
    profile.Data.Coins = profile.Data.Coins + update_data.Amount
  end
  profile.GlobalUpdates:ClearLockedUpdate(update_id)
end
```
]=]

--[=[
@method ListenToNewActiveUpdate
@within global_updates

:::info
This method is only available when the global_data object is accessed through [```Profile.GlobalUpdates```](/api/Profile#GlobalUpdates)
:::

@param listener (update_id: number, update_data: any) -> ()

@return RBXScriptConnection -- The connection which is used to listen to new active updates

In most games, you should progress all ```Active``` updates to a ```Locked``` state.

```lua
-- Example usage
profile.GlobalUpdates:ListenToNewActiveUpdate(function(update_id, update_data)
  profile.GlobalUpdates:LockActiveUpdate(update_id)
end)
```
]=]

--[=[
@method ListenToNewLockedUpdate
@within global_updates

:::info
This method is only available when the global_data object is accessed through [```Profile.GlobalUpdates```](/api/Profile#GlobalUpdates)
:::

@param listener (update_id: number, update_data: any) -> () -- Must always call [```global_updates:ClearLockedUpdate(update_id)```](#ClearLockedUpdate) after processing the locked update

@return RBXScriptConnection -- The connection which is used to listen to new active updates

When you get a ```Locked``` update via ```global_updates:ListenToNewLockedUpdate()```, the update is ready to be proccessed and immediately locked.

```lua
-- Example usage
profile.GlobalUpdates:ListenToNewLockedUpdate(function(update_id, update_data)
  if update_data.Type == "AdminGift" and update_data.Item == "Coins" then
    profile.Data.Coins = profile.Data.Coins + update_data.Amount
  end
  profile.GlobalUpdates:ClearLockedUpdate(update_id)
end)
```
]=]

--[=[
@method LockActiveUpdate
@within global_updates

:::info
This method is only available when the global_data object is accessed through [```Profile.GlobalUpdates```](/api/Profile#GlobalUpdates)
:::

@param update_id number -- The Id representing the global update

@return nil

Turns an ```Active``` update into a ```Locked``` update. Will invoke 
[```global_updates:ListenToNewLockedUpdate()```](#ListenToNewLockedUpdate) after an auto-save (less than 30 seconds) or 
[```Profile:Save()```](/api/Profile#Save).

:::caution
Calling ```global_updates:LockActiveUpdate()``` when the Profile
 is released will throw an error. You can check
 [```Profile:IsActive()```](/api/Profile#IsActive) before using this method. ProfileService
 guarantees that the Profile will be active when
 [```global_updates:ListenToNewActiveUpdate()```](#ListenToNewActiveUpdate) listeners are triggered.
:::
]=]

--[=[
@method ClearLockedUpdate
@within global_updates

:::info
This method is only available when the global_data object is accessed through [```Profile.GlobalUpdates```](/api/Profile#GlobalUpdates)
:::

@param update_id number -- The Id representing the global update

@return nil

Clears a ```Locked``` update completely from the Profile.

:::caution
Calling
 ```GlobalUpdates:ClearLockedUpdate()``` when the Profile is released will throw an error. You can check
 [```Profile:IsActive()```](/api/Profile#IsActive) before using this method.
 ProfileService guarantees that the Profile will be active when
 [```GlobalUpdates:ListenToNewLockedUpdate()```](#ListenToNewLockedUpdate) listeners are triggered.
:::
]=]

--[=[
@method AddActiveUpdate
@within global_updates

:::info
This method is only available within a [```global_update_handler```](/api/ProfileStore#global_update_handler)
 from a [```ProfileStore:GlobalUpdateProfileAsync()```](/api/ProfileStore#GlobalUpdateProfileAsync) call
:::

Used to send a new ```Active``` update to the profile
]=]

--[=[
@method ChangeActiveUpdate
@within global_updates

:::info
This method is only available within a [```global_update_handler```](/api/ProfileStore#global_update_handler)
 from a [```ProfileStore:GlobalUpdateProfileAsync()```](/api/ProfileStore#GlobalUpdateProfileAsync) call
:::

@param update_id number -- The Id of the update to change
@param update_data any -- The new data to send

Changing ```Active``` updates can be used for stacking
 player gifts, particularly when lots of players can be sending lots of gifts to a Youtube celebrity
  so the ```Profile``` would not exceed the
  [DataStore data limit](https://developer.roblox.com/en-us/articles/Datastore-Errors#data-limits).
]=]

--[=[
@method ClearActiveUpdate
@within global_updates

:::info
This method is only available within a [```global_update_handler```](/api/ProfileStore#global_update_handler)
 from a [```ProfileStore:GlobalUpdateProfileAsync()```](/api/ProfileStore#GlobalUpdateProfileAsync) call
:::

@param update_id number -- The Id of the update to clear

Removes an ```Active``` update from the profile completely.
]=]