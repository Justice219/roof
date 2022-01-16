adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.net = adminsystem.server.net or {}
adminsystem.server.chat = adminsystem.server.chat or {}
adminsystem.server.player = adminsystem.server.player or {}
adminsystem.server.groups = adminsystem.server.groups or {}
local plyMeta = FindMetaTable("Player")

--[[
  ___                            _              _   
 |_ _|_ __ ___  _ __   ___  _ __| |_ __ _ _ __ | |_ 
  | || '_ ` _ \| '_ \ / _ \| '__| __/ _` | '_ \| __|
  | || | | | | | |_) | (_) | |  | || (_| | | | | |_ 
 |___|_| |_| |_| .__/ \___/|_|   \__\__,_|_| |_|\__|
               |_|                                  
DO NOT TRY TO CHANGE OR EDIT A PLAYERS GROUP
ON THE CLIENTSIDE!

PLEASE ACCESS DATA ONLY ON THE SERVERSIDE
]]--
roof.server.db.create("adminsystem_players", {
    [1] = {
        name = "group",
        type = "TEXT",
    },
    [2] = {
        name = "id",
        type = "TEXT",
    },
})

function adminsystem.server.player.changeGroup(ply, group)


end
function adminsystem.server.player.changeGroup(ply, group)
    

end