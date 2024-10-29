local Entity = require("entity")
local Player = Entity:new()

function Player:new(world)
	local x = love.graphics.getWidth() / 10
	local y = love.graphics.getHeight() / 2
	local width = 20
	local height = 100
	local obj = Entity.new(self, x, y, width, height)
	obj.body = love.physics.newBody(world, obj.x, obj.y, "kinematic")
	obj.shape = love.physics.newRectangleShape(obj.width, obj.height)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape)
	obj.fixture:setFriction(0)
	obj.fixture:setRestitution(1)
	obj.speed = 400
	return obj
end

function Player:update(dt)
	self.x, self.y = self.body:getPosition()
	if love.keyboard.isDown("up") and self.y - self.height / 2 > 0 then
		self.body:setLinearVelocity(0, -self.speed)
	elseif love.keyboard.isDown("down") and self.y + self.height / 2 < love.graphics.getHeight() then
		self.body:setLinearVelocity(0, self.speed)
	else
		self.body:setLinearVelocity(0, 0)
	end
end

function Player:draw()
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

return Player
