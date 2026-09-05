# 00 — Environment

## Game installation

```text
D:\Program Files (x86)\Steam\steamapps\common\Backrooms_Escape_Together
```

Primary game binary:

```text
BET\Binaries\Win64\BETGameSteam-Win64-Shipping.exe
```

Observed installation layout on 2026-09-05:

```text
Backrooms_Escape_Together/
├─ BET/
├─ Engine/
├─ BetGame.exe
├─ Manifest_NonUFSFiles_Win64.txt
└─ Manifest_UFSFiles_Win64.txt
```

## UE4SS probe environment

Installed under:

```text
BET\Binaries\Win64\
├─ dwmapi.dll
└─ ue4ss/
   ├─ UE4SS.dll
   ├─ UE4SS-settings.ini
   ├─ Mods/
   ├─ CXXHeaderDump/
   ├─ UHTHeaderDump/
   ├─ liveview/
   ├─ watches/
   ├─ UE4SS_Signatures/
   ├─ BET-5.7.4-0+UE5-9ec5ece7.usmap
   ├─ UE4SS.log
   └─ UE4SS_ObjectDump.txt
```

Notable bundled artifacts:

- `BET-5.7.4-0+UE5-9ec5ece7.usmap`
- `UE4SS_ObjectDump.txt` (~36.9 MB)
- `UE4SS.log`

The `usmap` filename is evidence that this probe package targets a BET build associated with UE 5.7.4; it is **not proof** that the currently installed game binary is exactly the same build.

## TEST-000 — Loader compatibility

**Purpose:** Determine whether the installed BET-specific UE4SS fork can initialize against the current Steam build without modifying gameplay state.

### Result — 2026-09-05

`FAILED — GAME DOES NOT REACH MAIN MENU WITH THE INSTALLED BET UE4SS FORK`

Observed UE4SS build:

```text
UE4SS v3.0.1 Beta #0
Git SHA 9ec5ece7
Engine detected: 5.7
Game binary size: 206441984 bytes
```

Pattern scan successfully located:

- EngineVersion 5.7
- GUObjectArray
- GMalloc
- FName::ToString
- ConsoleManagerSingleton
- GameEngineTick
- StaticConstructObject_Internal via Lua override

Pattern scan did not locate:

- `FUObjectHashTables::Get()`
- `GNatives`

Both are treated as optional by current UE4SS compatibility documentation and are therefore not considered sufficient evidence for the startup failure by themselves.

The final observed initialization sequence was:

```text
Verifying FName constructor...
[UE4SS.FNameConstructor.FNameConstructorVerificationHook] Added posthook ...
```

No successful `FName constructor verified`, event-loop start, Lua initialization completion, or main-menu startup was observed after that point.

### Working hypothesis

The bundled BET-specific UE4SS compatibility data is stale relative to the current 2026-09-05 game executable. The strongest current suspect is the FName constructor override / FName verification path rather than the missing optional `GUObjectHashTables` or `GNatives` signatures.

This is consistent with known UE 5.7 UE4SS compatibility reports where FName constructor resolution or validation fails even when other major addresses scan successfully.

### Next isolation tests

1. Verify the unmodified game starts when `dwmapi.dll` is temporarily disabled.
2. Re-enable UE4SS but disable all bundled mods.
3. Test `bUseUObjectArrayCache = false`.
4. Inspect the BET fork's `UE4SS_Signatures/FName_Constructor.lua` and current settings.
5. If core-only startup still stops at FName verification, move to a newer UE4SS experimental build or derive a current-build FName signature rather than attempting gameplay probes.

## TEST-001 — Existing object dump viability

**Purpose:** Verify whether the bundled `UE4SS_ObjectDump.txt` contains useful BET gameplay classes/functions and whether it corresponds closely enough to the current build to seed our class index.

### Initial search targets

- `PlayerController`
- `Character`
- `PlayerState`
- `GameMode`
- `GameState`
- `Inventory`
- `Interact`
- `Pickup`
- `Damage`
- `Revive`
- `Entity`
- `AIController`
- `Server_`
- `Client_`
- `Multicast`
- `OnRep_`

### Status

`BLOCKED BY TEST-000 — CURRENT RUNTIME COMPATIBILITY MUST BE RESTORED FIRST`
