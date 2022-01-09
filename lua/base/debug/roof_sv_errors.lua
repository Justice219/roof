roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}
roof.server.errors = roof.server.errors or {}

function roof.server.errors.severe(message)
    MsgC(Color(255, 0, 0), "[ROOF SERVERE] ", Color(255, 255, 255), message, "\n")
end
function roof.server.errors.normal(message)
    MsgC(Color(255, 0, 0), "[ROOF] ", Color(255, 255, 255), message, "\n")
end
function roof.server.errors.debug(message)
    MsgC(Color(255, 0, 0), "[ROOF DEBUG] ", Color(255, 255, 255), message, "\n")
end
function roof.server.errors.change(message)
    MsgC(Color(255, 0, 0), "[ROOF CHANGE] ", Color(255, 255, 255), message, "\n")
end