export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          operationName?: string
          query?: string
          variables?: Json
          extensions?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      actions: {
        Row: {
          created_at: string | null
          description: string | null
          id: string
          is_latest: boolean | null
          response_id: string | null
          type: string
          updated_at: string | null
          user_id: string | null
          version: number
        }
        Insert: {
          created_at?: string | null
          description?: string | null
          id?: string
          is_latest?: boolean | null
          response_id?: string | null
          type: string
          updated_at?: string | null
          user_id?: string | null
          version: number
        }
        Update: {
          created_at?: string | null
          description?: string | null
          id?: string
          is_latest?: boolean | null
          response_id?: string | null
          type?: string
          updated_at?: string | null
          user_id?: string | null
          version?: number
        }
        Relationships: [
          {
            foreignKeyName: "actions_response_id_fkey"
            columns: ["response_id"]
            isOneToOne: false
            referencedRelation: "responses"
            referencedColumns: ["id"]
          },
        ]
      }
      profiles: {
        Row: {
          employer_id: string | null
          employer_name: string | null
          id: string
          inserted_at: string | null
          job_title: string | null
          line_manager_email: string | null
          line_manager_name: string | null
          line_manager_user_id: string | null
          name: string | null
          pronouns: string | null
          updated_at: string | null
          user_id: string | null
        }
        Insert: {
          employer_id?: string | null
          employer_name?: string | null
          id?: string
          inserted_at?: string | null
          job_title?: string | null
          line_manager_email?: string | null
          line_manager_name?: string | null
          line_manager_user_id?: string | null
          name?: string | null
          pronouns?: string | null
          updated_at?: string | null
          user_id?: string | null
        }
        Update: {
          employer_id?: string | null
          employer_name?: string | null
          id?: string
          inserted_at?: string | null
          job_title?: string | null
          line_manager_email?: string | null
          line_manager_name?: string | null
          line_manager_user_id?: string | null
          name?: string | null
          pronouns?: string | null
          updated_at?: string | null
          user_id?: string | null
        }
        Relationships: []
      }
      questions: {
        Row: {
          category: string
          id: string
          order: number
          question_text: string
        }
        Insert: {
          category: string
          id?: string
          order: number
          question_text: string
        }
        Update: {
          category?: string
          id?: string
          order?: number
          question_text?: string
        }
        Relationships: []
      }
      responses: {
        Row: {
          created_at: string | null
          id: string
          is_latest: boolean | null
          question_id: string | null
          response_text: string | null
          status: string | null
          updated_at: string | null
          user_id: string | null
          version: number
          visibility: string | null
        }
        Insert: {
          created_at?: string | null
          id?: string
          is_latest?: boolean | null
          question_id?: string | null
          response_text?: string | null
          status?: string | null
          updated_at?: string | null
          user_id?: string | null
          version: number
          visibility?: string | null
        }
        Update: {
          created_at?: string | null
          id?: string
          is_latest?: boolean | null
          question_id?: string | null
          response_text?: string | null
          status?: string | null
          updated_at?: string | null
          user_id?: string | null
          version?: number
          visibility?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "responses_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
        ]
      }
      sharing_event_actions: {
        Row: {
          action_id: string | null
          id: string
          sharing_event_id: string | null
        }
        Insert: {
          action_id?: string | null
          id?: string
          sharing_event_id?: string | null
        }
        Update: {
          action_id?: string | null
          id?: string
          sharing_event_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "sharing_event_actions_action_id_fkey"
            columns: ["action_id"]
            isOneToOne: false
            referencedRelation: "actions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sharing_event_actions_sharing_event_id_fkey"
            columns: ["sharing_event_id"]
            isOneToOne: false
            referencedRelation: "sharing_events"
            referencedColumns: ["id"]
          },
        ]
      }
      sharing_event_responses: {
        Row: {
          id: string
          response_id: string | null
          sharing_event_id: string | null
        }
        Insert: {
          id?: string
          response_id?: string | null
          sharing_event_id?: string | null
        }
        Update: {
          id?: string
          response_id?: string | null
          sharing_event_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "sharing_event_responses_response_id_fkey"
            columns: ["response_id"]
            isOneToOne: false
            referencedRelation: "responses"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sharing_event_responses_sharing_event_id_fkey"
            columns: ["sharing_event_id"]
            isOneToOne: false
            referencedRelation: "sharing_events"
            referencedColumns: ["id"]
          },
        ]
      }
      sharing_events: {
        Row: {
          id: string
          message: string | null
          recipient_email: string
          shared_at: string | null
          user_id: string | null
        }
        Insert: {
          id?: string
          message?: string | null
          recipient_email: string
          shared_at?: string | null
          user_id?: string | null
        }
        Update: {
          id?: string
          message?: string | null
          recipient_email?: string
          shared_at?: string | null
          user_id?: string | null
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DefaultSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof Database },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends { schema: keyof Database }
  ? Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  graphql_public: {
    Enums: {},
  },
  public: {
    Enums: {},
  },
} as const

