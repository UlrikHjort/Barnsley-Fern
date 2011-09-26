-------------------------------------------------------------------------------
--                                                                           --
--                              Barnsley Fern                                --
--                                                                           --
--                                 Ifs.ads                                   --
--                                                                           --
--                                  SPEC                                     --
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

package Ifs is

   type Float_Multi_Array_T is array (Positive range <>, Positive range <>) of Float;
   type Float_Array_T is array (Positive range <>) of Float;

   --------------------------------------------------------
   -- Generate the iterated function system from the  given
   -- data set file Filename
   --------------------------------------------------------
   procedure Generate(Filename : String);
end Ifs;
