with Ada.Text_IO; use Ada.Text_IO;
with ada.Unchecked_Deallocation; with Unchecked_Conversion;
with MakeCar, MakePlane; use MakeCar, MakePlane;
package body List_Package is
   
   Record_Character_Size: Natural := (dllElementPtr'Size/ Character'Size);
   subtype String_For_Record is String(1 .. Record_Character_Size);
   function To_Buffer is new Unchecked_Conversion(dllElementPtr, String_For_Record);
   function freeBuffer is new Unchecked_Conversion(dllElementPtr, dllNodePtr);
   
   --For garbage collection and reuse of Nodes by reclaiming heap storage
   procedure free is new Ada.Unchecked_Deallocation(dllElementPtr, dllNodePtr); 

   --get list size
   function StackSize(list: doublyLinkedList) return integer is
   begin  return list.Count;  end StackSize;
   
   --insert element in the front of the list
   procedure InsertFront(list: access doublyLinkedList; asep: in dllElementPtr) is
      Headptr, Mainptr: dllElementPtr := list.Head;
      countIF, countID: Integer := 0;
   begin
      if list.Head = null then 
         list.Head := asep; list.Tail := list.Head; --asep
         asep.Prev := null; asep.Next := null;
      else
         asep.Next := list.Head; list.Head.Prev := asep;
         list.Head := asep; asep.Prev := null;
      end if;
      list.Count := list.Count + 1;  countIF := countIF + 1;
      asep.ID := 1;
      Headptr := asep;
      Mainptr := asep;
      
      --for setting index ID
      while countIF > countID loop
         Headptr := Headptr.Next;
         countID := countID + 1;
      end loop;
      while Headptr /= null loop
         Mainptr := Mainptr.Next;
         Headptr := Headptr.Next; 
         Mainptr.ID := Mainptr.ID + 1;
      end loop;
   end InsertFront;
   
   --insert element on the rear of the list
   procedure InsertRear(list: access doublyLinkedList; asep: in dllElementPtr) is
   begin
      if list.Head = null then
         list.Tail := asep; list.Head := list.Tail; --asep
         asep.Next := null; asep.Prev := null;
      else
         asep.Prev := list.Tail; list.Tail.Next := asep;
         list.Tail := asep; asep.Next := null;
      end if;
      list.Count := list.Count + 1;
      
      --setting index ID
      asep.ID := list.Count;
   end InsertRear;
   
   --Pop an element from the Head of the list
   function Pop(list: access doublyLinkedList) return dllElementPtr is
      asep: dllElementPtr;
      freeElem: dllNodePtr;
   begin
      if list.Head = null then return null; -- Check for underflow
      else
         asep := list.Head;
         list.Head := list.Head.Next;
         freeElem := freeBuffer(asep); free(freeElem);
         list.Count:= list.Count - 1;
         return asep;
      end if;
   end Pop;
   
   --print the contents of the item given a pointer to the node containing the item
   procedure printItem(list: access doublyLinkedList; asep: dllElementPtr) is
      Headptr: dllElementPtr := list.Head;
      count: Integer := 0;
   begin
      if list.Head = null then put("Underflow"); -- Check for underflow
      else
         Put("List element" & Integer'Image(asep.ID) & ": ");
         if asep.all in Car then
            IdentifyVehicle(Car'Class(asep.All));
         elsif asep.all in Plane then
            IdentifyVehicle(Plane'Class(asep.All));
         end if; new_line;
      end if;
   end printItem;
   
   --delete a random item from the doubly linked list given its pointer to the item
   procedure delete(list: access doublyLinkedList; asep: in out dllElementPtr) is
      Headptr: dllElementPtr := list.Head;
   begin
      if list.Head = null or asep = null then Put_Line("Empty List or ASEP");
      else
         --if list.Head = asep then list.Head := asep.Next; else asep.Prev.Next := asep.Next; end if;
         if asep.Prev = null or list.Head = asep then
            list.Head := asep.Next;
         else
            asep.Prev.Next := asep.Next; end if;
         if asep.Next = null then
            list.Tail := asep.Prev;
         else
            asep.Next.Prev := asep.Prev; end if;
         list.Count := list.Count - 1;
         --else asep.Prev := asep; asep := asep.Next; end if;
         
         Headptr := asep;
         for I in asep.ID..list.Count loop
            Headptr := Headptr.Next; Headptr.ID := Headptr.ID - 1;
         end loop;
      end if;     
   end delete;
   
   --search for an item returning a pointer to it if found, null if not found
   function findItem(list: access doublyLinkedList; targetID: Integer) return dllElementPtr is
      Headptr, Mainptr: dllElementPtr := list.Head;
      count: Integer := 0;
   begin 
      if list.Head = null then return null; -- Check for underflow
      else  
         while count < targetID loop
            Mainptr := Mainptr.Next;
            count := count + 1;
         end loop;
         while Mainptr /= null loop
            Mainptr := Mainptr.Next;
            Headptr := Headptr.Next;
         end loop;
         return Headptr;
      end if;
   end findItem;
   
   --find and return next pointer of item given an index ID number
   function nextItem(list: access doublyLinkedList; targetID: Integer) return dllElementPtr is
      Headptr, Mainptr: dllElementPtr := list.Head;
      count: Integer := 0;
   begin
      if list.Head= null then return null;-- Check for underflow 
      else
         while targetID > count loop
            Mainptr := Mainptr.Next;
            count := count + 1;
         end loop;
         while Mainptr /= null loop
            Mainptr := Mainptr.Next;
            Headptr := Headptr.Next;
         end loop;
         return Headptr.Next;
      end if;
   end nextItem;
   
end List_Package;
