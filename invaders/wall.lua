local Object = require("object")
local Wall = Object:new()

function Wall:new(x, y, width, height, world)
	local obj = Object.new(self)
	obj.x = x
	obj.y = y
	obj.width = width
	obj.height = height
	obj.body = love.physics.newBody(world, x, y, "static")
	obj.shape = love.physics.newRectangleShape(width, height)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape)
	obj.fixture:setCategory(1)
	obj.fixture:setMask(1)
	obj.fixture:setRestitution(1)
	return obj
end

return Wall
