# 🛠️ ThreadFlow

**ThreadFlow** is a powerful thread management tool designed specifically for Roblox developers. It helps you efficiently handle concurrent tasks by managing a pool of threads and a task queue, ensuring optimal performance for your game.

## 🌟 Features

- **Customizable Pool Size**: Define the maximum number of active threads. 🔢
- **Task Queue Management**: Automatically queues tasks when the pool is full and processes them as threads become available. 📋
- **Configurable Queue Size**: Limits the size of the task queue to prevent overflow. 🚫
- **Task Cancellation**: Remove specific tasks from the queue. ❌
- **Graceful Shutdown**: Complete all queued tasks or force stop immediately. 🔄
- **Force Run**: Run tasks immediately if no threads are available. ⚡

## 🎯 Purpose

ThreadFlow exists to simplify the management of concurrent tasks in Roblox games. It provides a structured way to handle multiple tasks simultaneously without overwhelming the system, ensuring that your game runs smoothly even when dealing with numerous background operations.

## 🛠️ Why This Tool Exists

In Roblox game development, handling multiple tasks concurrently is crucial for maintaining performance and responsiveness. Tasks such as updating player data, processing in-game events, and handling UI updates can often become bottlenecks if not managed properly. ThreadFlow was created to address these challenges by offering an efficient way to manage a pool of threads and a task queue, allowing developers to offload tasks and keep their games running efficiently.

## 🚀 Installation

To use **ThreadFlow**, simply include it in your project by placing the script in a location accessible by your game scripts.

## 📚 API Documentation

### `ThreadFlow.new(pool_size: number, queue_size: number) -> ThreadFlow`

Creates a new thread pool instance.

- `pool_size`: The maximum number of active threads. 🌐
- `queue_size`: The maximum number of tasks in the queue. 📈

### `ThreadFlow:run(func: (...any) -> any?, ...any)`

Runs a task function with provided arguments.

- `func`: The task function to execute. 🛠️
- `...any`: Arguments to pass to the task function. 🎯

### `ThreadFlow:forceRun(func: (...any) -> any?, ...any)`

Forces the execution of a task even if no threads are available.

- `func`: The task function to execute. ⚡
- `...any`: Arguments to pass to the task function. 🎯

### `ThreadFlow:cancelTask(func: (...any) -> any?)`

Cancels a specific task from the queue.

- `func`: The task function to cancel. 🚫

### `ThreadFlow:shutdown(force: boolean)`

Shuts down the thread pool, optionally forcing immediate shutdown.

- `force`: If `true`, force shutdown without waiting for tasks to complete. ⏳
