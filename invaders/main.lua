local background
local bullets
local enemies
local player
local score
local walls
local world

function love.load()
	local Enemy = require("enemy")
	local Player = require("player")
	local Score = require("score")
	background = love.graphics.newImage("resources/background.png")
	world = love.physics.newWorld(0, 0)
	player = Player:new(world)
	score = Score:new()
	bullets = {}
	enemies = {}
	for i = 1, 14 do
		table.insert(enemies, Enemy:new(i, world))
	end
	walls = {}
	build_walls()
end

function love.draw()
	love.graphics.draw(background)
	for i, bullet in ipairs(bullets) do
		bullet:draw()
	end
	for i, enemy in ipairs(enemies) do
		enemy:draw()
	end
	player:draw()
	score:draw()
end

function love.update(dt)
	for i, bullet in ipairs(bullets) do
		bullet:update(dt)
	end
	for i, enemy in ipairs(enemies) do
		enemy:update(dt)
	end
	for i, bullet in ipairs(bullets) do
		if bullet.y - bullet.height / 2 < 0 then
			bullet.fixture:destroy()
			table.remove(bullets, i)
		end
	end
	for i, enemy in ipairs(enemies) do
		for j, bullet in ipairs(bullets) do
			if enemy.body:isTouching(bullet.body) then
				bullet.fixture:destroy()
				enemy.fixture:destroy()
				table.remove(enemies, i)
				table.remove(bullets, j)
				score.value = score.value + 1
			end
		end
		for j, wall in ipairs(walls) do
			if enemy.body:isTouching(wall.body) then
				enemy.body:setPosition(enemy.x, enemy.y + 32)
			end
		end
		if enemy.body:isTouching(player.body) then
			love.load()
		end
	end
	player:update(dt)
	world:update(dt)
	if #enemies == 0 then
		local Enemy = require("enemy")
		for i = 1, 14 do
			table.insert(enemies, Enemy:new(i, world))
		end
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
	if key == "space" then
		local Bullet = require("bullet")
		table.insert(bullets, Bullet:new(player.x, player.y - player.width, world))
	end
end

function build_walls()
	local Wall = require("wall")
	table.insert(walls, Wall:new(love.graphics.getWidth() / 2, 0, love.graphics.getWidth(), 10, world))
	table.insert(
		walls,
		Wall:new(love.graphics.getWidth(), love.graphics.getHeight() / 2, 10, love.graphics.getHeight(), world)
	)
	table.insert(
		walls,
		Wall:new(love.graphics.getWidth() / 2, love.graphics.getHeight(), love.graphics.getWidth(), 10, world)
	)
	table.insert(walls, Wall:new(0, love.graphics.getHeight() / 2, 10, love.graphics.getHeight(), world))
end
