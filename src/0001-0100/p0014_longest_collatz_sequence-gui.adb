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

with Simple_Logging;
with Parse_Args;

with Euler_Tools_Int1; use Euler_Tools_Int1;

package body P0014_Longest_Collatz_Sequence.GUI is

   package Log renames Simple_Logging;

   -------------------
   -- P0014_Factory --
   -------------------

   function P0014_Factory return Problems.Pointer_To_Problem_Task is
      Problem : constant Problems.Pointer_To_Problem_Task := new Problem_Task;
   begin
      Log.Info ("New Problem_Task created");
      return Problem;
   end P0014_Factory;

   -----------------------------
   -- P0014_Configure_Options --
   -----------------------------

   procedure P0014_Configure_Options is
   begin
      Project_Euler.Argument_Parser.Add_Option
        (Parse_Args.Make_Boolean_Option (False), Name => "REVERSE",
         Short_Option => 'r', Long_Option => "reverse",
         Usage => "Traverse search space in reverse order");
   end P0014_Configure_Options;

   -------------------
   -- Plotter_Setup --
   -------------------

   procedure Plotter_Setup (Plotter : Plotters.Pointer_To_Plotter_Class) is
   begin
      Plotter.Set_Axes
        (X_Min => 0.0, X_Max => 1_000_000.0, Y_Min => 0.0, Y_Max => 600.0);
      Plotter.Draw_Grid
        (X_Major => 100_000.0, X_Minor => 50_000.0, Y_Major => 100.0,
         Y_Minor => 50.0);
      Plotter.Draw_Axes ("Number", "Length");
   end Plotter_Setup;

   ------------------
   -- Problem_Task --
   ------------------

   task body Problem_Task is
      Plotter : Plotters.Pointer_To_Plotter_Class;

      Seed       : Integer_Type;
      Δ_Seed     : Integer_Type;
      Seed_Pause : Integer_Type;
      Seed_Stop  : Integer_Type;
      Number     : Integer_Type;
      Length     : Integer_Type;
      Answer     : Integer_Type;
      Max_Length : Integer_Type := 0;

      Option_Reverse : Boolean := False;

      --  block computations
      Σ_Length    : Float;
      Has_Max     : Boolean;
      Block_Size  : Integer_Type := 10_000;
      Block_Max_X : Integer_Type;
      Block_Max_Y : Integer_Type := 0;
      Block_Min_X : Integer_Type;
      Block_Min_Y : Integer_Type := Integer_Type'Last;

      Color_Rectangle      : constant String := "#999";
      Color_Fill_Rectangle : constant String := "#eee";
      Color_Last_Rectangle : constant String := "#396";
      Color_Abs_Max        : constant String := "#c00";
      Color_Block_Max      : constant String := "#33c";
      Color_Block_Min      : constant String := "#c3c";

      procedure Draw_Block is
         Base : constant Float :=
           (if Option_Reverse then Float (Seed)
            else Float (Seed - Block_Size));
      begin
         Plotter.Fill_Rectangle
           (Base, 0.0, Base + Float (Block_Size),
            Σ_Length / Float (Block_Size));
         Plotter.Stroke_color (Color_Rectangle);
         Plotter.Rectangle
           (Base, 0.0, Base + Float (Block_Size),
            Σ_Length / Float (Block_Size));
         if Has_Max then
            Plotter.Stroke_color (Color_Abs_Max);
            Plotter.Line
              (Float (Answer), 0.0, Float (Answer), Float (Max_Length));
            Plotter.Line_Dash (10, 5);
            Plotter.Line
              (0.0, Float (Max_Length), 1_000_000.0, Float (Max_Length));
            Plotter.Line_Dash (10, 0);
         else
            Plotter.Stroke_color (Color_Block_Max);
            Plotter.Line
              (Float (Block_Max_X), 0.0, Float (Block_Max_X),
               Float (Block_Max_Y));
            Plotter.Stroke_color (Color_Block_Min);
            Plotter.Line_Width (3);
            Plotter.Line
              (Float (Block_Min_X), 0.0, Float (Block_Min_X),
               Float (Block_Min_Y));
            Plotter.Line_Width (1);
         end if;
      end Draw_Block;

      procedure Show_Info is
      begin
         Plotter.Set_Layer_Information;
         Plotter.Stroke_color ("#000");
         Plotter.Fill_Color ("#000");
         Plotter.Font ("sans-serif", "22px");
         Plotter.Text_Align ("left");
         Plotter.Text
           (400_000.0, 555.0,
            "Blocks of 10.000 numbers: min, average and max " &
            "lengths of Collatz sequences");
         Plotter.Line_Width (1);
         Plotter.Line
           (575_000.0, 550.0, Float (Block_Min_X - 1),
            Float (Block_Min_Y + 1));
         Plotter.Line
           (625_000.0, 550.0, Float (Seed), Σ_Length / Float (Block_Size));
         Plotter.Line
           (685_000.0, 550.0, Float (Block_Max_X - 1),
            Float (Block_Max_Y + 1));
         Plotter.Pause;
      end Show_Info;

      procedure Show_Intuition is
      begin
         Plotter.Set_Layer_Information;
         Plotter.Stroke_color ("#000");
         Plotter.Fill_Color ("#000");
         Plotter.Line_Width (1);
         Plotter.Line (75_000.0, 465.0, 50_000.0, 405.0);
         Plotter.Font ("sans-serif", "22px");
         Plotter.Text
           (50_000.0, 470.0,
            "Intuition:" & "same as " &
            (if Option_Reverse then "previous" else "next") &
            " interval, scaled 1/10");
         Plotter.Line_Width (4);
         Plotter.Line_Dash (5, 3);
         Plotter.Stroke_color (Color_Last_Rectangle);
         Plotter.Rectangle (-10.0, 401.0, 99_999.0, -1.0);
         Plotter.Line_Dash (10, 0);

         Plotter.Pause;
         Block_Size := (if Option_Reverse then 5_000 else 10_000);
      end Show_Intuition;

   begin  -- Task

      accept Initialize (P : not null Plotters.Pointer_To_Plotter_Class) do
         Plotter        := P;
         Option_Reverse :=
           Project_Euler.Argument_Parser.Boolean_Value ("REVERSE");
      end Initialize;

      Plotter_Setup (Plotter);

      Infinite_Loop :
      loop

         accept Start;

         Plotter.Start;
         Plotter.Fill_Color (Color_Fill_Rectangle);

         if Option_Reverse then
            Seed       := 999_999;
            Δ_Seed     := -1;
            Seed_Pause := 790_000;
            Seed_Stop  := 1;
            Block_Size := 10_000;
         else
            Seed       := 1;
            Δ_Seed     := 1;
            Seed_Pause := 390_000;
            Seed_Stop  := 999_999;
            Block_Size := 5_000;
         end if;
         Number     := 0;
         Length     := 0;
         Answer     := 0;
         Max_Length := 0;

         Σ_Length := 0.0;
         Has_Max  := False;

         Problem_Loop :
         loop

            Number := Collatz_Next (Seed);
            Length := 1;

            loop
               Number := Collatz_Next (Number);
               Length := @ + 1;
               exit when Number = 1;
            end loop;

            Σ_Length := @ + Float (Length);

            if Length > Max_Length then
               Answer     := Seed;
               Max_Length := Length;
               Has_Max    := True;
            end if;

            if Length > Block_Max_Y then
               Block_Max_X := Seed;
               Block_Max_Y := Length;
            end if;

            if Length < Block_Min_Y then
               Block_Min_X := Seed;
               Block_Min_Y := Length;
            end if;

            --  Block_Finished
            if Seed mod Block_Size = 0 or else Seed = Seed_Stop then

               Draw_Block;

               if Seed = Seed_Pause then
                  Show_Info;
                  goto Pause_And_Accept_Continue_Or_Stop;
               elsif Seed = 100_000 then
                  Show_Intuition;
                  goto Pause_And_Accept_Continue_Or_Stop;
               else
                  goto Do_Not_Pause;
               end if;

               <<Pause_And_Accept_Continue_Or_Stop>>
               select
                  accept Continue;
                  Plotter.Clear_Plot;
                  Plotter.Set_Layer_Drawing;
               or
                  accept Stop;
                  exit Problem_Loop;
               end select;

               <<Do_Not_Pause>>
               select
                  accept Stop;
                  exit Problem_Loop;
               or
                  delay 0.002;
               end select;

               Σ_Length    := 0.0;
               Has_Max     := False;
               Block_Max_Y := 0;
               Block_Min_Y := Integer_Type'Last;
            end if;

            exit Problem_Loop when Seed = Seed_Stop;
            Seed := Seed + Δ_Seed;

         end loop Problem_Loop;

         Plotter.Stop;
         Plotter.Answer (To_String (Answer));

      end loop Infinite_Loop;
   end Problem_Task;

end P0014_Longest_Collatz_Sequence.GUI;
