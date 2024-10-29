local Entity = require("entity")
local Ball = Entity:new()

function Ball:new(world)
	local x = love.graphics.getWidth() / 2
	local y = love.graphics.getHeight() / 2
	local radius = 10
	local obj = Entity.new(self, x, y, radius, radius)
	obj.speed = 400
	obj.body = love.physics.newBody(world, obj.x, obj.y, "dynamic")
	obj.shape = love.physics.newCircleShape(obj.width)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape)
	obj.radius = radius
	obj.angle = math.pi / 4
	obj.body:setFixedRotation(true)
	obj.body:setLinearVelocity(math.cos(obj.angle) * obj.speed, math.sin(obj.angle) * obj.speed)
	obj.fixture:setCategory(2)
	obj.fixture:setFriction(0)
	obj.fixture:setRestitution(1)
	return obj
end

function Ball:update(dt)
	self.x, self.y = self.body:getPosition()
	self.angle = self.body:getAngle()
end

function Ball:draw()
	love.graphics.circle("fill", self.x, self.y, self.radius)
end

return Ball
