-- Requires
local menu = require "src/menu"

-- Loads
function love.load()
	gameRenderScale = love.graphics.getHeight()/1080
	if (gameRenderScale > love.graphics.getWidth()/1920) then
		gameRenderScale = love.graphics.getWidth()/1920
	end
	xPadding = (love.graphics.getWidth() - (1920 * gameRenderScale)) / 2
	yPadding = (love.graphics.getHeight() - (1080 * gameRenderScale)) / 2
	menu.load()
	mouseLetGo = true
end

-- Updates
function love.update()
	menu.update()
	if currentPage = "inGame" then

	end
	if (love.mouse.isDown(1) == false) then
		mouseLetGo = true
	else
		mouseLetGo = false
	end
end

-- Drawing
function love.draw()
	love.graphics.push()
	love.graphics.scale(gameRenderScale)
	love.graphics.translate(xPadding, yPadding)
	love.graphics.setBackgroundColor(0, 0, 1)
	menu.draw()
	if currentPage = "inGame" then

	end
	love.graphics.pop()
end