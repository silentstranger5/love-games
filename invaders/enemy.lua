local Entity = require("entity")
local Enemy = Entity:new()

function Enemy:new(index, world)
	local x = love.graphics.getWidth() / 10 + 64 * 1.5 * (1 + ((index - 1) % 7))
	local y = love.graphics.getHeight() / 10 + 64 * 1.5 * math.floor((index - 1) / 7)
	local obj = Entity.new(self, x, y, world, "resources/enemy.png")
	obj.speed = 200
	obj.body:setFixedRotation(true)
	obj.body:setLinearVelocity(obj.speed, 0)
	obj.fixture:setCategory(2)
	obj.fixture:setMask(2)
	return obj
end

return Enemy
