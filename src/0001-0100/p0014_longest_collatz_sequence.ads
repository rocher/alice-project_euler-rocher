-------------------------------------------------------------------------------
--
--  ALICE - Adventures for Learning and Inspiring Coding Excellence
--  Copyright (c) 2023 Francesc Rocher <francesc.rocher@gmail.com>
--  SPDX-License-Identifier: MIT
--
--  ---------------------------------------------------------------------------
--
--  The following problem is taken from Project Euler:
--
--                 https://projecteuler.net/problem=14
--
--  Longest Collatz sequence
--  ------------------------
--
--  The following iterative sequence is defined for the set of positive
--  integers:
--
--                 n → n/2 (n is even)
--                 n → 3n + 1 (n is odd)
--
--  Using the rule above and starting with 13, we generate the following
--  sequence:
--
--                 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
--
--  It can be seen that this sequence (starting at 13 and finishing at 1)
--  contains 10 terms. Although it has not been proved yet (Collatz Problem),
--  it is thought that all starting numbers finish at 1.
--
--  Which starting number, under one million, produces the longest chain?
--
--  NOTE: Once the chain starts the terms are allowed to go above one
--  million.
--
-------------------------------------------------------------------------------

with Ada.Strings.Unbounded;      use Ada.Strings.Unbounded;
with Project_Euler.CLI.Problems; use Project_Euler.CLI.Problems;

package P0014_Longest_Collatz_Sequence is

   type Problem_Type is new Problem_Interface with private;

   Problem_Number : constant Natural := 14;
   Title_Text     : constant String  := "Longest Collatz sequence";
   Brief_Text     : constant String  :=
     "Which starting number, under one million, produces the longest " &
     "[Collatz] chain?";

   overriding function Number (Problem : Problem_Type) return Natural is
     (Problem_Number);

   overriding function Title (Problem : Problem_Type) return String is
     (Title_Text);

   overriding function Brief (Problem : Problem_Type) return String is
     (Brief_Text);

   overriding procedure Configure_Options (Problem : Problem_Type);

   overriding procedure Parse_Options (Problem : in out Problem_Type);

   overriding function Answer
     (Problem : Problem_Type; Notes : in out Unbounded_String) return String;

private

   type Problem_Type is new Problem_Interface with record
      Option_Reverse : Boolean := False;
   end record;

end P0014_Longest_Collatz_Sequence;
