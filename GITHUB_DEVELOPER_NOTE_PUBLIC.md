# TROY Online Recovery - Public Developer Note

## Current checkpoint

The project reached the first confirmed account-login milestone.

## Confirmed

- VS2008/v90 Win32 Release client builds.
- Local server selection/status works.
- Login packet was adapted to the active server protocol.
- Client sends 97-byte login packet.
- Server returns login response data.
- Account login reaches race-selection screen.
- Zones 1-6 start and run locally.

## Current blocker

The client exits during race/character creation name input.

## Likely technical cause

The client and server do not agree on login/avatar/character structure sizes.

Observed during debugging:

- Server returned login response: 18,732 bytes.
- Client originally expected: 35,902 bytes.
- A temporary partial-receive patch allowed the client to continue into race selection.

## Next tasks

1. Compare client/server definitions:
   - AVATAR_INFO
   - S_LOGIN_RECV
   - S_USER_AVATAR_INFO_RECV
   - MAX_USER_AVATAR_NUM
   - MAX_AVATAR_NAME_LENGTH
   - character create/send/recv packet structures

2. Replace the temporary partial-receive workaround with correct packet/structure alignment.

3. Add debug logs around:
   - race selection
   - character name input
   - avatar create packet send
   - server avatar create receive
   - AvatarInfo insert/update

4. After character creation succeeds:
   - verify AvatarInfo row creation
   - verify zone registration
   - enter active zone
   - expand map/zone config safely

## Privacy

Do not upload:
- SQL dumps
- real config passwords
- personal Windows paths
- private logs

Upload only sanitized patches, notes, and reproducible build instructions.
