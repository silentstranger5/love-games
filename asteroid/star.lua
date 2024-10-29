local Object = require("object")
local Star = Object:new()

function Star:new()
	local obj = Object.new(self)
	obj.x = math.random(0, love.graphics.getWidth())
	obj.y = math.random(0, love.graphics.getHeight())
	obj.image = love.graphics.newImage("resources/star.png")
	obj.width = obj.image:getWidth()
	obj.height = obj.image:getHeight()
	return obj
end

function Star:draw()
	love.graphics.draw(self.image, self.x, self.y, 0, 0.5, 0.5, self.width / 2, self.height / 2)
end

return Star
