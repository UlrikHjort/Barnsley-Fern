-------------------------------------------------------------------------------
--                                                                           --
--                              Barnsley Fern                                --
--                                                                           --
--                                 Ifs.adb                                   --
--                                                                           --
--                                  BODY                                     --
--                                                                           --
--                  Copyright (C) 1996 Ulrik Hørlyk Hjort                    --
--                                                                           --
--  Barnsley Fern is free software;  you can redistribute it                 --
--  and/or modify it under terms of the  GNU General Public License          --
--  as published  by the Free Software  Foundation;  either version 2,       --
--  or (at your option) any later version.                                   --
--  Barnsley Fern is distributed in the hope that it will be                 --
--  useful, but WITHOUT ANY WARRANTY;  without even the  implied warranty    --
--  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                  --
--  See the GNU General Public License for  more details.                    --
--  You should have  received  a copy of the GNU General                     --
--  Public License  distributed with Yolk.  If not, write  to  the  Free     --
--  Software Foundation,  51  Franklin  Street,  Fifth  Floor, Boston,       --
--  MA 02110 - 1301, USA.                                                    --
--                                                                           --
-------------------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics.Discrete_Random; use Ada.Numerics;

package Body Ifs is

   ----------------------------------------------------------------------
   -- Read the coefficient list and probability list from file Filename
   ----------------------------------------------------------------------
   procedure Read_Data(Filename: in String; Coefficient_List : in out Float_Multi_Array_T;
                                            Probability_List :in out Float_Array_T) is

      Data_File  : FILE_TYPE;

   begin
      Open(Data_File, In_File, Filename);

            for Index in Probability_List'First .. Probability_List'Last loop
               Get(Data_File, Probability_List(Index));
            end loop;

      for Row in Coefficient_List'First(1) .. Coefficient_List'Last(1) loop
            for Index in Coefficient_List'First(2) .. Coefficient_List'Last(2) loop
               Get(Data_File, Coefficient_List(Row,Index));
            end loop;
      end loop;

      Close(Data_File);
   exception
      -- Constraint_Error raised if empty lines in
      -- the data file. We ignore this.
      when Constraint_Error =>
      Close(Data_File);
      when Name_Error =>
         Put_Line("File: " & Filename & " does not exist");
         raise Name_Error;
   end Read_Data;


   --------------------------------------------------------
   -- Generate the iterated function system from the given
   -- data set file Filename
   --------------------------------------------------------
   procedure Generate(Filename : String) is
      Number_Of_Rows         : constant Positive := 4;
      Number_Of_Coefficients : constant Positive := 6;
      Probabilities          : constant Positive := 5;
      Number_Of_Iterations   : constant Positive := 100000;

      subtype Row_Range is Positive range  1 .. Number_Of_Rows;
      subtype Coefficient_Range is Positive range  1 .. Number_Of_Coefficients;

      Coefficient_List : Float_Multi_Array_T (Row_Range, Coefficient_Range);
      Probability_List : Float_Array_T(1 .. Probabilities) := (others => 0.0);

      subtype Random_Interval is Natural range 0..Natural'Last;
      package Random_Natural is new Discrete_Random(Random_Interval);
      use Random_Natural;

      G              : Generator;
      RandomVal      : Float := 0.0;
      Break_Loop     : Boolean := False;
      X1, Y1, X2, Y2 : Float := 0.1;

   begin
      Read_Data(Filename, Coefficient_List, Probability_List);

      for I in 1 .. Number_Of_Iterations loop
         RandomVal := Float(Random(G))/Float(Natural'Last);

         Inner_Loop:
             for Row in 1 .. Number_Of_Rows loop
                -- Calculate a new point f RandomVal is between the probability factors for the current
                -- coefficient row and the next coefficient row:
                if ((RandomVal >= Probability_List(Row)) and (RandomVal <= Probability_List(Row+1))) then
                   X2 := (Coefficient_List(Row,1) * X1)+ (Coefficient_List(Row,2) * Y1) + Coefficient_List(Row,5);
                   Y2 := (Coefficient_List(Row,3) * X1)+ (Coefficient_List(Row,4) * Y1) + Coefficient_List(Row,6);
                   Break_Loop := True;
                end if;
                exit Inner_Loop When Break_Loop;
         end loop Inner_Loop;

         Break_Loop := False;

         X1 := X2;
         Y1 := Y2;

         Put(Item => X1, EXP => 0);
         Put(" ");
         Put(Item => Y1, EXP => 0);

         New_Line;
      end loop;
   end Generate;
end Ifs;
