require 'leg'

function createSpider(pos)
	local spider = {
		pos = pos,
		legs = {
			createLeg(pos - vec2(50, 0), 75, 150, true),
			createLeg(pos - vec2(35, 0), 75, 150, true),
			createLeg(pos - vec2(20, 0), 75, 150, true),
			createLeg(pos + vec2(20, 0), 75, 150),
			createLeg(pos + vec2(35, 0), 75, 150),
			createLeg(pos + vec2(50, 0), 75, 150),


		},
	}

	function spider:update(targetPos)
		for _, leg in ipairs(self.legs) do
			leg:update(targetPos)
		end
	end

	function spider:draw()
		love.graphics.setColor(1.0, 1.0, 1.0)
		love.graphics.ellipse("line", self.pos.x, self.pos.y, 100, 50)
		for _, leg in ipairs(self.legs) do
			leg:draw()
		end
	end

	return spider
end
