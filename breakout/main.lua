local ball
local bricks
local player
local score
local walls
local world

function love.load()
	local Player = require("player")
	local Ball = require("ball")
	local Brick = require("brick")
	local Score = require("score")
	world = love.physics.newWorld(0, 0)
	player = Player:new(world)
	ball = Ball:new(world)
	score = Score:new()
	bricks = {}
	walls = {}
	build_walls()
	for i = 1, 30 do
		table.insert(bricks, Brick:new(i, world))
	end
end

function love.draw()
	for i, v in ipairs(bricks) do
		v:draw()
	end
	ball:draw()
	player:draw()
	score:draw()
end

function love.update(dt)
	player:update(dt)
	ball:update(dt)
	world:update(dt)
	if ball.y > love.graphics.getHeight() then
		love.load()
	end
	for i, brick in ipairs(bricks) do
		if ball.body:isTouching(brick.body) then
			brick:destroy()
			table.remove(bricks, i)
			score.value = score.value + 1
		end
	end
	if #bricks == 0 and ball.y >= love.graphics.getHeight() / 2 then
		local Brick = require("brick")
		for i = 1, 30 do
			table.insert(bricks, Brick:new(i, world))
		end
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function build_walls()
	local Wall = require("wall")
	table.insert(walls, Wall:new(love.graphics.getWidth() / 2, 0, love.graphics.getWidth(), 10, world))
	table.insert(
		walls,
		Wall:new(love.graphics.getWidth(), love.graphics.getHeight() / 2, 10, love.graphics.getHeight(), world)
	)
	table.insert(walls, Wall:new(0, love.graphics.getHeight() / 2, 10, love.graphics.getHeight(), world))
end
