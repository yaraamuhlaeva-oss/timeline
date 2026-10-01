-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run.

create table if not exists public.tasks (
  id          text primary key,
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name        text not null,
  topic       text not null,
  start_date  date not null,
  deadline    date not null,
  done        boolean not null default false,
  deleted     boolean not null default false,
  created_at  bigint not null,
  updated_at  bigint not null
);

alter table public.tasks enable row level security;

-- Each person can only see and change their own tasks.
create policy "tasks_select_own" on public.tasks for select to authenticated
  using ((select auth.uid()) = user_id);
create policy "tasks_insert_own" on public.tasks for insert to authenticated
  with check ((select auth.uid()) = user_id);
create policy "tasks_update_own" on public.tasks for update to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "tasks_delete_own" on public.tasks for delete to authenticated
  using ((select auth.uid()) = user_id);

grant select, insert, update, delete on public.tasks to authenticated;
