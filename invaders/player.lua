local Entity = require("entity")
local Player = Entity:new()

function Player:new(world)
	local x = love.graphics.getWidth() / 2
	local y = love.graphics.getHeight() * 9 / 10
	local obj = Entity.new(self, x, y, world, "resources/player.png")
	obj.speed = 400
	return obj
end

function Player:update(dt)
	Entity.update(self, dt)
	if love.keyboard.isDown("left") and self.x - self.width / 2 > 0 then
		self.body:setLinearVelocity(-self.speed, 0)
	elseif love.keyboard.isDown("right") and self.x + self.width / 2 < love.graphics.getWidth() then
		self.body:setLinearVelocity(self.speed, 0)
	else
		self.body:setLinearVelocity(0, 0)
	end
end

return Player
