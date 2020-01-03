--[[------------------------------------------------------------------
  INTERSECTING VALUES
  Intersect different values to get a fade effect
]]--------------------------------------------------------------------

if CLIENT then

  --[[
		Given a value, determines how much of each one is shown
		@param {number} a
		@param {number} b
		@param {number} value
		@return {number} result
	]]
	function HL2RBHUD:Intersect(a, b, value)
		return (a * value) + (b * (1-value));
	end

	--[[
		Intersects two colours based on a value
		@param {number} a
		@param {number} b
		@param {number} value
		@param {Color} result
	]]
	function HL2RBHUD:IntersectColour(a, b, value)
		return Color(HL2RBHUD:Intersect(a.r, b.r, value), HL2RBHUD:Intersect(a.g, b.g, value), HL2RBHUD:Intersect(a.b, b.b, value), HL2RBHUD:Intersect(a.a, b.a, value));
  end

end
