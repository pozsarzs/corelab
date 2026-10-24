# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## El Manco

**Playful Processor Test: "One-Armed Bandit" Simulator**  

This documentation describes a hardware test application disguised as a classic
slot machine (one-armed bandit) game. It is designed to verify the basic
input/output operations, timer interrupts, and state machine logic of a processor.

### 1. Required Hardware Environment

* **Processor:** Any 4-bit or 8-bit microprocessor/microcontroller.
* **Display:** A 4-digit hexadecimal display driven on a BCD basis.
* **Input:** An 8-button keypad.
* **Output:** An 8-LED row (1 byte output).

### 2. How to Play (User Guide)

Upon starting, all four digits on the display will continuously and slowly
roll through the numbers 0 to 9.

* **Buttons 1 to 4:** Each button corresponds to one of the four digits
  (from left to right). Pressing a button will stop the rolling of its assigned
  digit.
* **The Goal:** The player must try to stop all four digits on the exact same
  number.
* **Feedback:**
* While the game is running, the LEDs remain off.
* If all four digits are stopped and they match (e.g., `7 7 7 7`), the player
  wins. The LED row will flash brightly to indicate a win.
* If all four digits are stopped but they do not match (e.g., `7 7 4 7`),
  the player loses. The LED row will display an alternating error pattern.

* **Button 5:** Resets the game and starts a new roll.
* **Button 8:** Exits the program or puts the processor into a halt/standby
  state.

### 3. The Algorithm

**State Variables:**  

* `Digit[4]`: Array storing the current BCD value (0-9) of each digit.
* `Stop[4]`: Boolean array indicating whether a specific digit has been stopped
  by the user.
* `State`: The current machine state (`RUNNING`, `WIN`, `LOSE`).
* `Timer`: A counter used to control the rolling speed of the display.

**Main Execution Loop:**  

1. **Input Handling:**  
* Scan the 8-button keypad.
* If Button[0..3] is pressed: Set the corresponding `Stop[0..3]` flag to `True`.
* If Button[4] (Reset) is pressed: Set `State = RUNNING`, clear all `Stop` flags
  (`False`), and turn off all LEDs.
* If Button[7] (Exit) is pressed: Halt execution or return to the main system
  monitor.

2. **State Machine Update:**  
* **If `State == RUNNING`:**
* Increment the `Timer`.
* When `Timer` reaches the predefined speed threshold:
* Reset `Timer` to 0.
* For each digit `i` from 0 to 3: If `Stop[i] == False`, update the value:
  `Digit[i] = (Digit[i] + 1) MOD 10`.
* Push the `Digit` array to the 4-digit BCD display.

* *Win/Loss Check:* If `Stop[0] AND Stop[1] AND Stop[2] AND Stop[3]` are
  all `True`:
* If `Digit[0] == Digit[1] == Digit[2] == Digit[3]`, set `State = WIN`.
* Else, set `State = LOSE`.

* **If `State == WIN`:**
* The display remains frozen.
* Toggle the 8-LED row all ON and all OFF (e.g., alternating between `0xFF`
   and `0x00` based on the timer) to create a winning flash effect.

* **If `State == LOSE`:**
* The display remains frozen.
* Toggle the 8-LED row with an alternating error pattern (e.g., alternating
  between `0xAA` and `0x55` based on the timer).

3. **Loop back to Step 1.**  
