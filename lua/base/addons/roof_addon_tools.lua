roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}
roof.server.data = roof.server.data or {}
roof.server.data.addons = roof.server.data.addons or {}


MsgC(Color(255,0,0), "[ROOF]", Color(255,255,255), " Addon System Started\n")

function roof.server.addons.create(string,tbl)
    if roof.server.data.addons[tbl.name] then return end
    MsgC(Color(255,0,0), "[ROOF]", Color(255,255,255), " Creating addon: ", Color(255,0,0), tbl.name, Color(255,255,255), "\n")

    load,disable = include(string)    
    if load then
        load()
    end

    -- Add addon to table
    tbl.disable = disable
    tbl.enable = load
    tbl.enabled = true
    roof.server.data.addons[tbl.name] = tbl
end

function roof.server.addons.remove(name)
    roof.server.addons[name].disable()
    roof.server.addons[name] = nil

end

function roof.server.addons.clear()
    roof.server.data.addons = {}
end