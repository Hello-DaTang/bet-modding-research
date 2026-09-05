# 00 — Boot Diagnostics

## VANILLA-BOOT-001

Date: 2026-09-05

### Confirmed observations

- Steam launches `BETGame.exe`, which then launches `BETGameSteam-Win64-Shipping.exe BET`.
- With the BET UE4SS proxy removed from `BET\Binaries\Win64`, vanilla startup still fails.
- Steam repeatedly records exit code `777006` for the Shipping process after roughly 2–3 seconds.
- One observed run exited with Windows status `0xC0000005` (access violation).
- The original `%LOCALAPPDATA%\BET\Saved\Logs\BET.log` is stale (last modified 2026-06-19); failed 2026-09-05 launches do not create a new Unreal log.
- `%LOCALAPPDATA%\BET` was renamed so BET could start with a clean local profile. Startup still fails.
- A new `%LOCALAPPDATA%\BET` tree subsequently appeared, but inspection showed only `Saved\SaveGames`, containing `steam_autocloud.vdf` with a 2026-09-05 timestamp and `.sav` files retaining 2026-06-19 timestamps.
- No new `Saved\Logs` or `Saved\Config` files were created by the failed launch.

### Interpretation of the recreated BET directory

The recreated `BET` directory is consistent with Steam Auto-Cloud restoring configured save files before launch. The presence of a current `steam_autocloud.vdf` alongside old `.sav` timestamps is not evidence that the game reached normal Unreal initialization.

Therefore the clean-profile test still excludes the old local Config/cache state as the primary cause. Steam Cloud restoration of saves is a separate pre-launch behavior and does not invalidate the static-init diagnosis.

### Current diagnosis

`777006` corresponds to Unreal Engine's `CrashDuringStaticInit` exit code. The failure occurs before normal UE logging/main-window initialization, so ordinary BET logs are not expected to contain the cause.

At this point further cache clearing or UE4SS signature work is paused. The next diagnostic step is user-mode native debugging of `BETGameSteam-Win64-Shipping.exe` to capture the terminating exception / process state and native call stack.

### Next test

`VANILLA-BOOT-002 — native crash dump capture`

Goal: identify the module/function that faults during static initialization.
