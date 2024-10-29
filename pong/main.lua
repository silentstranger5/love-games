local ball
local enemy
local player
local score
local walls
local world

function love.load()
	local Ball = require("ball")
	local Enemy = require("enemy")
	local Player = require("player")
	local Score = require("score")
	world = love.physics.newWorld(0, 0)
	ball = Ball:new(world)
	enemy = Enemy:new(world)
	player = Player:new(world)
	score = Score:new()
	walls = {}
	build_walls()
end

function love.draw()
	ball:draw()
	enemy:draw()
	player:draw()
	score:draw()
end

function love.update(dt)
	if out_of_bounds(ball) then
		love.load()
	end
	ball:update(dt)
	enemy:update(dt, ball)
	player:update(dt)
	world:update(dt)
	if player.body:isTouching(ball.body) then
		score.value = score.value + 1
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
		Wall:new(love.graphics.getWidth() / 2, love.graphics.getHeight(), love.graphics.getWidth(), 10, world)
	)
end

function out_of_bounds(obj)
	return obj.x + obj.width / 2 < 0 or obj.x - obj.width / 2 > love.graphics.getWidth()
end
