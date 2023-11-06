local Number = newproxy(true)
local metatable = getmetatable(Number)
metatable.__index = metatable
metatable.__metatable = "The metatable is locked"
metatable.__tostring = function()
	return "Number()"
end

local methods = {}
methods.__index = methods
methods.__metatable = "The metatable is locked"

function validateInput(value)
	if not tonumber(value) then
		error("Invalid Input: Expected number/string for input got " .. typeof(value), 3)
	end
end

function methods:toString(value)
	validateInput(value)

	if math.abs(value) < 1e3 then
		return string.format("%." .. self.decimalPlace .. "f", value)
	end

	local integralPart = tostring(value):match("%d+")
	local index = math.min(math.floor(#integralPart / 3.25), #self.suffix)
	local suffixValue = 10 ^ (index * 3)
	print(suffixValue)
	return string.format("%." .. self.decimalPlace .. "f" .. self.suffix[index], value / suffixValue)
end

function methods:__tostring()
	return "Number(" .. table.concat(self.suffix, ",") .. ")"
end

function methods:toFormattedString(value)
	validateInput(value)
	local _, _, sign, integralPart, decimal = tostring(value):find("([-+]?)(%d+)([.]?%d*)")
	integralPart = integralPart:reverse():gsub("(%d%d%d)", "%1,")
	return sign .. integralPart:reverse():gsub("^,", "") .. decimal
end

return {
	Number = Number,
}
