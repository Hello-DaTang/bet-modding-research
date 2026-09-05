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

The `usmap` filename is evidence that this probe package targets a BET build associated with UE 5.7.4; it is **not yet proof** that the currently installed game binary is exactly the same build. Compatibility must be verified at runtime.

## TEST-000 — Loader compatibility

**Purpose:** Determine whether the installed BET-specific UE4SS fork can initialize against the current Steam build without modifying gameplay state.

### Procedure

1. Start the game normally from Steam.
2. Reach the main menu.
3. Do not enable No Collision, Spawner, or other gameplay-altering modules.
4. Exit the game normally.
5. Inspect the tail of `UE4SS.log` for fatal errors, signature failures, mapping failures, or successful Lua/UE4SS initialization.
6. Verify whether the UE4SS console / supplied command menu can be opened.

### Status

`PENDING RUNTIME VERIFICATION`

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

`PENDING DUMP INSPECTION`
