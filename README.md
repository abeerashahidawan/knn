# K-N-N Classifier FPGA Implementation

## Project Overview

This project involves designing and implementing a K-Nearest Neighbors (K-N-N) classifier on an FPGA. The classifier is used for data classification by finding the closest K neighbors among the training points and assigning the majority label from these neighbors to an unknown entry.

### Tasks

1. **Present an RTL Diagram:**
   - Design an RTL diagram that illustrates the working of the K-N-N algorithm.
   - **Requirements:**
     - Data points and the unknown entry (X) are 2D, with each datapoint being 8-bit wide.
     - Distance is computed using the City Block Distance formula: \( \text{Distance} = |x_2 - x_1| + |y_2 - y_1| \)
     - The system processes N-known data points with labels ranging from 0 to 3.
     - Specify bus width, memory (depth, address lines), and design type (FDA, TSA, Pipelined, etc.).

2. **Write Synthesizable RTL Verilog Code:**
   - Develop the Verilog code for the designed RTL diagram.
   - Create a testbench to validate the functionality of the code.

3. **Timing and Utilization Summary:**
   - Once the code is approved, provide a summary of timing and resource utilization using Xilinx tools.

4. **FPGA Implementation:**
   - Run the synthesizable code on a Spartan 6 FPGA (details to be shared later).

## Files

- **Project-1 (FPGA Stream).pdf**: Contains the project problem statement and detailed requirements.
- **KNN.v**: The Verilog code for the K-N-N classifier.

## Instructions

1. **Setup:**
   - Ensure you have Xilinx tools installed for synthesis and implementation.
   - Prepare your FPGA environment (Spartan 6).

2. **Design Verification:**
   - Review the RTL diagram to ensure it meets all specified requirements.
   - Verify the Verilog code through simulation using the provided testbench.

3. **Synthesis and Implementation:**
   - Use Xilinx tools to synthesize the Verilog code.
   - Generate the timing and utilization summary.
   - Implement the design on the Spartan 6 FPGA and validate its functionality.

## Contact

For any queries or assistance, please reach out to your project supervisor or the RISETech Internship coordinator.

---

You can modify this draft based on any additional details or specific instructions you might have.
