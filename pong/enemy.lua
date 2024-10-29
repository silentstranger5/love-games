local Entity = require("entity")
local Enemy = Entity:new()

function Enemy:new(world)
	local x = love.graphics.getWidth() * 9 / 10
	local y = love.graphics.getHeight() / 2
	local width = 20
	local height = 100
	local obj = Entity.new(self, x, y, width, height)
	obj.body = love.physics.newBody(world, obj.x, obj.y, "kinematic")
	obj.shape = love.physics.newRectangleShape(obj.width, obj.height)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape)
	obj.fixture:setFriction(0)
	obj.fixture:setRestitution(1)
	obj.speed = 200
	return obj
end

function Enemy:draw()
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

function Enemy:update(dt, ball)
	self.body:setPosition(self.x, ball.y)
end

return Enemy
