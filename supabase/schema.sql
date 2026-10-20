-- SpellBound AI database schema (run in Supabase SQL Editor)
-- Uses Supabase auth.users; all user-owned rows are isolated with RLS.
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text check (char_length(username) <= 40),
  avatar_url text,
  total_stars integer not null default 0 check (total_stars >= 0),
  streak_days integer not null default 0 check (streak_days >= 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.study_sheets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  title text not null check (char_length(title) between 1 and 160),
  subject text not null default 'General',
  raw_ocr_text text,
  image_path text,
  created_at timestamptz not null default now()
);

create table if not exists public.quizzes (
  id uuid primary key default gen_random_uuid(),
  sheet_id uuid references public.study_sheets(id) on delete set null,
  user_id uuid not null references public.profiles(id) on delete cascade,
  title text not null check (char_length(title) between 1 and 160),
  questions_json jsonb not null default '[]'::jsonb check (jsonb_typeof(questions_json) = 'array'),
  difficulty text not null default 'Medium' check (difficulty in ('Easy','Medium','Hard')),
  created_at timestamptz not null default now()
);

create table if not exists public.student_progress (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  quiz_id uuid not null references public.quizzes(id) on delete cascade,
  score integer not null check (score >= 0),
  total_questions integer not null check (total_questions > 0 and score <= total_questions),
  stars_earned integer not null default 0 check (stars_earned >= 0),
  completed_at timestamptz not null default now()
);

create index if not exists study_sheets_user_created_idx on public.study_sheets(user_id, created_at desc);
create index if not exists quizzes_user_created_idx on public.quizzes(user_id, created_at desc);
create index if not exists student_progress_user_completed_idx on public.student_progress(user_id, completed_at desc);

alter table public.profiles enable row level security;
alter table public.study_sheets enable row level security;
alter table public.quizzes enable row level security;
alter table public.student_progress enable row level security;

drop policy if exists "profile_select_own" on public.profiles;
create policy "profile_select_own" on public.profiles for select to authenticated using ((select auth.uid()) = id);
drop policy if exists "profile_insert_own" on public.profiles;
create policy "profile_insert_own" on public.profiles for insert to authenticated with check ((select auth.uid()) = id);
drop policy if exists "profile_update_own" on public.profiles;
create policy "profile_update_own" on public.profiles for update to authenticated using ((select auth.uid()) = id) with check ((select auth.uid()) = id);

drop policy if exists "sheets_select_own" on public.study_sheets;
create policy "sheets_select_own" on public.study_sheets for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "sheets_insert_own" on public.study_sheets;
create policy "sheets_insert_own" on public.study_sheets for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "sheets_update_own" on public.study_sheets;
create policy "sheets_update_own" on public.study_sheets for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists "sheets_delete_own" on public.study_sheets;
create policy "sheets_delete_own" on public.study_sheets for delete to authenticated using ((select auth.uid()) = user_id);

drop policy if exists "quizzes_select_own" on public.quizzes;
create policy "quizzes_select_own" on public.quizzes for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "quizzes_insert_own" on public.quizzes;
create policy "quizzes_insert_own" on public.quizzes for insert to authenticated with check ((select auth.uid()) = user_id and (sheet_id is null or exists (select 1 from public.study_sheets s where s.id = sheet_id and s.user_id = (select auth.uid()))));
drop policy if exists "quizzes_update_own" on public.quizzes;
create policy "quizzes_update_own" on public.quizzes for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists "quizzes_delete_own" on public.quizzes;
create policy "quizzes_delete_own" on public.quizzes for delete to authenticated using ((select auth.uid()) = user_id);

drop policy if exists "progress_select_own" on public.student_progress;
create policy "progress_select_own" on public.student_progress for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "progress_insert_own" on public.student_progress;
create policy "progress_insert_own" on public.student_progress for insert to authenticated with check ((select auth.uid()) = user_id and exists (select 1 from public.quizzes q where q.id = quiz_id and q.user_id = (select auth.uid())));

-- Do not store is_pro as a client-editable profile flag. Premium entitlements must be verified server-side.
-- If adding image storage, create a private bucket and add matching storage.objects policies.
