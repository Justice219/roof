roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}
roof.server.settings = roof.server.settings or {}
roof.server.errors = roof.server.errors or {}

roof.server.errors.normal("ROOF WILL NOW START LOADING SETTINGS")
--[[
  ___ __  __ ___  ___  ___ _____ _   _  _ _____ 
 |_ _|  \/  | _ \/ _ \| _ \_   _/_\ | \| |_   _|
  | || |\/| |  _/ (_) |   / | |/ _ \| .` | | |  
 |___|_|  |_|_|  \___/|_|_\ |_/_/ \_\_|\_| |_|  

 ALL SETTING VARIABLES ARE ONLY OBTAINABLE THROUGH
 THE SERVERSIDE! DO NOT TRY TO ACCESS THEM ON THE CLIENT
 WITHOUT NETWORKING THE DATA TABLE!
                                                
 PLEASE DO NOT REMOVE PREMADE SETTINGS AS THEY
 ARE PROBABLY USED INTERNALLY!

 AN EXAMPLE ON GRABBING SETTINGS:
    local settings = roof.server.settings.find("roof_enabled")
    local value = settings.value
    local description = settings.description
    local var = settings.var

THEN YOU CAN USE THEM AT WILL!
]]--
function roof.server.settings.load()
    roof.server.settings.loadInternal()

    roof.server.settings.create("roof_enabled", {
        default = true,
        desc = "Enable/Disable the roof base",
        category = "main" -- main, player, debug, world
    })

    -- PLEASE ADD ANY NEW NON-INTERNAL SETTINGS UNDER THIS LINE!


end

roof.server.settings.load()