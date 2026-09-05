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

### Bundled mod state

`Mods/mods.txt` currently enables:

- CheatManagerEnablerMod
- ConsoleCommandsMod
- ConsoleEnablerMod
- BPML_GenericFunctions
- BPModLoaderMod
- ETBCommandsMod
- ItemDumper
- Keybinds

An `enabled.txt` is also present under `Mods/ItemDumper`.

The BET fork contains these explicit signature overrides:

```text
FName_Constructor.lua
GUObjectArray.lua.bak
StaticConstructObject.lua
```

The current FName constructor AOB supplied by the fork is:

```text
40 53 48 83 EC 30 48 8B D9 48 89 54 24 20 33 C9 4C 8B CA 44 8B C1 48 85 D2 74 27 0F B7 02 66 85
```

Relevant settings include:

```text
bUseUObjectArrayCache = false
ConsoleEnabled = 1
GuiConsoleEnabled = 1
GuiConsoleVisible = 1
GraphicsAPI = opengl
```

### TEST-000-A — UE4SS disabled / vanilla isolation

`FAILED — GAME STILL DOES NOT LAUNCH AFTER RENAMING dwmapi.dll TO dwmapi.dll.disabled`

This materially changes the diagnosis. The currently observed no-launch state is not sufficient to attribute the failure to UE4SS injection, because disabling the UE4SS proxy loader did not restore startup.

The next diagnostic priority is therefore to establish whether:

1. a BET process starts and exits immediately,
2. Windows Error Reporting records an application crash,
3. Steam game files are missing/corrupted or changed by the current update,
4. the current BET build has a renderer / Discord SDK / platform startup issue,
5. a stale process or launcher state is preventing startup.

UE4SS compatibility work is paused until vanilla startup is restored.

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

`BLOCKED BY TEST-000 — VANILLA STARTUP MUST BE RESTORED FIRST`
