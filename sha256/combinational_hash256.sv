`define INDEX(a, i) a[32 * (i)+:32]
`define ROR32(x, n) {x[(n) - 1:0], x[31:(n)]}
 
module round(data, word, hash);
	input [255:0] data;
	input [31:0] word;
	output [255:0] hash;
 
	wire [31:0] a, b, c, d, e, f, g, h;
	wire [31:0] s1, ch, t1, s0, maj, t2;
 
	assign a = `INDEX(data, 0);
	assign b = `INDEX(data, 1);
	assign c = `INDEX(data, 2);
	assign d = `INDEX(data, 3);
	assign e = `INDEX(data, 4);
	assign f = `INDEX(data, 5);
	assign g = `INDEX(data, 6);
	assign h = `INDEX(data, 7);
 
	assign s1 = `ROR32(e, 6) ^ `ROR32(e, 11) ^ `ROR32(e, 25);
	assign ch = g ^ (e & (f ^ g));
	assign t1 = h + s1 + ch + word;
	assign s0 = `ROR32(a, 2) ^ `ROR32(a, 13) ^ `ROR32(a, 22);
	assign maj = (a & b) | (c & (a | b));
	assign t2 = s0 + maj;
 
	assign hash = {g, f, e, d + t1, c, b, a, t1 + t2};
endmodule
 
module chain(init, data, hash);
	input [255:0] init;
	input [511:0] data;
	output [255:0] hash;
 
	wire [31:0] words [0:63];
 
	localparam konst = {
		32'h428a2f98, 32'h71374491, 32'hb5c0fbcf, 32'he9b5dba5,
		32'h3956c25b, 32'h59f111f1, 32'h923f82a4, 32'hab1c5ed5,
		32'hd807aa98, 32'h12835b01, 32'h243185be, 32'h550c7dc3,
		32'h72be5d74, 32'h80deb1fe, 32'h9bdc06a7, 32'hc19bf174,
		32'he49b69c1, 32'hefbe4786, 32'h0fc19dc6, 32'h240ca1cc,
		32'h2de92c6f, 32'h4a7484aa, 32'h5cb0a9dc, 32'h76f988da,
		32'h983e5152, 32'ha831c66d, 32'hb00327c8, 32'hbf597fc7,
		32'hc6e00bf3, 32'hd5a79147, 32'h06ca6351, 32'h14292967,
		32'h27b70a85, 32'h2e1b2138, 32'h4d2c6dfc, 32'h53380d13,
		32'h650a7354, 32'h766a0abb, 32'h81c2c92e, 32'h92722c85,
		32'ha2bfe8a1, 32'ha81a664b, 32'hc24b8b70, 32'hc76c51a3,
		32'hd192e819, 32'hd6990624, 32'hf40e3585, 32'h106aa070,
		32'h19a4c116, 32'h1e376c08, 32'h2748774c, 32'h34b0bcb5,
		32'h391c0cb3, 32'h4ed8aa4a, 32'h5b9cca4f, 32'h682e6ff3,
		32'h748f82ee, 32'h78a5636f, 32'h84c87814, 32'h8cc70208,
		32'h90befffa, 32'ha4506ceb, 32'hbef9a3f7, 32'hc67178f2
	};
 
	genvar i;
 
	generate
		for (i = 0; i < 16; i = i + 1) begin: first
			assign words[i] = `INDEX(data, i);
		end
 
		for (i = 16; i < 64; i = i + 1) begin: blend
			wire [31:0] s0, s1;
 
			assign s0 = `ROR32(words[i - 15], 7) ^
				`ROR32(words[i - 15], 18) ^
				(words[i - 15] >> 3);
			assign s1 = `ROR32(words[i - 2], 17) ^
				`ROR32(words[i - 2], 19) ^
				(words[i - 2] >> 10);
			assign words[i] = words[i - 16] + words[i - 7] +
				s0 + s1;
		end
 
		for (i = 0; i < 64; i = i + 1) begin: array
			wire [31:0] w = `INDEX(konst, 63 - i) + words[i];
			wire [255:0] d, h;
 
			if (i)
				assign d = array[i - 1].h;
			else
				assign d = init;
 
			round step(d, w, h);
		end
 
		for (i = 0; i < 8; i = i + 1) begin: adder
			assign `INDEX(hash, i) = `INDEX(array[63].h, i) +
				`INDEX(init, i);
		end
	endgenerate
endmodule
 
module miner(clk, data, mid, result, found);
	input clk;
	input [255:0] mid;
	input [127:0] data;
	output [31:0] result;
	output found;
 
	reg [31:0] nonce = 32'b0;
 
	wire [255:0] hash1, hash;
 
	chain sha1(mid, {
		32'h00000280, 32'h00000000, 32'h00000000, 32'h00000000, 
		32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 
		32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 
		result, data[95:0]
	}, hash1);
 
	chain sha2({
		32'h5be0cd19, 32'h1f83d9ab, 32'h9b05688c, 32'h510e527f,
		32'ha54ff53a, 32'h3c6ef372, 32'hbb67ae85, 32'h6a09e667
	}, {
		32'h00000100, 32'h00000000, 32'h00000000, 32'h00000000,
		32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000,
		hash1
	}, hash);
 
	assign result = nonce + data[127:96];
	assign found = (32'b0 == `INDEX(hash, 7));
 
	always @(posedge clk)
		nonce <= nonce + 1;
endmodule
