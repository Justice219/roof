roof = roof or {}
roof.server = roof.server or {}
roof.server.db = roof.server.db or {}
roof.server.errors = roof.server.errors or {}

function roof.server.db.query(query)
    roof.server.errors.debug("Query: " .. query)
    sql.Query(query)
end

function roof.server.db.create(name, values)
    local str = ""
    local i = 0
    local max = table.maxn(values)
    for k,v in pairs(values) do
        -- the string needs to look something like id NUMBER, name TEXT
        i = i + 1
        if i == max then 
            str = str .. v.name .. " " .. v.type
        else
            str = str .. v.name .. " " .. v.type .. ", "
        end
    end

    sql.Query("CREATE TABLE IF NOT EXISTS " .. name .. " ( " .. str .. " )")
    roof.server.errors.change("Created new DB table: " .. name)
    if !sql.LastError() then return end
    roof.server.errors.change("Printing last SQL Error for debugging purposes, ")
    print(sql.LastError())
end

function roof.server.db.remove(name)
    sql.Query("DROP TABLE " .. name)

    roof.server.errors.change("Removed DB table: " .. name)
    if !sql.LastError() then return end
    roof.server.errors.change("Printing last SQL Error for debugging purposes, ")
end

function roof.server.db.updateSpecific(name, method, value)
    local data = sql.Query("SELECT * FROM " .. name .. " WHERE " .. method .. " = " ..sql.SQLStr(method).. ";")
    if (data) then
        sql.Query("UPDATE " .. name .. " SET " .. value .. " WHERE " .. method .. " = " ..sql.SQLStr(method).. ";")
    else
        sql.Query("INSERT INTO " .. name .. " ( "..method..","..value.." ) VALUES( "..sql.SQLStr(method)..", "..sql.SQLStr(value).." );")
    end
end

function roof.server.db.updateAll(name, row, value)
    roof.server.errors.change("Updating all entries in DB table: " .. name)
    value = sql.SQLStr(value)
    local data = sql.Query("SELECT * FROM " .. name .. ";")
    if (data) then
        sql.Query("UPDATE " .. name .. " SET " .. row .. " = " .. value .. ";")
    else
        sql.Query("INSERT INTO " .. name .. " ( "..row.." ) VALUES( "..value.." )") 
    end
end

function roof.server.db.load(name, method)
    local val = sql.QueryValue("SELECT * FROM " .. name .. " WHERE " .. method .. " = " .. sql.SQLStr(method) .. ";")
    if !val then
        roof.server.errors.severe("Could not load data from DB table: " .. name .. " with method: " .. method)    
        return false
    else
        return val
    end
end

function roof.server.db.loadAll(name, row)
    local val = sql.QueryValue("SELECT "..row.." FROM " .. name .. ";")
    if !val then
        roof.server.errors.severe("Could not load data from DB table: " .. name)    
        return false
    else
        return val
    end
end

concommand.Add("roof_test_db", function(ply, cmd, args)
    roof.server.db.create("test", {
        [1] = {
            name = "id",
            type = "INTEGER"
        },
    })
end)
concommand.Add("roof_remove_db", function(ply, cmd, args)
    roof.server.db.remove(args[1])
end)