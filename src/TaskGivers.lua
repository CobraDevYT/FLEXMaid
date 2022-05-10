local TaskGivers = {}

function TaskGivers:GiveTask(Object, DeletionFunction, Lifetime)
	local Tasks = self._tasks
  local TableToInsert = {
    _obj = Object,
    _de = DeletionFunction or nil,
    _flexInfo = {_connections = {}, _thread = nil}
  }
  
  if Lifetime then
      TableToInsert.life = {_secondsToLive = Lifetime, _startTime = math.round(tick())}
  end
  
	table.insert(Tasks, TableToInsert)
	return #self._tasks+1
end

function TaskGivers:GiveTaskOn(Event, Object, DeletionFunction, Lifetime)

	local connection = Event:Connect(function()
		self:GiveTask(Object, DeletionFunction,Lifetime)
	end)

	table.insert(self._flexInfo._connections)
end

function TaskGivers:GiveTaskDelay(SecondsToWait, Object, DeletionFunction, Lifetime)
	
	task.delay(SecondsToWait, function()
		self:GiveTask(Object, DeletionFunction,Lifetime)
	end)
end

return TaskGivers
