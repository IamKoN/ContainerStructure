-- in file MakeCar.ads
with List_Package;
package MakeCar is

  type String4 is new String(1..4);

  type Car is new List_Package.dllElement with record
     NumDoors:  integer := 2;
     Manufacturer: String4 := "GMC ";  -- Sample default value.
  end record;
 
  procedure AssignNumDoors(aCar: in out Car; N: in integer); 

  procedure AssignManufacturer(aCar: in out Car; Manu: in String4); 
 
  procedure PrintNumDoors(aCar: in Car); 

  procedure PrintManufacturer(aCar: in Car); 

  procedure IdentifyVehicle(aCar: in Car);
end MakeCar;
