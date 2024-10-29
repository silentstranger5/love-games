local Object = require("object")
local Score = Object:new()

function Score:new()
	local obj = Object.new(self)
	obj.x = love.graphics.getWidth() * 9 / 10
	obj.y = love.graphics.getHeight() * 9 / 10
	obj.font = love.graphics.newFont(24)
	obj.value = 0
	return obj
end

function Score:draw()
	love.graphics.print(self.value, self.font, self.x, self.y)
end

return Score
