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
--                 https://projecteuler.net/problem=21
--
--  Amicable numbers
--  ----------------
--
--  Let d(n) be defined as the sum of proper divisors of n (numbers less than
--  n which divide evenly into n). If d(a) = b and d(b) = a, where a ≠ b,
--  then a and b are an amicable pair and each of a and b are called amicable
--  numbers.
--
--  For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22,
--  44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1,
--  2, 4, 71 and 142; so d(284) = 220.
--
--  Evaluate the sum of all the amicable numbers under 10000.
--
-------------------------------------------------------------------------------

with Ada.Strings.Unbounded;      use Ada.Strings.Unbounded;
with Project_Euler.CLI.Problems; use Project_Euler.CLI.Problems;

package P0021_Amicable_Numbers is

   Problem_Number : constant Natural := 21;
   Title_Text     : constant String  := "Amicable numbers";
   Brief_Text     : constant String  :=
     "Evaluate the sum of all the amicable numbers under 10000.";

   type Problem_Type is new Problem_Interface with null record;

   overriding function Number (Problem : Problem_Type) return Natural is
     (Problem_Number);

   overriding function Title (Problem : Problem_Type) return String is
     (Title_Text);

   overriding function Brief (Problem : Problem_Type) return String is
     (Brief_Text);

   overriding function Answer
     (Problem : Problem_Type; Notes : in out Unbounded_String) return String;

end P0021_Amicable_Numbers;
