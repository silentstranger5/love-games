local Entity = require("entity")
local Brick = Entity:new()

function Brick:new(index, world)
	local width = 100
	local height = 30
	local gap = 20
	local row = (index - 1) % 6
	local column = math.floor((index - 1) / 6)
	local x = love.graphics.getWidth() / 10 + row * (width + gap)
	local y = love.graphics.getHeight() / 20 + column * (height + gap / 2)
	local obj = Entity.new(self, x, y, width, height)
	obj.row = row
	obj.column = column
	obj.color = { red = 0, green = 0, blue = 0 }
	if obj.column == 0 then
		obj.color.red = 255 / 255
	elseif obj.column == 1 then
		obj.color.red = 255 / 255
		obj.color.green = 165 / 255
	elseif obj.column == 2 then
		obj.color.red = 255 / 255
		obj.color.green = 255 / 255
	elseif obj.column == 3 then
		obj.color.green = 255 / 255
	elseif obj.column == 4 then
		obj.color.green = 255 / 255
		obj.color.blue = 255 / 255
	end
	obj.body = love.physics.newBody(world, obj.x, obj.y, "static")
	obj.shape = love.physics.newRectangleShape(obj.width, obj.height)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape)
	obj.fixture:setFriction(0)
	obj.fixture:setRestitution(1)
	return obj
end

function Brick:draw()
	love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
	love.graphics.setColor(1, 1, 1)
end

function Brick:destroy()
	self.fixture:destroy()
	self.body:destroy()
	self.shape:release()
end

return Brick
