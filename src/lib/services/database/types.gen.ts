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
          extensions?: Json
          variables?: Json
          query?: string
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
          response_id: string | null
          status: string
          type: string
          updated_at: string | null
          user_id: string | null
          version: number | null
        }
        Insert: {
          created_at?: string | null
          description?: string | null
          id?: string
          response_id?: string | null
          status?: string
          type: string
          updated_at?: string | null
          user_id?: string | null
          version?: number | null
        }
        Update: {
          created_at?: string | null
          description?: string | null
          id?: string
          response_id?: string | null
          status?: string
          type?: string
          updated_at?: string | null
          user_id?: string | null
          version?: number | null
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
      line_managers: {
        Row: {
          created_at: string | null
          email: string | null
          id: string
          line_manager_id: string
          organization_id: string
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          email?: string | null
          id?: string
          line_manager_id: string
          organization_id: string
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          email?: string | null
          id?: string
          line_manager_id?: string
          organization_id?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "line_managers_line_manager_id_fkey"
            columns: ["line_manager_id"]
            isOneToOne: true
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "line_managers_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      organizations: {
        Row: {
          created_at: string | null
          id: string
          name: string
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          id?: string
          name: string
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          id?: string
          name?: string
          updated_at?: string | null
        }
        Relationships: []
      }
      profiles: {
        Row: {
          id: string
          inserted_at: string | null
          is_line_manager: boolean | null
          job_title: string | null
          line_manager: string | null
          name: string | null
          preferences: Json
          pronouns: string[] | null
          updated_at: string | null
          user_id: string | null
        }
        Insert: {
          id?: string
          inserted_at?: string | null
          is_line_manager?: boolean | null
          job_title?: string | null
          line_manager?: string | null
          name?: string | null
          preferences?: Json
          pronouns?: string[] | null
          updated_at?: string | null
          user_id?: string | null
        }
        Update: {
          id?: string
          inserted_at?: string | null
          is_line_manager?: boolean | null
          job_title?: string | null
          line_manager?: string | null
          name?: string | null
          preferences?: Json
          pronouns?: string[] | null
          updated_at?: string | null
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "profiles_line_manager_fkey"
            columns: ["line_manager"]
            isOneToOne: false
            referencedRelation: "line_managers"
            referencedColumns: ["id"]
          },
        ]
      }
      questions: {
        Row: {
          category: string
          id: string
          order: number
          preview: string | null
          question_text: string
        }
        Insert: {
          category: string
          id?: string
          order: number
          preview?: string | null
          question_text: string
        }
        Update: {
          category?: string
          id?: string
          order?: number
          preview?: string | null
          question_text?: string
        }
        Relationships: []
      }
      resources: {
        Row: {
          created_at: string | null
          description: string | null
          id: string
          title: string
          updated_at: string | null
          url: string | null
        }
        Insert: {
          created_at?: string | null
          description?: string | null
          id?: string
          title: string
          updated_at?: string | null
          url?: string | null
        }
        Update: {
          created_at?: string | null
          description?: string | null
          id?: string
          title?: string
          updated_at?: string | null
          url?: string | null
        }
        Relationships: []
      }
      responses: {
        Row: {
          created_at: string | null
          id: string
          question_id: string | null
          response_text: string | null
          status: string | null
          updated_at: string | null
          user_id: string | null
          version: number | null
          visibility: string
        }
        Insert: {
          created_at?: string | null
          id?: string
          question_id?: string | null
          response_text?: string | null
          status?: string | null
          updated_at?: string | null
          user_id?: string | null
          version?: number | null
          visibility?: string
        }
        Update: {
          created_at?: string | null
          id?: string
          question_id?: string | null
          response_text?: string | null
          status?: string | null
          updated_at?: string | null
          user_id?: string | null
          version?: number | null
          visibility?: string
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

