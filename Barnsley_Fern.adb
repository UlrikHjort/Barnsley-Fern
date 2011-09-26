-------------------------------------------------------------------------------
--                                                                           --
--                              Barnsley Fern                                --
--                                                                           --
--                            Barnsley-fern.adb                              --
--                                                                           --
--                                  Main                                     --
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
with Ada.Command_Line; use Ada.Command_Line;
with Ifs; use Ifs;

procedure Barnsley_Fern is
begin
   if Argument_Count = 1 then
      Generate(Argument(1));
   else
      Put_Line("Usage: :/barnsley_fern <FILENAME>");
   end if;
end Barnsley_Fern;
