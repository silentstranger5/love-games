local Object = require("object")
local Entity = Object:new()

function Entity:new(x, y, world, image_path, scale)
	local obj = Object.new(self)
	obj.x = x
	obj.y = y
	obj.angle = 0
	obj.scale = scale or 1
	if image_path then
		obj.image = love.graphics.newImage(image_path)
		obj.width = obj.image:getWidth() * obj.scale
		obj.height = obj.image:getHeight() * obj.scale
		obj.body = love.physics.newBody(world, obj.x, obj.y, "dynamic")
		obj.shape = love.physics.newRectangleShape(obj.width, obj.height)
		obj.fixture = love.physics.newFixture(obj.body, obj.shape)
	end
	return obj
end

function Entity:draw()
	love.graphics.draw(
		self.image,
		self.x,
		self.y,
		self.angle,
		self.scale,
		self.scale,
		self.width / (2 * self.scale),
		self.height / (2 * self.scale)
	)
end

function Entity:update(dt)
	self.x, self.y = self.body:getPosition()
	self.angle = self.body:getAngle()
end

function Entity:destroy()
	self.fixture:destroy()
	self.body:destroy()
	self.shape:release()
end

return Entity
