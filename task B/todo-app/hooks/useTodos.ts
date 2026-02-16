import { useReducer, useEffect } from "react";
import { v4 as uuidv4 } from "uuid";
import { Todo, FilterType, SortType } from "@/types";
import { loadTodos, saveTodos } from "@/lib/storage";

type TodoAction =
  | { type: "LOAD_TODOS"; payload: Todo[] }
  | { type: "ADD_TODO"; payload: Omit<Todo, "id" | "createdAt" | "completed"> }
  | { type: "UPDATE_TODO"; payload: { id: string; updates: Partial<Todo> } }
  | { type: "DELETE_TODO"; payload: string }
  | { type: "TOGGLE_TODO"; payload: string }
  | { type: "CLEAR_COMPLETED" }
  | { type: "RESTORE_TODO"; payload: Todo };

const todoReducer = (state: Todo[], action: TodoAction): Todo[] => {
  switch (action.type) {
    case "LOAD_TODOS":
      return action.payload;
    
    case "ADD_TODO":
      return [
        ...state,
        {
          ...action.payload,
          id: uuidv4(),
          createdAt: Date.now(),
          completed: false,
        },
      ];
    
    case "UPDATE_TODO":
      return state.map((todo) =>
        todo.id === action.payload.id
          ? { ...todo, ...action.payload.updates }
          : todo
      );
    
    case "DELETE_TODO":
      return state.filter((todo) => todo.id !== action.payload);
    
    case "TOGGLE_TODO":
      return state.map((todo) =>
        todo.id === action.payload
          ? { ...todo, completed: !todo.completed }
          : todo
      );
    
    case "CLEAR_COMPLETED":
      return state.filter((todo) => !todo.completed);
    
    case "RESTORE_TODO":
      return [...state, action.payload];
    
    default:
      return state;
  }
};

export const useTodos = () => {
  const [todos, dispatch] = useReducer(todoReducer, []);

  useEffect(() => {
    const loaded = loadTodos();
    dispatch({ type: "LOAD_TODOS", payload: loaded });
  }, []);

  useEffect(() => {
    saveTodos(todos);
  }, [todos]);

  const addTodo = (todo: Omit<Todo, "id" | "createdAt" | "completed">) => {
    dispatch({ type: "ADD_TODO", payload: todo });
  };

  const updateTodo = (id: string, updates: Partial<Todo>) => {
    dispatch({ type: "UPDATE_TODO", payload: { id, updates } });
  };

  const deleteTodo = (id: string) => {
    dispatch({ type: "DELETE_TODO", payload: id });
  };

  const toggleTodo = (id: string) => {
    dispatch({ type: "TOGGLE_TODO", payload: id });
  };

  const clearCompleted = () => {
    dispatch({ type: "CLEAR_COMPLETED" });
  };

  const restoreTodo = (todo: Todo) => {
    dispatch({ type: "RESTORE_TODO", payload: todo });
  };

  const getFilteredTodos = (
    filter: FilterType,
    searchQuery: string,
    tagFilter: string | null,
    sortBy: SortType
  ): Todo[] => {
    let filtered = [...todos];

    if (filter === "active") {
      filtered = filtered.filter((todo) => !todo.completed);
    } else if (filter === "completed") {
      filtered = filtered.filter((todo) => todo.completed);
    }

    if (searchQuery) {
      const query = searchQuery.toLowerCase();
      filtered = filtered.filter(
        (todo) =>
          todo.title.toLowerCase().includes(query) ||
          todo.description?.toLowerCase().includes(query)
      );
    }

    if (tagFilter) {
      filtered = filtered.filter((todo) => todo.tag === tagFilter);
    }

    filtered.sort((a, b) => {
      if (sortBy === "dueDate") {
        if (!a.dueDate && !b.dueDate) return 0;
        if (!a.dueDate) return 1;
        if (!b.dueDate) return -1;
        return new Date(a.dueDate).getTime() - new Date(b.dueDate).getTime();
      } else if (sortBy === "priority") {
        const priorityOrder = { high: 0, medium: 1, low: 2 };
        return priorityOrder[a.priority] - priorityOrder[b.priority];
      } else {
        return b.createdAt - a.createdAt;
      }
    });

    return filtered;
  };

  const getStats = () => {
    const active = todos.filter((todo) => !todo.completed).length;
    const completed = todos.filter((todo) => todo.completed).length;
    return { active, completed, total: todos.length };
  };

  const getAllTags = (): string[] => {
    const tags = new Set<string>();
    todos.forEach((todo) => {
      if (todo.tag) tags.add(todo.tag);
    });
    return Array.from(tags).sort();
  };

  return {
    todos,
    addTodo,
    updateTodo,
    deleteTodo,
    toggleTodo,
    clearCompleted,
    restoreTodo,
    getFilteredTodos,
    getStats,
    getAllTags,
  };
};
