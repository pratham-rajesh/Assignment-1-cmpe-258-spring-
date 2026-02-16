import { Todo } from "@/types";

const STORAGE_KEY = "todoapp:v1";

export const loadTodos = (): Todo[] => {
  if (typeof window === "undefined") return [];
  
  try {
    const stored = localStorage.getItem(STORAGE_KEY);
    if (!stored) return [];
    
    const parsed = JSON.parse(stored);
    if (!Array.isArray(parsed)) return [];
    
    return parsed.filter((item): item is Todo => {
      return (
        typeof item === "object" &&
        item !== null &&
        typeof item.id === "string" &&
        typeof item.title === "string" &&
        typeof item.completed === "boolean" &&
        typeof item.createdAt === "number" &&
        ["low", "medium", "high"].includes(item.priority)
      );
    });
  } catch (error) {
    console.error("Failed to load todos from localStorage:", error);
    return [];
  }
};

export const saveTodos = (todos: Todo[]): void => {
  if (typeof window === "undefined") return;
  
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(todos));
  } catch (error) {
    console.error("Failed to save todos to localStorage:", error);
  }
};
