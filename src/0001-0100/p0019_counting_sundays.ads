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
--                 https://projecteuler.net/problem=19
--
--  Counting Sundays
--  ----------------
--
--  You are given the following information, but you may prefer to do some
--  research for yourself.
--
--                 • 1 Jan 1900 was a Monday.
--                 • Thirty days has September,
--                   April, June and November.
--                   All the rest have thirty-one,
--                   Saving February alone,
--                   Which has twenty-eight, rain or shine.
--                   And on leap years, twenty-nine.
--                 • A leap year occurs on any year evenly divisible by 4,
--                   but not on a century unless it is divisible by 400.
--
--  How many Sundays fell on the first of the month during the twentieth
--  century (1 Jan 1901 to 31 Dec 2000)?
--
-------------------------------------------------------------------------------

with Ada.Strings.Unbounded;      use Ada.Strings.Unbounded;
with Project_Euler.CLI.Problems; use Project_Euler.CLI.Problems;

package P0019_Counting_Sundays is

   Problem_Number : constant Natural := 19;
   Title_Text     : constant String  := "Counting Sundays";
   Brief_Text     : constant String  :=
     "How many Sundays fell on the first of the month during the " &
     "twentieth century (1 Jan 1901 to 31 Dec 2000)?";

   type Problem_Type is new Problem_Interface with null record;

   overriding function Number (Problem : Problem_Type) return Natural is
     (Problem_Number);

   overriding function Title (Problem : Problem_Type) return String is
     (Title_Text);

   overriding function Brief (Problem : Problem_Type) return String is
     (Brief_Text);

   overriding function Answer
     (Problem : Problem_Type; Notes : in out Unbounded_String) return String;

end P0019_Counting_Sundays;
