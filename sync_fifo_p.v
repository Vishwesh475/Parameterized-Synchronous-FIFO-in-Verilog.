module sync_fifo # (
    parameter Width = 32,
    parameter Depth = 32,
    parameter Address_Width = $clog2(Depth)	
)(
    input clk, rst, w_en, r_en,
    input [Width - 1:0]din,
    output reg [Width - 1:0] dout,
    output full, empty
);
    //MEMORY DECLARATION

    reg [Width - 1:0] mem [0:Depth - 1];

    //READ-WRITE POINTERS

    reg[Address_Width:0] i,j;

    //FULL AND EMPTY

    assign empty = (i == j);
    assign full = (i[Address_Width - 1:0] == j[Address_Width -1:0]) && (i[Address_Width] != j[Address_Width]);

    //WRITE OPERATION

    always@(posedge clk)
    begin
        if(rst) 
        begin
            i <= 0;
        end
        else if(w_en && !full)
        begin
            mem[i[Address_Width - 1:0]] <= din;
            i <= i + 1;
        end
    end

    //READ OPERATION

    always@(posedge clk)
    begin
        if(rst)
        begin
            j <= 0;
            dout <= 0;
        end
        else if(r_en && !empty)
        begin
            dout <= mem[j[Address_Width - 1:0]];
            j <= j + 1;
        end
    end
endmodule
