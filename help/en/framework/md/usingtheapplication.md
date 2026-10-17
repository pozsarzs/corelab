# CoreLAB - Help

## 4. Using the Application

Although CoreLAB features a clean and intuitive graphical interface, understanding the basic workflow is essential for building and running your first simulated environment. 

### 4.1 Building a Simulation Workspace

CoreLAB relies on a modular architecture. To simulate a computer system, you must instantiate the necessary components and connect them to the system bus.

1. **Create a Processor:** Go to **Processor > Create...**, select a CPU plugin (e.g., `cpu_8080`), give the instance a unique name, and click OK.
2. **Create Memory:** Go to **Memory > Create...**, select a memory plugin (e.g., `memory_standard`), name it, and set its size and base address using the **Properties...** command.
3. **Create I/O Devices:** If your simulation requires input/output, go to **I/O port > Create...**, select the desired peripheral (e.g., switches, LEDs, or displays), and name it.
4. **Attach to Bus:** Modules will not communicate until they are attached to the system bus. Use the **Attach to bus...** command individually for your CPU, memory, and I/O modules.

### 4.2 Loading Code and Data

Before starting the processor, you need to load an executable program into the memory.
1. Ensure your memory module is attached to the bus.
2. Go to **Memory > Load memory content...**.
3. Select your compiled binary (`.bin`) or Intel HEX (`.hex`) file. 
4. Specify the starting address if loading a binary file (HEX files contain their own address mapping, so they will load into the correct locations automatically).

### 4.3 Running the Simulation

Once the virtual hardware is built and the code is loaded in memory:
1. Navigate to the **Operation** tab on the main toolbar.
2. Adjust the **Run Delay** dropdown (e.g., 1000 ms) to control how fast the simulation executes. This is highly recommended for visual debugging.
3. Click **Run** to start continuous execution, or use **Step** to execute instructions one by one.
4. Use visual tools like **RunLogger**, **RegViewer**, or **BusLogger** from the **View** menu to monitor the execution logic, registers, and bus traffic in real-time.

### 4.4 Using Projects

Building a complex hardware setup manually every time can be tedious. 
- Once you have configured your CPU, memory, and I/O ports, use **File > Save project** to save your environment as a `.clprj` file.
- Next time, simply use **File > Load project...** to instantly restore your entire hardware topology and module properties.

### 4.5 Working with Scripts

For automated testing and environment building, you can switch from Interactive Mode to Script Mode.
1. Go to **File > Switch to script mode**.
2. Open the built-in editor via **View > Show ScriptEditor...**.
3. Write or load your `.clsce` (Scriptembly) commands to automatically instantiate modules, load memory, modify registers, and assert conditions.
4. Click **Run script** on the Script toolbar and monitor the text output in the **ScriptConsole**.