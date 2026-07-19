



**Simulation control**

{ Simulation control commands:

  run
  csEveryWhere
  run [cpu_id] [until <cycles|time>] - Start execution, optionally up to a target limit.

step
everywhere
step [count] [cpu_id] - Execute a specific number of instructions (default: 1).

stop
everywhere
stop [cpu_id] - Halt execution (essential interactively or in async scripts).

