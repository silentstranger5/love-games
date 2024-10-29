local asteroids
local bullets
local player
local score
local stars
local walls
local world

function love.load()
	local Asteroid = require("asteroid")
	local Player = require("player")
	local Score = require("score")
	local Star = require("star")

	world = love.physics.newWorld(0, 0)
	player = Player:new(world)
	score = Score:new()
	asteroids = {}
	bullets = {}
	walls = {}
	stars = {}

	for i = 1, 20 do
		table.insert(asteroids, Asteroid:new(world))
	end
	for i = 1, 20 do
		table.insert(stars, Star:new())
	end
	build_walls(walls)
end

function love.update(dt)
	local Asteroid = require("asteroid")

	for i, asteroid in ipairs(asteroids) do
		asteroid:update(dt)
		if out_of_bounds_asteroid(asteroid) then
			table.remove(asteroids, i)
			table.insert(asteroids, Asteroid:new(world))
		end
	end
	for i, bullet in ipairs(bullets) do
		bullet:update(dt)
		if out_of_bounds(bullet) then
			table.remove(bullets, i)
		end
	end
	player:update(dt)
	world:update(dt)

	for i, asteroid in ipairs(asteroids) do
		if player.body:isTouching(asteroid.body) then
			love.load()
		end
		for j, bullet in ipairs(bullets) do
			if asteroid.body:isDestroyed() then
				goto continue
			end
			if asteroid.body:isTouching(bullet.body) then
				table.insert(asteroids, Asteroid:new(world))
				bullet.body:destroy()
				asteroid.body:destroy()
				table.remove(bullets, j)
				table.remove(asteroids, i)
				score.value = score.value + 1
			end
		end
		::continue::
	end
end

function love.draw()
	for i, v in ipairs(stars) do
		v:draw()
	end
	for i, v in ipairs(asteroids) do
		v:draw()
	end
	for i, v in ipairs(bullets) do
		v:draw()
	end
	player:draw()
	score:draw()
end

function love.keypressed(key)
	if key == "space" then
		local Bullet = require("bullet")
		table.insert(
			bullets,
			Bullet:new(
				player.x + player.width * 3 / 4 * math.cos(player.angle - math.pi / 2),
				player.y + player.height * 3 / 4 * math.sin(player.angle - math.pi / 2),
				player.body:getWorld(),
				player.angle
			)
		)
	end
	if key == "escape" then
		love.event.quit()
	end
end

function build_walls(walls)
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

function out_of_bounds(obj)
	return obj.x + obj.width / 2 < 0
		or obj.x - obj.width / 2 > love.graphics.getWidth()
		or obj.y + obj.height / 2 < 0
		or obj.y - obj.height / 2 > love.graphics.getHeight()
end

function out_of_bounds_asteroid(obj)
	return out_of_bounds(obj) and not (obj.y + obj.height / 2 < 0)
end
