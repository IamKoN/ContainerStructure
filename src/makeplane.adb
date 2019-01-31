with Ada.Text_IO; use Ada.Text_io; 
with List_Package;
package body MakePlane is
  package IntIO is new Ada.Text_IO.Integer_IO(Integer);  use IntIO;

  procedure AssignNumDoors(aPlane: in out Plane; N: in integer) is
  begin aPlane.NumDoors := N; end AssignNumDoors;

  procedure AssignManufacturer(aPlane: in out Plane; Manu: in String8) is
  begin aPlane.Manufacturer := Manu; end AssignManufacturer;
 
  procedure AssignNumEngines(aPlane: in out Plane; NE: in integer) is
  begin aPlane.NumEngines := NE; end AssignNumEngines;

  procedure PrintString8(PrtStr: String8) is
  begin for I in 1..8 loop  put(PrtStr(I));   end loop; end PrintString8;

  procedure PrintPlane(aPlane: in Plane) is
  begin 
        put("Num doors for plane = "); put(aPlane.NumDoors, 4); new_line;
        put("Number engines = "); put(aPlane.NumEngines); new_line;
        put("Manufacturer = "); PrintString8(aPlane.Manufacturer); new_line;
  end PrintPlane;

  procedure IdentifyVehicle(aPlane: in Plane) is
  begin 
    put("Plane with"); put(aPlane.NumDoors,4); put(" doors,");
    put(aPlane.NumEngines,4); put(" engines, made by ");
    PrintString8(aPlane.Manufacturer); new_line;
  end IdentifyVehicle; 
end MakePlane;
