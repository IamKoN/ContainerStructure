package List_Package is
   -- Container stack, stack element, and element pointer types
   -- Allow access to AbstractStackElement and any class inheriting from AbstractStackElement.
   type doublyLinkedList is limited private;
   type dllElement is tagged private;
   type dllElementPtr is access all dllElement'Class;

   --BAG/ container
   procedure InsertFront(list: access doublyLinkedList; asep: in dllElementPtr);
   procedure InsertRear( list: access doublyLinkedList; asep: in dllElementPtr);
   procedure delete(list: access doublyLinkedList; asep: in out dllElementPtr);
   procedure printItem(list: access doublyLinkedList; asep: dllElementPtr);
   
   function StackSize(list: doublyLinkedList) return integer;
   function Pop(list: access doublyLinkedList) return dllElementPtr;
   function findItem(list: access doublyLinkedList; targetID: Integer) return dllElementPtr;
   function nextItem(list: access doublyLinkedList; targetID: Integer) return dllElementPtr;
   
   
private
   type dllNodePtr is access dllElement;
   
   type dllElement is tagged -- Allow for heterogeneous stacks via inheritance.
      record
         ID: Integer := 0;
         Next: dllElementPtr;
         Prev: dllElementPtr;
         --Data: dllElementPtr
      end record;

   type doublyLinkedList is limited 
      record
         Count: Integer := 0;  --to track number of items in list.
         Head: dllElementPtr := null; --front
         Tail: dllElementPtr := null; --rear
      end record;
end List_Package;
