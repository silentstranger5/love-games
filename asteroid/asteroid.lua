local Entity = require("entity")
local Asteroid = Entity:new()

function Asteroid:new(args)
	local x = args.x or math.random(0, love.graphics.getWidth())
	local y = args.y or math.random(-love.graphics.getHeight(), 0)
	local scale = 1 / (4 - (args.stage or 3))
	local obj = Entity.new(self, x, y, args.world, "resources/asteroid.png", scale)
	obj.angle = math.random(0, 2 * math.pi)
	obj.speed = 50
	obj.stage = args.stage or 3
	obj.velocity = { x = 0, y = 0 }
	obj.velocity.x = obj.speed * math.cos(obj.angle) * 2
	obj.velocity.y = obj.speed * math.sin(obj.angle) * 2
	obj.body:setLinearVelocity(obj.velocity.x, obj.velocity.y)
	return obj
end

return Asteroid
