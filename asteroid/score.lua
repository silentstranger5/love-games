local Object = require("object")
local Score = Object:new()

function Score:new()
	local obj = Object.new(self)
	obj.font = love.graphics.newFont(24)
	obj.value = 0
	return obj
end

function Score:draw()
	love.graphics.print(self.value, self.font, 20, 20)
end

return Score
