roofconfig = roofconfig or {}
roofconfig.client = roofconfig.client or {}
roofconfig.client.menus = roofconfig.client.menus or {}
roofconfig.client.menus.main = roofconfig.client.menus.main or {}
roofconfig.client.net = roofconfig.client.net or {}
roofconfig.client.data = roofconfig.client.data or {}

net.Receive("RoofConfig:Net:Menus:Main", function(len, ply)
    roofconfig.client.menus.main.open()
end)
net.Receive("RoofConfig:Net:SyncClient", function(len, ply)
    local addonData = net.ReadTable()
    local settingData = net.ReadTable()
    roofconfig.client.data.addons = addonData
    roofconfig.client.data.settings = settingData
end)