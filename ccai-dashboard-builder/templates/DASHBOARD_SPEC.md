# Dashboard Spec, [Dashboard Purpose]

## Purpose
[One sentence on what this dashboard is for]

## Audience
- [ ] Just me
- [ ] My team (internal)
- [ ] My clients (external, needs auth)

## Refresh cadence
- [ ] Real-time
- [ ] Daily
- [ ] Manual

## Data points to display

| # | Data point | Source | Type (stat / table / chart) |
|---|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| ... | | | |

## Layout chosen
- [ ] Layout A: Stat cards + primary table + trend chart
- [ ] Layout B: Sidebar nav + multi-section
- [ ] Layout C: Single-table focus

## Components to generate

| Component | Purpose | Data source (stubbed) |
|---|---|---|
| StatCard / RevenueThisMonth | | lib/data/<purpose>.ts → getRevenueThisMonth() |
| DataTable / ClientList | | lib/data/<purpose>.ts → getClients() |
| ... | | |

## File paths to create

```
app/dashboard/<purpose>/page.tsx
components/dashboard/<purpose>/*.tsx
lib/data/<purpose>.ts
```

## Auth (if client-facing)
- Strategy: [NextAuth / Clerk / Supabase auth]
- Stub or full setup: stub for v0.1

## After-generate checklist
- [ ] Run `npm run dev`, confirm dashboard loads with mock data
- [ ] Replace mock data fetch with real API/source
- [ ] Configure auth (if applicable)
- [ ] Add to top-level navigation
