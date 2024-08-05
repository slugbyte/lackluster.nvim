local M = {}

---@param hexcode string
---@return boolean
M.hexcode = function(hexcode)
    if type(hexcode) == "string" and string.match(hexcode, "^#%x%x%x%x%x%x$") then
        return true
    end
    return false
end

---return true if is a valid 'none' or a valid hexcode
---@param color string
---@return boolean
M.hexcode_or_none = function(color)
    if color == "none" then
        return true
    end
    return M.hexcode(color)
end

return M
