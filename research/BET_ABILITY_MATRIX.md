# BET Ability Matrix

Canonical evidence table for Backrooms: Escape Together capability/authority research.

## Status legend

- `UNKNOWN` — not inspected or tested.
- `CANDIDATE` — names/objects suggest the capability exists, but no runtime proof yet.
- `OBSERVED` — runtime/object evidence confirms presence or behavior.
- `CONFIRMED` — behavior reproduced in controlled tests.
- `REJECTED` — hypothesis disproved by testing.

## Authority legend

- `L0` — local presentation/client-only state.
- `L1` — client prediction/correctable local state.
- `L2` — client request; server validates/applies.
- `L3` — host/server authoritative gameplay/world state.
- `L4` — external/special system (platform/session/voice/save/cloud/etc.).

## Matrix

| Area | Feature | UObject / Component | Function / Property | Client Read | Client Write | Replicated | Rollback | Other Players See | Persistence | RPC / Validation | Authority | Status | Evidence / Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Player | Position | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Player | Movement speed | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Player | Stamina | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Player | Health | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Camera/UI | FOV | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Inventory | Pickup | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Inventory | Drop | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Inventory | Use item | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| World | Interact | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Entity/AI | Target selection | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Entity/AI | Movement | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Damage | Damage application | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Death/Revive | Revive | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Level | Procedural seed | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Network | Gameplay RPC map | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Lobby | Ready / start | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |
| Save | Progression / unlock | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | |

## Proof ladder

For each important capability, progress through the following evidence levels where applicable:

1. Locate UObject/class/function/property.
2. Confirm a live instance exists.
3. Read only; record values.
4. Hook/log function calls and parameters without changing them.
5. Perform a minimal reversible local modification.
6. Test in single-player / local context.
7. Test while hosting.
8. Test as a joining client.
9. Observe behavior from a second player.
10. Test rejoin / late join / travel / persistence.

Do not classify authority based only on a variable being writable in memory.
