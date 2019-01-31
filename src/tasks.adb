with Ada.Text_IO; use Ada.Text_IO;
procedure Tasks is
    task Looper is
        entry Pause;
        entry Resume;
    end Looper;

    task body Looper is
        Running: Boolean := True;
        Count: Integer := 0;
    begin
        loop
            select
                accept Pause do
                    Running := False;
                end;
            or
                accept Resume do
                    Running := True;
                end;
            else
                null;
            end select;
            delay 1.0;
            if Running then
                Put_Line("Running, Count = " & Integer'Image(Count));
            end if;
            Count := Count + 1;
        end loop;
    end Looper;

   
   task type Insert (Param : Integer := 0);
   type InsertPtr is access Insert;
   type InsertArr is array (Integer range <>) of InsertPtr;
   
  -- type arr is array (Integer range <>) of T;
  -- type arrayPtr is access arr;
  -- newArr : arrayPtr;
   
   task body Insert is
   begin
      Put_Line ("t" & Param'Img);
      InsertFront(VehicleStack, VehiclePt);
   end Insert;
   N, M : Integer;
   
   
begin -- T
    loop
        delay 3.0;
        Looper.Pause;
        delay 3.0;
        Looper.Resume;
    end loop;

   N := 3; -- number of inserts to perform
   M := 5;
   Put ("number of tasks: ");
   Ada.Integer_Text_IO.Get (N);
   Put ("parameter: ");
   Ada.Integer_Text_IO.Get (M);
   
   -- newArr := new arrayPtr(1..N);

   declare
   -- Create an array of the required size and populate it with
   -- newly allocated T's, each constrained by the input parameter
      Arr : InsertArr(1 .. N) := (others => new Insert (Param => M));
   begin
      null;
   end;
   
     --elem: String_For_Record;
     --   if Headptr = list.Head then asep := Headptr;
     --   else Headptr := Headptr.Next; asep := Headptr;
     --   end if; elem := To_Buffer(asep);  put(elem);         
   
         --if Headptr.ID = targetID then return Headptr; end if;
         --while Headptr.ID /= targetID loop Headptr.ID := Headptr.ID + 1; end loop; return Headptr;
         
         --while Headptr /= null loop
         --  if Headptr.ID = targetID then return Headptr; --else Headptr:= Headptr.Next;
         --   end if; Headptr := Headptr.Next; count := count + 1;
         --end loop; Headptr := list.Head;
         --for I in 1..(count - targetID + 1) loop Headptr := Headptr.Next; end loop; return Headptr;


end Tasks;

task type My_Task is
   entry Start;
   entry Pause;
   entry Quit;
   entry Stop;
end My_Task;

-- (...)
task body My_Task is
begin
   Outer_Loop : loop
      select
         accept Start;

         Main_Loop : loop
            select
               accept Pause;

               select
                  accept Quit;
               or
                  accept Stop;
                  exit Outer_Loop;
               or
                  terminate;
               end select;
            or
               accept Stop;
               exit Outer_Loop;
            else
               Put ("Main code here");
               delay MYCYCLE; -- MYCYCLE is 2.0; (whatever)
            end select;
         end loop Main_Loop;
      or
         terminate;
      end select;
  end loop Outer_Loop;
end My_Task;
