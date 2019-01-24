//--------------------------------------------------
// Pseudo Code for Hardware Merge sorter
//Version 2
//Number of entries can be any number,
//(not restricted to powers of 2)
//--------------------------------------------------

//`define DEBUG TRUE
module hw_merge_sort ;
  //Params

  //Number of data entries
  bit [31:0] numEntries = 513;

  //Number of merge sort passes log2(entries)
  bit [31:0] numPasses = $clog2(numEntries);

  bit [31:0] pass = 0; //which merge sort pass
  bit [31:0] num ;

  bit fifoSelect; //tmp var used to select between fifoA & B during fill
  bit [31:0] RdPtr; //ptr used while reading from memory
  bit [31:0] mask ;

  integer CmpA, CmpB; //load operands from fifoA & B
  bit CmpAValid, CmpBValid; //When 1 , indicates data is valid
  integer tmp ;

  bit TestStatus = 1;
  bit [31:0] RdACount; //num entries read from fifoA
  bit [31:0] RdBCount; //num entries read from fifoB
  bit [31:0] RdCountLimit; //Number of consecutive entries read from fifo for sort
  //In merge sort, will start with 1, then 2, 4, 8 etc

  //Model of 2 regions of memory to move merge sort
  //data back and forth
  integer mem[2][int];

  //fifo's that store operands interleaved
  //based on pass number
  //For eg: In the first pass, (pass 0), the
  //fifos will be filled alternately
  //In the 2nd pass (pass 1), the fifos fill alternately 2 elements
  //at a time. Since after the first pass, the array will be sorted
  //in groups of 2.
  //Similar pattern, with 4 elements on 3rd pass and so on.
  mailbox fifoA ;
  mailbox fifoB ;

  //Output fifo, buffers before sending back to memory
  mailbox fifoOut;

  logic clk = 0;
  always #5 clk = ~clk ;

  //Written as a sequential program
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
	  //Initialize memory
      for(int i=0;i<numEntries;i++)
        begin
          mem[0][i] = $urandom_range(1,100);
        end

      `ifdef DEBUG
      //Print out unsorted entries
      for(int i=0;i<numEntries;i++)
        $display("mem[%4d] = %d",i,mem[0][i]);
      `endif

      //Create mailboxes (queues)
      fifoA = new();
      fifoB = new();
      fifoOut = new();

      //Go through passes for merge sort
      for(bit [31:0] p = 0; p < numPasses ; p++)
        begin

          $display("Merge-Pass : %d",p);

          //Fill Fifos
          for( RdPtr =0; RdPtr < numEntries; RdPtr++ )
            begin
              //For pass 0, fifoSelect will go from 0 to 1 alternately, equivalent to looking
              //at the lsb position as RdPtr increments
              //For pass 1, (array is sorted in groups of 2), so fifoSelect will switch
              //polarity every 2 elements, equivalent to looking at next bit position (bit 1)
              //For pass 2, (array is sorted in groups of 4), so fifoSelect will switch
              //polarity every 4 elements, equivalent to looking at bit position 2
              //and so on.
              mask = 32'h01 << p;
              fifoSelect = |(RdPtr & mask) ; //use bitwise OR to get 1 bit result

              //$display("RdPtr=%b, fifoSelect = %b, mask = %b",RdPtr,fifoSelect,mask);

              if (fifoSelect)
                //LSB of p will alternately ping pong between mem[0] and mem[1]
                //p is the pass number
                fifoA.put( mem[p[0]][RdPtr] );
              else
                fifoB.put( mem[p[0]][RdPtr] );

            end //for RdPtr

          RdCountLimit = 32'h01 << p;
          num = 0;

          `ifdef DEBUG
          $display("RdCountLimit = %d", RdCountLimit);
          `endif

          while( fifoOut.num() < numEntries )
            begin

              `ifdef DEBUG
              $display("Fifo out size = %d", fifoOut.num());
              `endif

              RdACount = 0;
              RdBCount = 0;
              CmpAValid = 0;
              CmpBValid = 0;

         	 //Merge sort
              //The fifo size count is being checked when we have non powers of 2
              //We can flush out the remaining entries
              //In HW land, check fifo and that there is no pending DMA transfer
              //i.e have we transferred all N entries.
              while( (RdACount < RdCountLimit || RdBCount < RdCountLimit)
                    && (fifoA.num() + fifoB.num() != 0) )

              begin

                @(posedge clk);

                //Do not attempt to load from a fifo unless there is an entry available
                if ( RdACount < RdCountLimit && CmpAValid == 0 && fifoA.num())
                 begin
                  fifoA.get(CmpA);
                  CmpAValid = 1;
                  RdACount++;
                   `ifdef DEBUG
                   $display("CmpA loaded with :%d, RdACount=%d",CmpA,RdACount);
                   `endif
                 end

                //Do not attempt to load from a fifo unless there is an entry available
                if ( RdBCount < RdCountLimit && CmpBValid == 0 && fifoB.num())
                 begin
                  fifoB.get(CmpB);
                  CmpBValid = 1;
                  RdBCount++;
                   `ifdef DEBUG
                   $display("CmpB loaded with :%d, RdBCount=%d",CmpB,RdBCount);
                   `endif
                 end

                if ( CmpAValid & CmpBValid )
                begin
                  if (CmpA < CmpB)
                    begin
                      fifoOut.put(CmpA);
                      CmpAValid = 0;
                      `ifdef DEBUG
                      $display("Compare:Pushed CmpA to Outfifo:%d",CmpA);
                      `endif
                    end
                  else
                    begin
                      fifoOut.put(CmpB);
                      CmpBValid = 0;
                      `ifdef DEBUG
                      $display("Compare:Pushed CmpB to Outfifo:%d",CmpB);
                      `endif
                    end
                end

                //Flush A if read enough entries from B or B is empty
                //B is empty condition will occur when number of entries are
                //non-powers of 2
                if (CmpAValid && (RdBCount == RdCountLimit || fifoB.num() == 0))
                    begin
                      fifoOut.put(CmpA);
                      CmpAValid = 0;
                      `ifdef DEBUG
                      $display("Flush:Pushed CmpA to Outfifo:%d",CmpA);
                      `endif
                    end

                //Flush B if read enough entries from A or A is empty
                //A is empty condition will occur when number of entries are
                //non-powers of 2
                if (CmpBValid && (RdACount == RdCountLimit || fifoA.num() == 0))
                    begin
                      fifoOut.put(CmpB);
                      CmpBValid = 0;
                      `ifdef DEBUG
                      $display("Flush:Pushed CmpB to Outfifo:%d",CmpB);
                      `endif
                    end

            end //while(1)

          end //while(fifo.size

          //Load up into memory, invert mem select bit
          for(RdPtr=0; RdPtr<numEntries; RdPtr++)
            fifoOut.get(mem[~p[0]][RdPtr] );

        end //for p

      //Check that Entries are indeed sorted
      //Use property of a sorted array in ascending order
      //The i th entry cannot be less than the i-1 th (previous)
      //entry
      tmp = mem[numPasses[0]][0];
      for(int i=0;i<numEntries;i++)
		begin
          if( mem[numPasses[0]][i] < tmp )
            begin
            $error("Entry[%d]=%d, is smaller than Entry[%d]=%d",
                   i,mem[numPasses[0]][i], i-1,tmp);
              TestStatus=0;
            end
          `ifdef DEBUG
          else
            $display("Entry[%d]=%d OK",i,mem[numPasses[0]][i]);
          `endif
          tmp = mem[numPasses[0]][i];
        end

      if (TestStatus)
        $display("> TEST STATUS: ** PASS **");
      else
        $display("> TEST STATUS: -- FAIL --");

	$finish;

    end //initial

endmodule
