local asteroids
local bullets
local player
local score
local stars
local world

function love.load()
	local Asteroid = require("asteroid")
	local Player = require("player")
	local Score = require("score")
	local Star = require("star")

	asteroids = {}
	bullets = {}
	stars = {}
	world = love.physics.newWorld(0, 0)
	player = Player:new(world)
	score = Score:new()

	for i = 1, 3 do
		table.insert(asteroids, Asteroid:new({ world = world }))
	end

	for i = 1, 16 do
		table.insert(stars, Star:new())
	end
end

local function out_of_bounds(obj)
	return obj.x + obj.width / 2 < 0
		or obj.x - obj.width / 2 > love.graphics.getWidth()
		or obj.y + obj.height / 2 < 0
		or obj.y - obj.height / 2 > love.graphics.getHeight()
end

function love.update(dt)
	local Asteroid = require("asteroid")

	for i, v in ipairs(asteroids) do
		v:update(dt)
	end
	for i, v in ipairs(bullets) do
		v:update(dt)
	end
	for i, bullet in ipairs(bullets) do
		if out_of_bounds(bullet) then
			bullet.fixture:destroy()
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
				if asteroid.stage > 1 then
					for i = 1, 2 do
						table.insert(
							asteroids,
							Asteroid:new({
								x = asteroid.x,
								y = asteroid.y,
								world = asteroid.body:getWorld(),
								stage = asteroid.stage - 1,
							})
						)
					end
				end
				bullet.fixture:destroy()
				asteroid.fixture:destroy()
				table.remove(bullets, j)
				table.remove(asteroids, i)
				score.value = score.value + 1
			end
		end
		::continue::
	end

	if #asteroids == 0 then
		for i = 1, 3 do
			table.insert(asteroids, Asteroid:new({ world = world }))
		end
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
