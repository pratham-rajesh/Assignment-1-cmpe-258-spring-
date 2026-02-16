"use client";

import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { SortType } from "@/types";
import { Search, SortAsc, Filter } from "lucide-react";

interface TodoFiltersProps {
  searchQuery: string;
  onSearchChange: (query: string) => void;
  sortBy: SortType;
  onSortChange: (sort: SortType) => void;
  tagFilter: string | null;
  onTagFilterChange: (tag: string | null) => void;
  availableTags: string[];
}

export function TodoFilters({
  searchQuery,
  onSearchChange,
  sortBy,
  onSortChange,
  tagFilter,
  onTagFilterChange,
  availableTags,
}: TodoFiltersProps) {
  const getSortLabel = (sort: SortType) => {
    switch (sort) {
      case "createdDate":
        return "Created Date";
      case "dueDate":
        return "Due Date";
      case "priority":
        return "Priority";
    }
  };

  return (
    <div className="flex flex-col sm:flex-row gap-3">
      <div className="relative flex-1">
        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input
          type="text"
          placeholder="Search todos..."
          value={searchQuery}
          onChange={(e) => onSearchChange(e.target.value)}
          className="pl-9"
        />
      </div>

      <DropdownMenu>
        <DropdownMenuTrigger asChild>
          <Button variant="outline" className="gap-2">
            <SortAsc className="h-4 w-4" />
            Sort: {getSortLabel(sortBy)}
          </Button>
        </DropdownMenuTrigger>
        <DropdownMenuContent align="end">
          <DropdownMenuItem onClick={() => onSortChange("createdDate")}>
            Created Date
          </DropdownMenuItem>
          <DropdownMenuItem onClick={() => onSortChange("dueDate")}>
            Due Date
          </DropdownMenuItem>
          <DropdownMenuItem onClick={() => onSortChange("priority")}>
            Priority
          </DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>

      {availableTags.length > 0 && (
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="outline" className="gap-2">
              <Filter className="h-4 w-4" />
              {tagFilter ? `Tag: ${tagFilter}` : "All Tags"}
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuItem onClick={() => onTagFilterChange(null)}>
              All Tags
            </DropdownMenuItem>
            {availableTags.map((tag) => (
              <DropdownMenuItem key={tag} onClick={() => onTagFilterChange(tag)}>
                {tag}
              </DropdownMenuItem>
            ))}
          </DropdownMenuContent>
        </DropdownMenu>
      )}
    </div>
  );
}
