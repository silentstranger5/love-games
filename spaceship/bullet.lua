local Entity = require("entity")
local Bullet = Entity:new()

function Bullet:new(x, y, world, angle)
	local obj = Entity.new(self, x, y, world, "resources/laser.png")
	obj.body:setLinearVelocity(0, -600)
	obj.body:setBullet(true)
	return obj
end

return Bullet
