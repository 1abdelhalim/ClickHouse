-- Test that EXPLAIN SYNTAX formats all operators as functions
-- Related to issue #94603
-- Tests should output function notation (e.g., plus(1, 2)) instead of operator notation (e.g., 1 + 2)

-- Basic arithmetic operators
EXPLAIN SYNTAX SELECT 1 + 2;
EXPLAIN SYNTAX SELECT 5 - 3;
EXPLAIN SYNTAX SELECT 4 * 7;
EXPLAIN SYNTAX SELECT 10 / 2;
EXPLAIN SYNTAX SELECT 10 % 3;

-- Unary operators
EXPLAIN SYNTAX SELECT -5;
EXPLAIN SYNTAX SELECT NOT true;

-- Comparison operators
EXPLAIN SYNTAX SELECT 1 = 1;
EXPLAIN SYNTAX SELECT 1 != 2;
EXPLAIN SYNTAX SELECT 1 <> 2;
EXPLAIN SYNTAX SELECT 1 < 2;
EXPLAIN SYNTAX SELECT 2 > 1;
EXPLAIN SYNTAX SELECT 1 <= 2;
EXPLAIN SYNTAX SELECT 2 >= 1;

-- Logical operators
EXPLAIN SYNTAX SELECT true AND false;
EXPLAIN SYNTAX SELECT true OR false;

-- Nested arithmetic operators
EXPLAIN SYNTAX SELECT 1 + 2 + 3;
EXPLAIN SYNTAX SELECT 1 * 2 * 3;
EXPLAIN SYNTAX SELECT (1 + 2) * 3;
EXPLAIN SYNTAX SELECT 1 + (2 * 3);

-- Mixed operators with precedence
EXPLAIN SYNTAX SELECT 1 + 2 * 3;
EXPLAIN SYNTAX SELECT (1 + 2) * (3 + 4);
EXPLAIN SYNTAX SELECT 10 / 2 - 3;

-- Complex multi-operator expressions
EXPLAIN SYNTAX SELECT 1 + 2 * 3, 5 - 1, NOT true, -10;
EXPLAIN SYNTAX SELECT (1 = 1) AND (2 < 3);
EXPLAIN SYNTAX SELECT NOT (1 = 2);

-- Nested unary operators
EXPLAIN SYNTAX SELECT NOT NOT true;
EXPLAIN SYNTAX SELECT -(-5);
EXPLAIN SYNTAX SELECT NOT NOT NOT false;

-- LIKE operator
EXPLAIN SYNTAX SELECT 'test' LIKE 'te%';
EXPLAIN SYNTAX SELECT 'test' NOT LIKE 'x%';

-- IN operator  
EXPLAIN SYNTAX SELECT 1 IN (1, 2, 3);
EXPLAIN SYNTAX SELECT 1 NOT IN (4, 5, 6);

-- IS NULL operator
EXPLAIN SYNTAX SELECT NULL IS NULL;
EXPLAIN SYNTAX SELECT 1 IS NOT NULL;

-- Array subscript operator
EXPLAIN SYNTAX SELECT [1, 2, 3][1];

-- Tuple element access
EXPLAIN SYNTAX SELECT (1, 2).1;

-- Complex deeply nested expression
EXPLAIN SYNTAX SELECT ((1 + 2) * (3 - 4)) / ((5 + 6) - (7 * 8));

-- Mixed logical and comparison
EXPLAIN SYNTAX SELECT (1 < 2) AND (3 > 2) OR (4 = 4);

-- All common operators in one query
EXPLAIN SYNTAX SELECT 
    1 + 2,
    3 - 4, 
    5 * 6,
    7 / 8,
    9 % 2,
    -10,
    NOT true,
    11 = 11,
    12 != 13,
    14 < 15,
    16 > 15,
    17 <= 18,
    19 >= 18,
    true AND false,
    true OR false;

-- Edge case: operator with column reference (to ensure it works with real columns)
EXPLAIN SYNTAX SELECT number + 1 FROM system.numbers LIMIT 1;

-- Edge case: operators in WHERE clause
EXPLAIN SYNTAX SELECT * FROM system.numbers WHERE number > 0 AND number < 10 LIMIT 1;

-- Edge case: operators in GROUP BY
EXPLAIN SYNTAX SELECT number + 1 AS n FROM system.numbers GROUP BY n LIMIT 1;
