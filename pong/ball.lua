local Entity = require("entity")
local Ball = Entity:new()

function Ball:new(world)
	local x = love.graphics.getWidth() / 2
	local y = love.graphics.getHeight() / 2
	local width = 20
	local height = 20
	local obj = Entity.new(self, x, y, width, height)
	obj.radius = radius
	obj.body = love.physics.newBody(world, obj.x, obj.y, "dynamic")
	obj.shape = love.physics.newRectangleShape(obj.width, obj.height)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape)
	obj.angle = math.pi / 4
	obj.speed = 400
	obj.body:setFixedRotation(true)
	obj.body:setLinearVelocity(math.cos(obj.angle) * obj.speed, math.sin(obj.angle) * obj.speed)
	obj.fixture:setCategory(2)
	return obj
end

function Ball:update(dt)
	self.x, self.y = self.body:getPosition()
	self.angle = self.body:getAngle()
end

function Ball:draw()
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

return Ball
