local Entity = require("entity")
local Bullet = Entity:new()

function Bullet:new(x, y, world, angle)
	local obj = Entity.new(self, x, y, world, "resources/laser.png")
	obj.angle = angle
	obj.speed = 200
	obj.velocity = { x = 0, y = 0 }
	obj.velocity.x = obj.speed * math.cos(obj.angle - math.pi / 2) * 2
	obj.velocity.y = obj.speed * math.sin(obj.angle - math.pi / 2) * 2
	obj.body:applyLinearImpulse(obj.velocity.x, obj.velocity.y)
	obj.body:setAngle(obj.angle)
	obj.body:setBullet(true)
	return obj
end

return Bullet
