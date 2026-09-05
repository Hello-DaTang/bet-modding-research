# 00 — Boot Diagnostics

## VANILLA-BOOT-001

Date: 2026-09-05

### Confirmed observations

- Steam launches `BETGame.exe`, which then launches `BETGameSteam-Win64-Shipping.exe BET`.
- With the BET UE4SS proxy removed from `BET\Binaries\Win64`, vanilla startup still fails.
- Steam repeatedly records exit code `777006` for the Shipping process after roughly 2–3 seconds.
- One observed run exited with Windows status `0xC0000005` (access violation).
- The existing `%LOCALAPPDATA%\BET\Saved\Logs\BET.log` is stale (last modified 2026-06-19); failed 2026-09-05 launches do not create a new Unreal log.
- `%LOCALAPPDATA%\BET` was renamed so BET could start with a clean local profile. Startup still fails.
- Therefore old local Config/SaveGames/cache data is not sufficient to explain the failure.

### Current diagnosis

`777006` corresponds to Unreal Engine's `CrashDuringStaticInit` exit code. The failure occurs before normal UE logging/main-window initialization, so ordinary BET logs are not expected to contain the cause.

At this point further cache clearing or UE4SS signature work is paused. The next diagnostic step is user-mode native debugging of `BETGameSteam-Win64-Shipping.exe` to capture the first fatal exception and native call stack.

### Next test

`VANILLA-BOOT-002 — WinDbg first-chance crash capture`

Goal: identify the module/function that faults during static initialization.
