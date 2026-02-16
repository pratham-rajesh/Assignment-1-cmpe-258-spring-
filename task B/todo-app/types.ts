export type Priority = "low" | "medium" | "high";

export interface Todo {
  id: string;
  title: string;
  description?: string;
  completed: boolean;
  createdAt: number;
  dueDate?: string;
  priority: Priority;
  tag?: string;
}

export type FilterType = "all" | "active" | "completed";

export type SortType = "createdDate" | "dueDate" | "priority";
