# BET Modding Research

Research, instrumentation, and experimental mods for **Backrooms: Escape Together**.

## Goal

Build an evidence-based capability and authority map of the game before implementing a target mod. Each explored feature should answer:

- What can the client read?
- What can the client change locally?
- What is predicted and later corrected?
- What requires a Client → Server request/RPC?
- What is Host/Server authoritative?
- What replicates to other players?
- What survives rejoin / travel / save reload?

## Current environment

- Game: Backrooms: Escape Together
- Platform: Windows / Steam
- Game binary: `BET/Binaries/Win64/BETGameSteam-Win64-Shipping.exe`
- Engine artifacts bundled with current probe environment indicate UE 5.7.x
- Instrumentation: BET-specific UE4SS fork
- Research mode: observation first; no gameplay-state modification until objects/functions are identified and logged

## Research areas

1. Player / Character
2. Camera / UI / Rendering
3. Inventory / Item
4. Interaction / World
5. Entity / AI
6. Damage / Death / Revive
7. Level / Procedural Generation
8. Network / RPC
9. Lobby / Session / Travel
10. Save / Unlock / Progression

## Authority levels

- **L0 — Local presentation:** client-only state such as camera/UI/rendering.
- **L1 — Client prediction:** client may change or predict state, but authority may correct it.
- **L2 — Client request:** client can request an action; server validates and applies it.
- **L3 — Host/Server authoritative:** authoritative gameplay/world state resides on host/server.
- **L4 — External/special system:** platform/session/voice/save/cloud/achievement integrations.

## Evidence policy

No capability is marked confirmed from a property name alone. A claim should be backed by one or more of:

- UObject/class/function dump
- UE4SS runtime log
- Hook trace
- Controlled local test
- Host test
- Client test
- Second-player observation
- Rejoin / late-join / travel persistence test

See `research/BET_ABILITY_MATRIX.md` for the canonical capability matrix.
