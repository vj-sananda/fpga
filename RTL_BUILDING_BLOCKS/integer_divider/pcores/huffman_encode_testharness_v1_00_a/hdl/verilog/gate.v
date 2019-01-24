`timescale 1ps/1ps

module gate(dout,din);
parameter upper =0, lower = 0; // default width of output
input [upper:lower] din;
output wire [upper:lower] dout;

assign   dout[upper:lower] = din[upper:lower];

endmodule
