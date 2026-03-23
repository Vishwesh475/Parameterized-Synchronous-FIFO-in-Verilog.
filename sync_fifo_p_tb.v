module sync_fifo_tb;

    parameter Width = 32;
    parameter Depth = 32;

    reg clk,rst,w_en,r_en;
    reg [Width - 1:0] din;
    wire [Width - 1:0] dout;
    wire full, empty;

    sync_fifo # (
        .Width(Width),
        .Depth(Depth)
    ) uut (
        .clk(clk),
        .rst(rst),
        .w_en(w_en),
        .r_en(r_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, sync_fifo_tb);

        clk = 0;
        rst = 1;
        w_en = 0;
        r_en = 0;
        din = 0;

        #10 rst = 0;

        repeat (Depth) begin
            @(posedge clk);
            w_en = 1;
            din = din + 1;
        end

        @(posedge clk);
        w_en = 0;

        repeat (Depth) begin
            @(posedge clk);
            r_en = 1;
        end

        @(posedge clk);
        r_en = 0;

        #20 $finish;
    end

endmodule
