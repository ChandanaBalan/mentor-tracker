-- Run this in Supabase → SQL Editor if the table does not exist yet.
create table if not exists public.sessions (
  id text primary key,
  mentor_name text not null,
  mentee_name text not null,
  date timestamptz not null,
  session_number int not null,
  topics_discussed text not null,
  action_items text not null,
  mentor_comments text not null default ''
);

alter table public.sessions enable row level security;

drop policy if exists "sessions_select_anon" on public.sessions;
drop policy if exists "sessions_insert_anon" on public.sessions;
drop policy if exists "sessions_update_anon" on public.sessions;
drop policy if exists "sessions_delete_anon" on public.sessions;

-- Dev-friendly policies: tighten these before production (e.g. auth.uid() checks).
create policy "sessions_select_anon" on public.sessions for select using (true);
create policy "sessions_insert_anon" on public.sessions for insert with check (true);
create policy "sessions_update_anon" on public.sessions for update using (true) with check (true);
create policy "sessions_delete_anon" on public.sessions for delete using (true);
