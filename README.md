# ThreadFlow

**ThreadFlow** is a robust thread management utility tailored for Roblox developers. It optimizes concurrent task handling by managing a pool of threads and a task queue, ensuring smooth game performance.

## Purpose

ThreadFlow simplifies the management of concurrent tasks in Roblox games. It enables structured handling of multiple tasks simultaneously without overloading the system, ensuring smooth gameplay and efficient background operations.

## Why This Tool Exists

Efficiently managing concurrent tasks is crucial in Roblox game development to maintain performance and responsiveness. Tasks like player data updates, in-game event handling, and UI processing can become bottlenecks without proper management. ThreadFlow addresses these challenges by providing an effective thread pool and task queue system to offload and manage tasks efficiently.

## Installation

Include the **ThreadFlow** script in your project by placing it in a location accessible to your game scripts.

## API Documentation

### `ThreadFlow.new(pool_size: number, queue_size: number) -> ThreadFlow`

Creates a new thread pool instance.

- **pool_size**: The maximum number of active threads.
- **queue_size**: The maximum number of tasks allowed in the queue.

### `ThreadFlow:run(func: (...any) -> any?, ...any)`

Executes a task function with the provided arguments.

- **func**: The task function to execute.
- **...any**: Arguments to pass to the task function.

### `ThreadFlow:forceRun(func: (...any) -> any?, ...any)`

Forces the execution of a task even when no threads are available.

- **func**: The task function to execute.
- **...any**: Arguments to pass to the task function.

### `ThreadFlow:cancelTask(func: (...any) -> any?)`

Cancels a specific task from the queue.

- **func**: The task function to cancel.

### `ThreadFlow:shutdown(force: boolean)`

Shuts down the thread pool, optionally forcing an immediate shutdown.

- **force**: If `true`, forces shutdown without waiting for tasks to complete.

## Example Usage

```lua
local ThreadFlow = require(path.to.ThreadFlow)

local pool = ThreadFlow.new(5, 10)

pool:run(function(arg1, arg2)
    print("Task running with arguments:", arg1, arg2)
end, "argument1", "argument2")

pool:shutdown(false)
```

This example demonstrates creating a thread pool, running a task, and shutting down the pool.

