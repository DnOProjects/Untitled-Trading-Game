local menu = {}

-- Requires
local misc = require "src/misc"

-- Loads
function menu.load()
	currentPage = 1
	buttons = {}
	buttonsAmount = 0
	menu.loadButtons()
end

function menu.loadButtons()
	menu.addButton(1, "inGame", "Play", 150, 100, 400, 120, 0.1, 0.1, 0.1, 0.8)
	menu.addButton(1, 2, "Options", 150, 300, 400, 120, 0.1, 0.1, 0.1, 0.8)
	menu.addButton(1, "exit", "Exit", 150, 500, 400, 120, 0.1, 0.1, 0.1, 0.8)

	menu.addButton(2, 1, "Back", 150, 500, 400, 120, 0.1, 0.1, 0.1, 0.8)
end

function menu.addButton(page, pageToGo, text, x, y, width, height, r, g, b, a)
	buttonsAmount = buttonsAmount + 1
	buttons[buttonsAmount] = {page = page, pageToGo = pageToGo, text = text, x = x, y = y, width = width, height = height, color = {r, g, b, a}, mouseOver = false}
end

-- Updates
function menu.update()
	menu.updateButtons()
end

function menu.updateButtons()
	for i, button in pairs(buttons) do
		if (button.page == currentPage) then
			button.mouseOver = misc.inBounds({love.mouse.getX(), love.mouse.getY()}, {button.x, button.y, button.width, button.height})
			if (button.mouseOver and love.mouse.isDown(1) and mouseLetGo == true) then
				if button.pageToGo == "exit" then
					love.event.quit()
				else
					currentPage = button.pageToGo
				end
			end
		end
	end
end

-- Drawing
function menu.draw()
	menu.drawButtons()
end

function menu.drawButtons()
	for i, button in pairs(buttons) do
	    if (button.page == currentPage) then
			if (button.mouseOver == false) then
				love.graphics.setColor(button.color)
			else
				love.graphics.setColor(button.color[1] - button.color[1]/4, button.color[2] - button.color[2]/4, button.color[3] - button.color[3]/4, button.color[4] - button.color[4]/4)
			end
			love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
			love.graphics.setColor(1, 1, 1)
			love.graphics.setFont(love.graphics.newFont(button.width/6))
			love.graphics.printf(button.text, button.x, button.y + (button.height/2) - (button.width/10), button.width, "center")
		end
	end
end

return menu