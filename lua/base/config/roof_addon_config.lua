roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}

-- DO NOT TOUCH THIS CODE PLEASE!!
MsgC(Color(255,0,0),"[ROOF]", Color(255,255,255)," Server Addon Process Starting! \n")

function roof.server.addons.load()

    -- PLEASE ADD ANY NEW ADDONS TO THE LIST BELOW
    roof.server.addons.create("addons/roofconfig/roofconfig_loader.lua",{
        name = "Roof Config",
        author = "Justice",
        description = "Allows for ingame configuration of the server!",
        version = "1.0",
    })
    roof.server.addons.create("addons/adminsystem/adminsystem_loader.lua",{
        name = "Admin System",
        author = "Justice",
        description = "A admin system for the server!",
        version = "1.0",
    })
    -- AADD NEW STUFF UNDER HERE! THE ADDONS ABOVE NEED TO BE LOADED FIRST!
    roof.server.addons.create("addons/chatfilter/chatfilter_loader.lua",{
        name = "Chat Filter",
        author = "Justice",
        description = "A chat filter for the server!",
        version = "1.0",
    })
    roof.server.addons.create("addons/chatcommands/chatcommands_loader.lua",{
        name = "Chat Commands",
        author = "Justice",
        description = "Adds chat commands to the server.",
        version = "1.0",
    })
end

roof.server.addons.load()