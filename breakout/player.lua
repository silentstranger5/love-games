local Entity = require("entity")
local Player = Entity:new()

function Player:new(world)
	local x = love.graphics.getWidth() / 2
	local y = love.graphics.getHeight() * 5 / 6
	local width = 100
	local height = 20
	local obj = Entity.new(self, x, y, width, height)
	obj.speed = 400
	obj.body = love.physics.newBody(world, obj.x, obj.y, "kinematic")
	obj.shape = love.physics.newRectangleShape(obj.width, obj.height)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape)
	obj.fixture:setFriction(0)
	obj.fixture:setRestitution(1)
	return obj
end

function Player:update(dt)
	self.x, self.y = self.body:getPosition()
	if love.keyboard.isDown("left") and self.x - self.width / 2 > 0 then
		self.body:setLinearVelocity(-self.speed, 0)
	elseif love.keyboard.isDown("right") and self.x + self.width / 2 < love.graphics.getWidth() then
		self.body:setLinearVelocity(self.speed, 0)
	else
		self.body:setLinearVelocity(0, 0)
	end
end

function Player:draw()
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

return Player
