---
name: ccai-dashboard-builder
description: "Generates internal-tool dashboards (KPI views, admin panels, ops consoles) in the existing ccai-website-builder-setup Next.js project. Uses shadcn/ui components for tables, charts, and stat cards. Read-only by default; pro version adds CRUD against your data sources. Use when the user needs an internal dashboard for their business (revenue tracker, client portal, project status board)."
when_to_use: "User mentions dashboard, admin panel, internal tool, KPI tracker, ops console, client portal, status board, or asks for a UI to display data they already have."
argument-hint: "[dashboard purpose, revenue / clients / projects / etc.]"
---

# CCAI Dashboard Builder

Builds internal-tool dashboards into your Next.js project. Uses shadcn/ui for tables, cards, charts.

## Output contract

Generates into the existing `ccai-website-builder-setup` project:
- `app/dashboard/<purpose>/page.tsx`, the dashboard page
- `components/dashboard/<purpose>/*.tsx`, section components (StatCards, DataTable, Chart, etc.)
- `lib/data/<purpose>.ts`, data fetching stubs (you fill in the source)
- `app/dashboard/layout.tsx` (if not exists), auth wrapper

## Prerequisites

- `ccai-website-builder-setup` already ran
- A clear list of what data the dashboard needs to show

## Process

### Step 1, Define the dashboard
Ask:
1. **Purpose:** what's this dashboard for? (revenue / clients / projects / inventory / agents / something else)
2. **Audience:** just you / your team / clients (clients = extra auth concerns)
3. **What data shows on it:** list the 5-10 key data points
4. **Where the data comes from:** Stripe API / Google Sheets / your database / pasted CSV / etc.
5. **Refresh cadence:** real-time / daily / manual

### Step 2, Decide the layout
Three default layouts:

**Layout A, Stat-cards + table** (most common)
- Top: 3-4 stat cards with key numbers
- Middle: a primary data table
- Bottom: trend chart for the most important metric

**Layout B, Multi-section dashboard**
- Sidebar nav for sub-views
- Each section is its own card/table

**Layout C, Single-table focus** (when there's one main data list)
- One full-width table with filters + search

Recommend a layout based on the data list from Step 1.

### Step 3, Generate components
Default shadcn/ui primitives:
- `<Card>` for stat tiles
- `<Table>` for tabular data
- `<Tabs>` for layout B sub-views
- `<Badge>` for status indicators
- Recharts (via shadcn integration) for charts

All Tailwind, mobile-responsive, dark-mode-aware (if STYLE_GUIDE has dark mode).

### Step 4, Data layer (stubs only in free version)
For each data source the user named:
- Create `lib/data/<purpose>.ts` with a typed interface and a stubbed function
- The function returns hardcoded mock data for now
- Comments throughout showing where to replace mock with real fetch

User wires up the actual data source themselves (Stripe API call, Sheets fetch, database query). Pro version generates the live wiring.

### Step 5, Auth wrapper (if audience = clients)
For client-facing dashboards:
- Add a basic auth check via NextAuth or Clerk (stubbed)
- Add a `<DashboardLayout>` wrapper that redirects unauthorized users
- Note: full auth setup is a separate skill, this version stubs it

### Step 6, Build verification
Run `npm run dev`. Confirm dashboard route loads with mock data. Screenshot if available.

## Hard rules

- **Mock data first, real data second.** Always generate with mock data so the user sees the dashboard render before doing API wiring.
- **No external dashboard tools.** Don't recommend Retool, Tableau, etc., those are valid tools, but this skill builds in YOUR Next.js project for full ownership.
- **Read-only by default.** Free version generates display-only. CRUD = pro version.
- **No fake real-time.** If data is daily, don't add a "Live" badge. Honest cadence labels.

## Pro version differences

`ccai-dashboard-builder-pro` (planned):
- Live data wiring (Stripe, Supabase, Postgres, Sheets) via direct API integration
- CRUD operations (add / edit / delete rows)
- Webhook listeners for real-time updates
- Multi-tenant for client-facing dashboards (each client sees only their data)
- Role-based access control

## Reference files
- `templates/DASHBOARD_SPEC.md`, schema for the dashboard plan
- `examples/sample-revenue-dashboard.md`, filled example for a Creative Core AI revenue dashboard
