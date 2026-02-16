"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Plus } from "lucide-react";
import { useTodos } from "@/hooks/useTodos";
import { TodoList } from "@/components/TodoList";
import { TodoFormDialog } from "@/components/TodoFormDialog";
import { TodoFilters } from "@/components/TodoFilters";
import { FilterType, SortType, Todo } from "@/types";
import { toast } from "sonner";

export default function Home() {
  const {
    addTodo,
    updateTodo,
    deleteTodo,
    toggleTodo,
    clearCompleted,
    restoreTodo,
    getFilteredTodos,
    getStats,
    getAllTags,
  } = useTodos();

  const [filter, setFilter] = useState<FilterType>("all");
  const [searchQuery, setSearchQuery] = useState("");
  const [sortBy, setSortBy] = useState<SortType>("createdDate");
  const [tagFilter, setTagFilter] = useState<string | null>(null);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingTodo, setEditingTodo] = useState<Todo | undefined>(undefined);
  const [dialogMode, setDialogMode] = useState<"add" | "edit">("add");

  const filteredTodos = getFilteredTodos(filter, searchQuery, tagFilter, sortBy);
  const stats = getStats();
  const availableTags = getAllTags();

  const handleAddTodo = (todo: Omit<Todo, "id" | "createdAt" | "completed">) => {
    addTodo(todo);
    toast.success("Todo added successfully!");
  };

  const handleEditTodo = (todo: Omit<Todo, "id" | "createdAt" | "completed">) => {
    if (editingTodo) {
      updateTodo(editingTodo.id, todo);
      toast.success("Todo updated successfully!");
    }
  };

  const handleDeleteTodo = (id: string) => {
    const todo = filteredTodos.find((t) => t.id === id);
    if (todo) {
      deleteTodo(id);
      toast.success("Todo deleted", {
        action: {
          label: "Undo",
          onClick: () => restoreTodo(todo),
        },
      });
    }
  };

  const handleOpenAddDialog = () => {
    setDialogMode("add");
    setEditingTodo(undefined);
    setDialogOpen(true);
  };

  const handleOpenEditDialog = (todo: Todo) => {
    setDialogMode("edit");
    setEditingTodo(todo);
    setDialogOpen(true);
  };

  const handleClearCompleted = () => {
    clearCompleted();
    toast.success("Completed todos cleared!");
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-50 to-gray-100">
      <div className="container mx-auto max-w-4xl px-4 py-8">
        <header className="mb-8">
          <h1 className="text-4xl font-bold text-gray-900">Todo App</h1>
          <p className="text-gray-600 mt-2">Organize your tasks efficiently</p>
        </header>

        <div className="space-y-6">
          <div className="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
            <Button onClick={handleOpenAddDialog} size="lg" className="gap-2">
              <Plus className="h-5 w-5" />
              Add Todo
            </Button>

            <Tabs value={filter} onValueChange={(v) => setFilter(v as FilterType)}>
              <TabsList>
                <TabsTrigger value="all">
                  All ({stats.total})
                </TabsTrigger>
                <TabsTrigger value="active">
                  Active ({stats.active})
                </TabsTrigger>
                <TabsTrigger value="completed">
                  Completed ({stats.completed})
                </TabsTrigger>
              </TabsList>
            </Tabs>
          </div>

          <TodoFilters
            searchQuery={searchQuery}
            onSearchChange={setSearchQuery}
            sortBy={sortBy}
            onSortChange={setSortBy}
            tagFilter={tagFilter}
            onTagFilterChange={setTagFilter}
            availableTags={availableTags}
          />

          <TodoList
            todos={filteredTodos}
            onToggle={toggleTodo}
            onEdit={handleOpenEditDialog}
            onDelete={handleDeleteTodo}
          />

          {stats.completed > 0 && (
            <div className="flex justify-center pt-4">
              <Button variant="outline" onClick={handleClearCompleted}>
                Clear Completed ({stats.completed})
              </Button>
            </div>
          )}
        </div>

        <TodoFormDialog
          open={dialogOpen}
          onOpenChange={setDialogOpen}
          onSubmit={dialogMode === "add" ? handleAddTodo : handleEditTodo}
          initialData={editingTodo}
          mode={dialogMode}
        />
      </div>
    </div>
  );
}
