-- Requires
local ui = require "src/ui"

-- Loads
function love.load()
	mouseX = 0
	mouseY = 0
	gameRenderScale = love.graphics.getHeight()/1080
	if (gameRenderScale > love.graphics.getWidth()/1920) then
		gameRenderScale = love.graphics.getWidth()/1920
	end
	xPadding = (love.graphics.getWidth() - (1920 * gameRenderScale)) / 2
	yPadding = (love.graphics.getHeight() - (1080 * gameRenderScale)) / 2

	ui.load()
end

-- Updates
function love.update()
	mouseX = love.mouse.getX() / gameRenderScale - xPadding
	mouseY = love.mouse.getY() / gameRenderScale - yPadding
	ui.update()
	if currentPage == "inGame" then
		print("TODO In-game")
	end
end

-- Drawing
function love.draw()
	love.graphics.push()
	love.graphics.scale(love.graphics.getHeight()/1080)
	ui.drawBackgrounds()
	love.graphics.pop()
	
	love.graphics.push()
	love.graphics.scale(gameRenderScale)
	love.graphics.translate(xPadding, yPadding)
	ui.draw()
	if currentPage == "inGame" then
		print("TODO In-game")
	end
	love.graphics.pop()
end