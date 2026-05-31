"""
IA22 Search & Filter Module - Advanced search capabilities
"""

from typing import Any, Dict, List, Optional

from ia22.query_builder import QueryBuilder
from ia22.sqlite_manager import SQLite3Manager


class SearchFilter:
    """Advanced search and filter builder"""

    def __init__(self, table: str, db_manager: SQLite3Manager = None):
        """Initialize search filter"""
        self.table = table
        self.db = db_manager or SQLite3Manager()
        self.query_builder = QueryBuilder(table, self.db)
        self.filters: Dict[str, Any] = {}

    def add_filter(self, field: str, operator: str, value: Any) -> "SearchFilter":
        """Add filter condition"""
        operators = {
            "eq": "=",
            "ne": "!=",
            "gt": ">",
            "gte": ">=",
            "lt": "<",
            "lte": "<=",
            "like": "LIKE",
            "in": "IN",
            "between": "BETWEEN",
        }

        if operator not in operators:
            raise ValueError(f"Unknown operator: {operator}")

        self.filters[field] = {"operator": operator, "value": value}
        return self

    def add_search(self, fields: List[str], search_term: str) -> "SearchFilter":
        """Add full-text search across multiple fields"""
        for field in fields:
            self.add_filter(field, "like", f"%{search_term}%")
        return self

    def add_range(self, field: str, min_val: Any, max_val: Any) -> "SearchFilter":
        """Add range filter"""
        self.filters[field] = {"operator": "between", "value": (min_val, max_val)}
        return self

    def add_sort(self, field: str, direction: str = "ASC") -> "SearchFilter":
        """Add sorting"""
        self.query_builder.order_by(field, direction)
        return self

    def add_pagination(self, page: int = 1, per_page: int = 20) -> "SearchFilter":
        """Add pagination"""
        offset = (page - 1) * per_page
        self.query_builder.limit(per_page).offset(offset)
        return self

    def execute(self) -> List[Dict[str, Any]]:
        """Execute search with filters"""
        if not self.db.conn:
            self.db.connect()

        qb = self.query_builder

        # Apply filters
        for field, filter_info in self.filters.items():
            operator = filter_info["operator"]
            value = filter_info["value"]

            if operator == "in":
                qb.where_in(field, value)
            elif operator == "between":
                qb.where_between(field, value[0], value[1])
            else:
                sql_operator = {
                    "eq": "=",
                    "ne": "!=",
                    "gt": ">",
                    "gte": ">=",
                    "lt": "<",
                    "lte": "<=",
                    "like": "LIKE",
                }[operator]
                qb.where(f"{field} {sql_operator} ?", value)

        return qb.get()

    def count(self) -> int:
        """Count results matching filters"""
        if not self.db.conn:
            self.db.connect()

        qb = QueryBuilder(self.table, self.db)

        for field, filter_info in self.filters.items():
            operator = filter_info["operator"]
            value = filter_info["value"]

            if operator == "in":
                qb.where_in(field, value)
            elif operator == "between":
                qb.where_between(field, value[0], value[1])
            else:
                sql_operator = {
                    "eq": "=",
                    "ne": "!=",
                    "gt": ">",
                    "gte": ">=",
                    "lt": "<",
                    "lte": "<=",
                    "like": "LIKE",
                }[operator]
                qb.where(f"{field} {sql_operator} ?", value)

        return qb.count()
