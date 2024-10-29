local Object = require("object")
local Entity = Object:new()

function Entity:new(x, y, width, height)
	local obj = Object.new(self)
	obj.x = x
	obj.y = y
	obj.width = width
	obj.height = height
	return obj
end

return Entity
