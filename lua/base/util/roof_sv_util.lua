roof = roof or {}
roof.server = roof.server or {}
roof.server.util = roof.server.util or {}


function roof.server.util.CreateTimerID()
    local id = 1
    while timer.Exists( "jevent"..id ) do
      id = id + 1
    end
  return id
end
function roof.server.util.RepeatedFunction(interval, repeats, func)
    local id = jevent.util.CreateTimerID()
    timer.Create("jevent"..tostring(id), interval, repeats, function()
        func(id)
    end)

    return id
end