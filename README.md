This project implements a parameterized synchronous FIFO (First-In First-Out) buffer in Verilog. The design is fully configurable in terms of data width and depth, making it reusable across different digital systems such as buffering, data streaming, and communication interfaces.

The FIFO operates on a single clock domain, where both read and write operations are synchronized to the same clock. It uses circular buffer logic with separate read and write pointers, along with an extra MSB bit to accurately detect full and empty conditions without ambiguity.
