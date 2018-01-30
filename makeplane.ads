--  file MakePlane.ads:  Create planes for use with heterogeneous container.
with List_Package;
package MakePlane is
   --package useList is new List_Package(ItemType, max);
   type String8 is new String(1..8);

   type Plane is new List_Package.dllElement with record
      NumDoors:  integer:= 2;
      NumEngines:  integer := 2;
      Manufacturer: String8 := "Boeing  ";
   end record;
 
   procedure AssignNumDoors(aPlane: in out Plane; N: in integer); 

   procedure AssignManufacturer(aPlane: in out Plane; Manu: in String8); 
 
   procedure AssignNumEngines(aPlane: in out Plane; NE: in integer);

   procedure PrintPlane(aPlane: in Plane); 

   procedure IdentifyVehicle(aPlane: in Plane); 
end MakePlane;
