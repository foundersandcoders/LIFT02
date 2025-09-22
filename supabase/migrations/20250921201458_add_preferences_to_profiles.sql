-- Add preferences column to profiles table for storing user UI preferences
ALTER TABLE profiles ADD COLUMN preferences JSONB DEFAULT '{}' NOT NULL;

-- Add a comment to document the column purpose
COMMENT ON COLUMN profiles.preferences IS 'JSON object storing user interface preferences like font size, theme, etc.';