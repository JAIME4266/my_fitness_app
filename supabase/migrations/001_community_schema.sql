-- Phase 5: Community & Social Fitness Supabase Schema with Row Level Security (RLS)
-- Deploy to Supabase Free Tier SQL Editor. Never expose service_role key in the APK.

create extension if not exists "uuid-ossp";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text not null unique,
  display_name text not null,
  avatar_url text,
  is_private boolean not null default false,
  daily_goal_km double precision not null default 5.0,
  created_at timestamptz not null default now()
);

create table if not exists public.run_posts (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  title text not null,
  distance_km double precision not null,
  duration_sec integer not null,
  pace_label text not null,
  polyline_json text,
  workout_badge text,
  visibility text not null default 'public' check (visibility in ('public', 'followers', 'private')),
  created_at timestamptz not null default now()
);

create table if not exists public.post_likes (
  post_id uuid not null references public.run_posts(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (post_id, user_id)
);

create table if not exists public.post_comments (
  id uuid primary key default uuid_generate_v4(),
  post_id uuid not null references public.run_posts(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  body text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.follows (
  follower_id uuid not null references public.profiles(id) on delete cascade,
  following_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (follower_id, following_id)
);

create table if not exists public.groups (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  description text not null default '',
  is_private boolean not null default false,
  owner_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.group_members (
  group_id uuid not null references public.groups(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  joined_at timestamptz not null default now(),
  primary key (group_id, user_id)
);

create table if not exists public.challenges (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  target_km double precision not null,
  duration_days integer not null,
  challenge_type text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.challenge_participants (
  challenge_id uuid not null references public.challenges(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  progress_km double precision not null default 0,
  completed boolean not null default false,
  primary key (challenge_id, user_id)
);

create table if not exists public.user_blocks (
  blocker_id uuid not null references public.profiles(id) on delete cascade,
  blocked_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (blocker_id, blocked_id)
);

create table if not exists public.content_reports (
  id uuid primary key default uuid_generate_v4(),
  reporter_id uuid not null references public.profiles(id) on delete cascade,
  post_id uuid not null references public.run_posts(id) on delete cascade,
  reason text not null,
  created_at timestamptz not null default now()
);

-- Enable Row Level Security
alter table public.profiles enable row level security;
alter table public.run_posts enable row level security;
alter table public.post_likes enable row level security;
alter table public.post_comments enable row level security;
alter table public.follows enable row level security;
alter table public.groups enable row level security;
alter table public.group_members enable row level security;
alter table public.challenges enable row level security;
alter table public.challenge_participants enable row level security;
alter table public.user_blocks enable row level security;
alter table public.content_reports enable row level security;

-- Core RLS Policies
create policy "Public profiles readable" on public.profiles
  for select using (not is_private or auth.uid() = id);
create policy "Users manage own profile" on public.profiles
  for all using (auth.uid() = id);

create policy "Visible run posts" on public.run_posts
  for select using (
    user_id = auth.uid()
    or (
      visibility = 'public'
      and not exists (
        select 1 from public.user_blocks b
        where b.blocker_id = auth.uid() and b.blocked_id = run_posts.user_id
      )
    )
    or (
      visibility = 'followers'
      and exists (
        select 1 from public.follows f
        where f.follower_id = auth.uid() and f.following_id = run_posts.user_id
      )
    )
  );
create policy "Users insert own posts" on public.run_posts
  for insert with check (auth.uid() = user_id);
create policy "Users delete own posts" on public.run_posts
  for delete using (auth.uid() = user_id);

create policy "Authenticated likes" on public.post_likes
  for select using (true);
create policy "Users manage own likes" on public.post_likes
  for all using (auth.uid() = user_id);

create policy "Authenticated comments" on public.post_comments
  for select using (true);
create policy "Users insert own comments" on public.post_comments
  for insert with check (auth.uid() = user_id);
create policy "Users delete own comments" on public.post_comments
  for delete using (auth.uid() = user_id);
