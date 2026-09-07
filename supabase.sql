-- AX Baterias - banco do MVP
-- Rode este arquivo UMA VEZ no Supabase > SQL Editor.

create table if not exists public.ax_app_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.ax_app_state enable row level security;

-- Princípio de menor privilégio: visitante não autenticado não acessa nada.
revoke all on table public.ax_app_state from anon;
revoke all on table public.ax_app_state from authenticated;

-- O app autenticado precisa ler e manter apenas a própria linha.
grant select, insert, update, delete on table public.ax_app_state to authenticated;

drop policy if exists "ax_select_own_state" on public.ax_app_state;
create policy "ax_select_own_state"
on public.ax_app_state
for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "ax_insert_own_state" on public.ax_app_state;
create policy "ax_insert_own_state"
on public.ax_app_state
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "ax_update_own_state" on public.ax_app_state;
create policy "ax_update_own_state"
on public.ax_app_state
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "ax_delete_own_state" on public.ax_app_state;
create policy "ax_delete_own_state"
on public.ax_app_state
for delete
to authenticated
using (auth.uid() = user_id);
