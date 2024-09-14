export type threadpoolImpl = {
	__index: threadpoolImpl,
	
	new: (pool_size: number, queue_size: number) -> threadpoolImpl,
	run: (func: (...any) -> any?, ...any) -> (),
	shutdown: (force: boolean) -> (),
	cancelTask: (func:(...any) -> any?) -> (),
	
	pool_size: number, -- unsigned integer.
	task_queue: {func: (...any) -> any?},
	queue_size: number, -- unsigned integer. prevents the queue from growing indefinitely.
	active_threads: number,
}

local thread_pool = {} :: threadpoolImpl
thread_pool.__index = thread_pool

function thread_pool.new(pool_size : number, queue_size : number)
	local self = setmetatable({}, thread_pool) :: threadpoolImpl
	if pool_size <= 0 then pool_size = 1 end
	self.pool_size = pool_size
	self.task_queue = {}
	self.queue_size = queue_size
	self.active_threads = 0
	return self
end

function thread_pool:run(func : (...any) -> any?, ...)
	if #self.task_queue >= self.queue_size then
		warn("threadflow's task queue is full. task cannot be added!")
		return
	end
	if self.active_threads < self.pool_size then
		self.active_threads += 1
		task.spawn(function(...)
			func(...)
			self.active_threads -= 1
			self:processQueue()
		end, ...)
		--[[print(`task {func} has been succesfully ran, freeing up the thread.`)]]
	else
		table.insert(self.task_queue, {func, {...}})
		--[[print(`all threads are in use, adding task {func} to the queue.`)]]
	end
end

--[[
If there isn't an active thread available, create one and run the task.
DOESN'T increment active_threads not to fiddle with other tasks trying to run.
]]
function thread_pool:forceRun(func : (...any) -> any?, ...)
	if self.active_threads == 0 then
		task.spawn(function(...)
			func(...)
		end, ...)
		return
	end
	self:run(func, ...)
end

--// TASK MANIPULATION

function thread_pool:cancelTask(func)
	for i, awaiting_task in self.task_queue do
		local awaiting_task_func = awaiting_task[1]
		if awaiting_task_func == func then
			table.remove(self.task_queue, i)
			return
		end
	end
end

--// QUEUE MANIPULATION

function thread_pool:processQueue()
	if #self.task_queue > 0 and self.active_threads < self.pool_size then
		local dequeued_task = table.remove(self.task_queue, 1)
		self:run(dequeued_task[1], table.unpack(dequeued_task[2]))
	end
end

function thread_pool:clearQueue()
	self.task_queue = {}
end

function thread_pool:shutdown(force : boolean)
	local active = #self.task_queue > 0 or self.active_threads > 0
	while active and not force do
		self:processQueue()
		active = #self.task_queue > 0 or self.active_threads > 0
	end
	self:destroy()
end


return thread_pool
