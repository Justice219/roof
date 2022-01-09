roofconfig = roofconfig or {}
roofconfig.client = roofconfig.client or {}
roofconfig.client.menus = roofconfig.client.menus or {}
roofconfig.client.menus.main = roofconfig.client.menus.main or {}

function roofconfig.client.menus.main.open()
    local tabs = {}
    local data = {}

    local panel = vgui.Create("DPanel")
    panel:TDLib()
    panel:SetSize(1920, 1080)
    panel:Center()
    panel:MakePopup()
    panel:ClearPaint()
        :Background(Color(40, 41, 40), 0)
        :Text("Roof Config Panel", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 850, -510)
        :Text("v1.0", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 25,500)
        :CircleHover(Color(59, 59, 59), 5, 20)

    local panel2 = panel:Add("DPanel")
    panel2:TDLib()
    panel2:SetPos(0, 60)
    panel2:SetSize(1920, 5)
    panel2:ClearPaint()
        :Background(Color(255, 255, 255), 0)

    local panel3 = panel:Add("DPanel")
    panel3:TDLib()
    panel3:SetPos(435, 60)
    panel3:SetSize(5, 1000)
    panel3:ClearPaint()
        :Background(Color(255, 255, 255), 0)


    local close = panel:Add("DImageButton")
    close:SetPos(1880, 20)
    close:SetSize(20,20)
    close:SetImage("icon16/cross.png")
    close.DoClick = function()
        panel:Remove()
    end

    --local welcome = panel:Add("RichText")
    --welcome:SetPos(20, 20)
    --welcome:SetSize(200,200)
    --welcome:InsertColorChange(255,255,255,255)
    --welcome:AppendText("Welcome to the RoofConfig Menu!\n\n")

    local scroll = panel:Add("DScrollPanel")
    scroll:SetPos(20, 75)
    scroll:SetSize(400, 1000)
    scroll:TDLib()
    scroll:ClearPaint()
        :CircleHover(Color(59, 59, 59), 5, 20)

    surface.CreateFont("RoofConfigMenuButton", {
        font = "Roboto",
        size = 30,
        weight = 500,
        antialias = true,
        shadow = false
    })

    local function ChangeTab(name)
        print("Changing Tab")
        for k,v in pairs(data) do
            table.RemoveByValue(data, v)
            v:Remove()
            print("Removed")
        end

        local tbl = tabs[name]
        tbl.change()
    end
    
    local function CreateTab(name, tbl)
        local scroll = scroll:Add( "DButton" )
        scroll:SetText( name)
        scroll:Dock( TOP )
        scroll:SetTall( 75 )
        scroll:DockMargin( 0, 0, 0, 5 )
        scroll:SetTextColor(Color(255,255,255))
        scroll:TDLib()
        scroll:SetFont("RoofConfigMenuButton")
        scroll:SetIcon(tbl.icon)
        scroll:ClearPaint()
            :Background(Color(59, 59, 59), 5)
            :BarHover(Color(255, 255, 255), 3)
            :CircleClick()
        scroll.DoClick = function()
            ChangeTab(name)
        end

        if tabs[name] then return end
        tabs[name] = tbl
    end

    CreateTab("Main", {
        icon = "icon16/application_view_tile.png",
        change = function()
            local d = {}
            main = panel:Add("DPanel")
            main:SetPos(452.5, 75)
            main:SetSize(1455, 985)
            main:TDLib()
            main:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("Main Settings", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, main)

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("Player", {
        icon = "icon16/user.png",
        change = function()
            local d = {}
            play = panel:Add("DPanel")
            play:SetPos(452.5, 75)
            play:SetSize(1455, 985)
            play:TDLib()
            play:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("Player Settings", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, play)

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("World", {
        icon = "icon16/world.png",
        change = function()
            local d = {}
            world = panel:Add("DPanel")
            world:SetPos(452.5, 75)
            world:SetSize(1455, 985)
            world:TDLib()
            world:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("World Settings", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, world)

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("Debug", {
        icon = "icon16/bug.png",
        change = function()
            local d = {}
            debu = panel:Add("DPanel")
            debu:SetPos(452.5, 75)
            debu:SetSize(1455, 985)
            debu:TDLib()
            debu:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("Debug Settings", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, debu)

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("Stats", {
        icon = "icon16/chart_bar.png",
        change = function()
            local d = {}
            stats = panel:Add("DPanel")
            stats:SetPos(452.5, 75)
            stats:SetSize(1455, 985)
            stats:TDLib()
            stats:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("Server Statistics", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, stats)

            scroll = stats:Add("DScrollPanel")
            scroll:SetPos(20, 75)
            scroll:SetSize(350,850)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 0)
            for k,v in pairs(player.GetAll()) do
                local av = scroll:Add("DPanel")
                av:SetTall(100)
                av:Dock(TOP)
                av:DockMargin(0,0,5,5)
                av:TDLib()
                av:ClearPaint()
                    :CircleAvatar()
                    :SetPlayer(v, 184)
                    --:Text("n", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 5,5)
                print(v:Nick())
            end

            

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
end