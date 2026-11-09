# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## El Manco

**Playful Processor Test: "One-Armed Bandit" Simulator**  

This documentation describes a hardware test application disguised as a classic
slot machine (one-armed bandit) game. It is designed to verify the basic
input/output operations, timer interrupts, and state machine logic of a processor.

### 1. Required Hardware Environment

* **Processor:** Any 8-bit (4-bit) microprocessor.
* **Memory:**  1kB standard memory (2-2 pcs. 4001 and 4002 virtual chips).
* **Display:** A 4-digit hexadecimal display driven on a BCD basis.
* **Input:** An 8-button keypad.
* **Output:** An 8-LED row (1 byte output).

### 2. How to Play (User Guide)

Upon starting, all four digits on the display will continuously and slowly
roll through the numbers 0 to F (0 to 15).

* **Button 0**: Resets the game and starts a new roll.

* **Buttons 1-4**: Each button corresponds to one of the four digits
  (from left to right). Pressing a button will stop the rolling of its assigned
  digit.

* **Button 7**: Exits the program and puts the processor into a halt/standby
  state.

** The Goal**: The player must try to stop all four digits on the exact same
number.

**Feedback:** While the game is running, the LED row displays an alternating
running pattern (flipping between 10101010 and 01010101).

If all four digits are stopped and they match (e.g., 7 7 7 7), the player
wins. The LED row will statically display a winning pattern (01111110).

If all four digits are stopped but they do not match (e.g., 7 7 4 7),
the player loses. The LED row will statically display an error pattern (10000001).
