roofconfig = roofconfig or {}
roofconfig.client = roofconfig.client or {}
roofconfig.client.menus = roofconfig.client.menus or {}
roofconfig.client.menus.main = roofconfig.client.menus.main or {}
roofconfig.client.net = roofconfig.client.net or {}

net.Receive("RoofConfig:Net:Menus:Main", function(len, ply)
    roofconfig.client.menus.main.open()
end)