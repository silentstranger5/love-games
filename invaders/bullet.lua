local Entity = require("entity")
local Bullet = Entity:new()

function Bullet:new(x, y, world)
	local obj = Entity.new(self, x, y, world, "resources/bullet.png")
	obj.speed = 600
	obj.body:setBullet(true)
	obj.body:setLinearVelocity(0, -obj.speed)
	return obj
end

return Bullet
