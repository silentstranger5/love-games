local Entity = require("entity")
local Asteroid = Entity:new()

function Asteroid:new(world)
	local x = math.random(0, love.graphics.getWidth())
	local y = math.random(-love.graphics.getHeight(), 0)
	local obj = Entity.new(self, x, y, world, "resources/asteroid.png", 0.5)
	obj.angle = math.random(math.pi / 4, math.pi * 3 / 4)
	obj.speed = 200
	obj.velocity = {}
	obj.velocity.x = obj.speed * math.cos(obj.angle) * 2
	obj.velocity.y = obj.speed * math.sin(obj.angle) * 2
	obj.body:applyLinearImpulse(obj.velocity.x, obj.velocity.y)
	return obj
end

return Asteroid
