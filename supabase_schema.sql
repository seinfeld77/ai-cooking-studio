-- Table: benchmark_channels
create table benchmark_channels (
  id uuid primary key default gen_random_uuid(),
  platform text,
  creator_name text,
  url text,
  focus_niche text,
  language_style text,
  follower_count integer,
  notes text,
  created_at timestamp with time zone default now()
);

-- Table: video_samples
create table video_samples (
  id uuid primary key default gen_random_uuid(),
  channel_id uuid references benchmark_channels(id),
  title text,
  url text,
  platform text,
  post_date date,
  view_count integer,
  like_count integer,
  comment_count integer,
  engagement_score float,
  collected_at timestamp with time zone default now()
);

-- Table: audience_comments
create table audience_comments (
  id uuid primary key default gen_random_uuid(),
  video_id uuid references video_samples(id),
  comment_text text,
  sentiment_score float,
  emotion_tags text[],
  is_repeat_phrase boolean,
  is_question boolean,
  timestamp timestamp with time zone default now()
);

-- Table: emotion_patterns
create table emotion_patterns (
  id uuid primary key default gen_random_uuid(),
  source_comment_ids uuid[],
  pattern_label text,
  description text,
  confidence_score float,
  related_content_hooks text[]
);

-- Table: persona_repositioning_notes
create table persona_repositioning_notes (
  id uuid primary key default gen_random_uuid(),
  character_name text,
  old_tone text,
  new_tone text,
  insight_source_id uuid references emotion_patterns(id),
  description text,
  updated_at timestamp with time zone default now()
);

-- Table: prompt_seeds
create table prompt_seeds (
  id uuid primary key default gen_random_uuid(),
  character_name text,
  prompt_text text,
  generated_by text,
  version text,
  related_pattern_id uuid references emotion_patterns(id),
  effectiveness_rating integer,
  notes text,
  created_at timestamp with time zone default now()
);
