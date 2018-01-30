-- in file MakeCar.adb
with Ada.Text_IO; use Ada.Text_io;
with List_Package;
package body MakeCar is
  package IntIO is new Ada.Text_IO.Integer_IO(Integer);  use IntIO;

  procedure AssignNumDoors(aCar: in out Car; N: in integer) is
  begin aCar.NumDoors := N; end AssignNumDoors;

  procedure AssignManufacturer(aCar: in out Car; Manu: in String4) is
  begin aCar.Manufacturer := Manu; end AssignManufacturer;
 
  procedure PrintNumDoors(aCar: in Car) is
  begin put("Num doors = "); put(aCar.NumDoors); new_line; end PrintNumDoors;

  procedure PrintString4(PrtStr: String4) is
  begin for I in 1.. 4 loop 
     put(PrtStr(I)); 
  end loop; end PrintString4;

  procedure PrintManufacturer(aCar: in Car) is
  begin put("Manufacturer is "); PrintString4(aCar.Manufacturer); new_line; end;

  procedure IdentifyVehicle(aCar: in Car) is
  begin 
    put("Car with"); put(aCar.NumDoors,4); put(" doors"); 
    put(" made by "); PrintString4(aCar.Manufacturer); new_line;
  end IdentifyVehicle; 
end MakeCar;
