local Entity = require("entity")
local Player = Entity:new()

function Player:new(world)
	local x = love.graphics.getWidth() / 2
	local y = love.graphics.getHeight() / 2
	local obj = Entity.new(self, x, y, world, "resources/player.png")
	obj.speed = 200
	return obj
end

function Player:update(dt)
	Entity.update(self, dt)

	if love.keyboard.isDown("up") then
		self.body:setLinearVelocity(self.velocity.x, self.velocity.y)
	elseif love.keyboard.isDown("down") then
		self.body:setLinearVelocity(-self.velocity.x, -self.velocity.y)
	else
		self.body:setLinearVelocity(0, 0)
	end

	if love.keyboard.isDown("left") then
		self.body:setAngularVelocity(-self.speed / 50)
	elseif love.keyboard.isDown("right") then
		self.body:setAngularVelocity(self.speed / 50)
	else
		self.body:setAngularVelocity(0)
	end
end

return Player
