local misc = {}

function misc.inBounds(point, rect)
	point[1] = point[1] / gameRenderScale - xPadding
	point[2] = point[2] / gameRenderScale - yPadding
	if (point[1] > rect[1] and point[1] < rect[1] + rect[3] and point[2] > rect[2] and point[2] < rect[2] + rect[4]) then
		return true
	end
	return false
end

return misc