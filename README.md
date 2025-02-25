---
# README: Structural Analysis and Load Simulation Tool

## Introduction
This program enables you to perform detailed structural analysis of beams and other structural elements. With this tool, you can define various parameters and loads to assess static equilibrium and determine resulting reactions such as normal forces, shear forces, and bending moments. The guide below will walk you through the essential steps to set up and use the program.

---

## Setting Up the Program

1. **Add the Beam:**  
   - Enter the desired length of the beam in the "Length" field in the Beam Setup panel.  
   - Click "Add" to place the beam into the workspace.  
   - Optionally, select a material to evaluate safety (e.g., for yielding or fracture), or leave the default "Standard" option.

2. **Define Beam Profile (Optional):**  
   - Select one of the available beam profiles under the "Bar Profile" tab.  
   - This profile is used to compute the safety factor against deformation and fracture.

3. **Define Supports:**  
   - Choose the type of support (e.g., fixed, roller, or pinned) from the Support panel.  
   - Specify the support position and click "Add."

4. **Add Joints:**  
   - Joints allow you to specify particular movement conditions within the structure.  
   - Choose between rotational joints, shear force joints, or normal force joints.  
   - Specify the joint location in the Joints panel and click "Add."

5. **Apply Forces and Moments:**  
   - In the "Loads" panel, specify the force magnitude, angle, and position.  
   - Click "Add" to apply the force or moment.

6. **Add Distributed Loads:**  
   - Select between constant, linear, or quadratic load types.  
   - Enter the start and end positions, an optional start value, and the pitch (calculated as Δy/Δx, where Δx is the distance between the start and end positions, and Δy is the maximum load variation).  
   - If a nonzero start value is specified, Δy is computed as the difference between the maximum load and the start value.

7. **Verify and Calculate:**  
   - Ensure that the system is in static equilibrium.  
   - A green status indicator along with numerical values in the bottom right confirms equilibrium.  
   - Click "Calculate" to perform the analysis.

8. **View Results:**  
   - After calculation, input a specific position in the bottom right panel to view the corresponding values for normal force, shear force, and bending moment.

---

## Additional Information

- **Editing:**  
  Use the Undo/Redo functions in the Edit menu to revert or restore changes.

- **Saving and Loading:**  
  - Use the Save option in the File menu to store your current setup.  
  - Load saved setups to avoid manual re-entry of parameters, allowing you to share project files with others.

- **Example Setups:**  
  Four example setups are provided in the File menu to help you get started quickly.

- **Export:**  
  Generate a PDF of your setup and results using the Export option in the File menu to document your work.

- **Help:**  
  Access this guide anytime via the Help menu.

---

By following these steps and utilizing the available features, you can efficiently conduct your structural analyses and load simulations. Enjoy the comprehensive functionalities that help you plan and document your projects with precision.
