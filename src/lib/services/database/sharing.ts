import { supabase } from '$lib/services/supabaseClient';
import type {
  DbResult as Result,
  DbResultMany as Results,
  Database,
  QueryOptions
} from './types';

type Share = Database['public']['Tables']['sharing_events']['Row'];
type ShareInsert = Database['public']['Tables']['sharing_events']['Insert'];
type ShareUpdate = Database['public']['Tables']['sharing_events']['Update'];

/**
 * Get all shares for a user (both shared with them and shared by them)
 */
export async function getUserShares(
  userId: string,
  options?: QueryOptions
): Results<Share> {
  let query = supabase
    .from('shares')
    .select('*')
    .or(`shared_by.eq.${userId},shared_with.eq.${userId}`);

  if (options?.orderBy) {
    query = query.order(options.orderBy.column, {
      ascending: options.orderBy.ascending ?? true
    });
  }

  if (options?.limit) {
    query = query.limit(options.limit);
  }

  if (options?.offset) {
    query = query.range(options.offset, options.offset + (options.limit ?? 10) - 1);
  }

  const { data, error } = await query;

  if (error) {
    return { data: null, error };
  }

  return { data, error: null };
}

/**
 * Get shares where user is the recipient
 */
export async function getSharedWithUser(
  userId: string,
  options?: QueryOptions
): Results<Share> {
  let query = supabase
    .from('shares')
    .select('*')
    .eq('shared_with', userId);

  if (options?.orderBy) {
    query = query.order(options.orderBy.column, {
      ascending: options.orderBy.ascending ?? true
    });
  }

  if (options?.limit) {
    query = query.limit(options.limit);
  }

  if (options?.offset) {
    query = query.range(options.offset, options.offset + (options.limit ?? 10) - 1);
  }

  const { data, error } = await query;

  if (error) {
    return { data: null, error };
  }

  return { data, error: null };
}

/**
 * Get shares created by a user
 */
export async function getSharedByUser(
  userId: string,
  options?: QueryOptions
): Results<Share> {
  let query = supabase
    .from('shares')
    .select('*')
    .eq('shared_by', userId);

  if (options?.orderBy) {
    query = query.order(options.orderBy.column, {
      ascending: options.orderBy.ascending ?? true
    });
  }

  if (options?.limit) {
    query = query.limit(options.limit);
  }

  if (options?.offset) {
    query = query.range(options.offset, options.offset + (options.limit ?? 10) - 1);
  }

  const { data, error } = await query;

  if (error) {
    return { data: null, error };
  }

  return { data, error: null };
}

/**
 * Get a single share by ID
 */
export async function getShareById(id: string): Result<Share> {
  const { data, error } = await supabase
    .from('shares')
    .select('*')
    .eq('id', id)
    .single();

  if (error) {
    return { data: null, error };
  }

  return { data, error: null };
}

/**
 * Create a new share
 */
export async function createShare(
  sharedBy: string,
  data: Omit<ShareInsert, 'shared_by' | 'status' | 'created_at'>
): Result<Share> {
  const { data: share, error } = await supabase
    .from('shares')
    .insert([
      {
        ...data,
        shared_by: sharedBy,
        status: 'active',
        created_at: new Date().toISOString()
      }
    ])
    .select()
    .single();

  if (error) {
    return { data: null, error };
  }

  return { data: share, error: null };
}

/**
 * Update an existing share
 */
export async function updateShare(
  id: string,
  data: Omit<ShareUpdate, 'shared_by' | 'created_at'>
): Result<Share> {
  const { data: share, error } = await supabase
    .from('shares')
    .update(data)
    .eq('id', id)
    .select()
    .single();

  if (error) {
    return { data: null, error };
  }

  return { data: share, error: null };
}

/**
 * Revoke a share
 */
export async function revokeShare(id: string): Result<Share> {
  const { data: share, error } = await supabase
    .from('shares')
    .update({ status: 'revoked' })
    .eq('id', id)
    .select()
    .single();

  if (error) {
    return { data: null, error };
  }

  return { data: share, error: null };
}

/**
 * Check if a user has access to a shared item
 */
export async function checkShareAccess(
  userId: string,
  shareId: string
): Promise<boolean> {
  const { data, error } = await supabase
    .from('shares')
    .select('*')
    .eq('id', shareId)
    .eq('shared_with', userId)
    .eq('status', 'active')
    .single();

  if (error || !data) {
    return false;
  }

  return true;
}

/**
 * Get all active shares for a specific item
 */
export async function getItemShares(
  itemType: 'response' | 'action',
  itemId: string
): Results<Share> {
  const { data, error } = await supabase
    .from('shares')
    .select('*')
    .eq('item_type', itemType)
    .eq('item_id', itemId)
    .eq('status', 'active');

  if (error) {
    return { data: null, error };
  }

  return { data, error: null };
} 