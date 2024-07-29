# K-N-N Classifier FPGA Implementation

## Project Overview

This project involves designing and implementing a K-Nearest Neighbors (K-N-N) classifier on an FPGA. The classifier is used for data classification by finding the closest K neighbors among the training points and assigning the majority label from these neighbors to an unknown entry.

### Tasks

1. **Present an RTL Diagram:**
   - Design an RTL diagram for the K-N-N algorithm.
   - **Requirements:**
     - Data points and the unknown entry (X) are 2D, with each datapoint being 8 bits wide.
     - Distance is calculated using the City Block Distance formula: ({Distance} = |x_2 - x_1| + |y_2 - y_1|).
     - The system processes 128 known data points with labels ranging from 0 to 3.
     - The K value is 5.

2. **Write Synthesizable RTL Verilog Code:**
   - Develop the Verilog code for the designed RTL diagram.
   - Create a testbench to validate the functionality of the code.

3. **Timing and Utilization Summary:**
   - Provide a summary of timing and resource utilization using Xilinx tools.

4. **FPGA Implementation:**
   - Run the synthesizable code on a Spartan 6 FPGA.

## Files

- **project_Statement.pdf**: Detailed project problem statement and requirements.
- **KNN.v**: Verilog code for the K-N-N classifier.
- **knn_topModule.v**: Top module for the K-N-N classifier, including a slowed clock for FPGA.
- **knn_tb.v**: Testbench for verifying functionality.
- **dataset.txt**: Contains 128 labeled data points.
- **knn_controlUnit.v**: Control unit with a 3-state FSM to manage flow:
  - State 1: Calculate distances for 128 data points and maintain K sorted minimum distances.
  - State 2: Count label frequency for each label.
  - State 3: Perform majority voting to determine the label for the unknown data point.

## Instructions
