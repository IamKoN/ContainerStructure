with Ada.Text_IO, Ada.Integer_Text_IO; use Ada.Text_IO;
with MakeCar, MakePlane; use MakeCar, MakePlane;
with List_Package; use List_Package;

procedure UAbstStc is
   type dllPtr is access doublyLinkedList;
   VehicleStack:  dllPtr := new doublyLinkedList;
   NewCar, NewPlane, VehiclePt: dllElementPtr;
   
   --Allow at least one task to place items in the list and a second task to remove items from the list.
   --Allow multiple tasks to place items in the list and  multiple tasks to remove items from the list preventing RACE conditions!
   --task type Encap_Buffer (Param : Integer := 0);
   task type Encap_Buffer is
      entry Insert (VehiclePt: in dllElementPtr);
      entry Remove (VehiclePt: out dllElementPtr);
   end Encap_Buffer;

   task body Encap_Buffer is
      Datum : dllElementPtr;
   begin
      accept Insert (VehiclePt : in  dllElementPtr) do
         Datum := VehiclePt;
      end Insert;
      loop
         select
            accept Insert (VehiclePt : in  dllElementPtr) do
               Datum := VehiclePt; end Insert;
         or
            accept Remove (VehiclePt : out dllElementPtr) do
               VehiclePt := Datum;
            end Remove;
         end select;
      end loop;
   end Encap_Buffer;
   
   type BufferPtr is access Encap_Buffer;
   type InsertArr is array (Integer range <>) of BufferPtr;
   newArr : InsertArr(1..StackSize(VehicleStack.All));
  
begin
   --a
   NewCar := new Car;
   AssignNumDoors(Car'Class(NewCar.All), 4);
   AssignManufacturer(Car'Class(NewCar.All), "Ford");
   InsertRear(VehicleStack, NewCar);
   
   --b
   NewCar := new Car;
   AssignNumDoors(Car'Class(NewCar.All), 2);
   AssignManufacturer(Car'Class(NewCar.All), "Ford");
   InsertFront(VehicleStack, NewCar);
   
   --c
   NewCar := new Car;
   AssignNumDoors(Car'Class(NewCar.All), 2);
   AssignManufacturer(Car'Class(NewCar.All), "GMC ");
   InsertRear(VehicleStack, NewCar);
   
   --d
   NewCar := new Car;
   AssignNumDoors(Car'Class(NewCar.All), 2);
   AssignManufacturer(Car'Class(NewCar.All), "RAM ");
   InsertRear(VehicleStack, NewCar);

   --e
   NewCar := new Car;
   AssignNumDoors(Car'Class(NewCar.All), 3);
   AssignManufacturer(Car'Class(NewCar.All), "Chev");
   InsertFront(VehicleStack, NewCar);  

   --f
   Put_Line("List size: " & Integer'Image(StackSize(VehicleStack.All))); New_Line;
   
   --g
   Put_Line("Current List: ");
   for I in reverse 1..StackSize(VehicleStack.All) loop
      VehiclePt := findItem(VehicleStack, I);
      printItem(VehicleStack, VehiclePt);
   end loop;

   --h
   VehiclePt := findItem(VehicleStack, 4);
   delete(VehicleStack, VehiclePt);
   
   --i
   Put_Line("List size: " & Integer'Image(StackSize(VehicleStack.All))); New_Line;
   
   --j
   Put_Line("Current List: ");
   for I in reverse 1..StackSize(VehicleStack.All) loop
      VehiclePt := findItem(VehicleStack, I);
      printItem(VehicleStack, VehiclePt);
   end loop;
  
   --k
   NewPlane := new Plane;
   AssignNumDoors(Plane'Class(NewPlane.All), 3);
   AssignNumEngines(Plane'Class(NewPlane.All), 6);
   AssignManufacturer(Plane'Class(NewPlane.all), "Boeing  ");
   InsertFront(VehicleStack, NewPlane);

   --l
   NewPlane := new Plane;
   AssignNumDoors(Plane'Class(NewPlane.All), 2);
   AssignNumEngines(Plane'Class(NewPlane.All), 1);
   AssignManufacturer(Plane'Class(NewPlane.all), "Piper   ");
   InsertFront(VehicleStack, NewPlane);
    
   --m
   NewPlane := new Plane;
   AssignNumDoors(Plane'Class(NewPlane.All), 4);
   AssignNumEngines(Plane'Class(NewPlane.All), 4);
   AssignManufacturer(Plane'Class(NewPlane.all), "Cessna  ");
   InsertFront(VehicleStack, NewPlane);
         
   --n
   Put_Line("Current List: ");
   for I in reverse 1..StackSize(VehicleStack.all) loop
      VehiclePt := findItem(VehicleStack, I);
      printItem(VehicleStack, VehiclePt);
   end loop;
   
   --A++
   VehiclePt := new Plane'(dllElement with 4, 6, "Sipher  "); --heap allocation example
   newArr(1).Insert(VehiclePt);

   Put_Line("Current List: ");
   for I in reverse 1..StackSize(VehicleStack.all) loop
      VehiclePt := findItem(VehicleStack, I);
      printItem(VehicleStack, VehiclePt);
   end loop;

end UAbstStc;
