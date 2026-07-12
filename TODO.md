# TODO — Gwin Bayin Flutter ↔ Backend API alignment

## Step 1 — Locate existing API/repository usage
- [ ] Use list_files + targeted reads to find all repository/service classes hitting `/api/...`.

## Step 2 — Fix Dio headers to match backend doc
- [ ] Update `lib/core/network/client/dio_client.dart`:
  - [ ] Replace `Authorization: Bearer ...` with `x-app-token`.
  - [ ] Always send required headers: `User-Agent`, `x-app-token`, `x-device-id`, `x-app-version`.
  - [ ] Send `x-real-user: true` only for video list endpoints (`/api/videos`).

## Step 3 — Fix boot flow ordering
- [ ] Update `lib/app/state/app_boot_controller.dart` to call `repo.initDevice()` before `versionCheck()` and `vipCheck()`.

## Step 4 — Fix endpoint paths
- [ ] Update `lib/app/state/app_boot_repositories.dart`:
  - [ ] Ensure settings endpoint uses `GET /api/settings` (not `/api/vip/settings`).
  - [ ] Verify all referenced endpoints match backend doc.

## Step 5 — Add/align repositories for remaining endpoints
- [ ] Implement missing repository methods for:
  - [ ] `/api/videos`, `/api/videos/:id`, `/api/videos/:id/view`
  - [ ] `/api/app-config`
  - [ ] `/api/categories`
  - [ ] VIP: `/api/vip/activate`, `/api/vip/check`, `/api/vip-free/*`
  - [ ] Downloads: `/api/download-limit/*`

## Step 6 — Riverpod integration + models
- [ ] Ensure Riverpod providers/controllers use repositories consistently.
- [ ] Add models + error mapping that match backend `{success:false, message:...}`.

## Step 7 — Testing
- [ ] `flutter analyze`
- [ ] `flutter run` and validate headers + endpoints via logs.

