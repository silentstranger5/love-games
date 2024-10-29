local Entity = require("entity")
local Player = Entity:new()

function Player:new(world)
	local x = love.graphics.getWidth() / 2
	local y = love.graphics.getHeight() / 2
	local obj = Entity.new(self, x, y, world, "resources/player.png")
	obj.speed = 200
	obj.fixture:setCategory(2)
	return obj
end

function Player:update(dt)
	Entity.update(self, dt)

	self.velocity = { x = 0, y = 0 }

	if love.keyboard.isDown("up") then
		self.velocity.y = self.velocity.y - 1
	end
	if love.keyboard.isDown("down") then
		self.velocity.y = self.velocity.y + 1
	end
	if love.keyboard.isDown("left") then
		self.velocity.x = self.velocity.x - 1
	end
	if love.keyboard.isDown("right") then
		self.velocity.x = self.velocity.x + 1
	end

	self.body:setLinearVelocity(self.velocity.x * self.speed, self.velocity.y * self.speed)
end

return Player
