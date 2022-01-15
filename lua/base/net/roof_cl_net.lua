roof = roof or {}
roof.client = roof.client or {}

net.Receive("Roof:Net:LoadClientFiles", function(len, ply)
    tbl = net.ReadTable()
    PrintTable(tbl)
    for k,v in pairs(tbl) do
        include(v)
    end

    print("CLIENT FILES LOADEDDDDD")
end)