local DEFAULT_SUFFIX = {"K", "M", "B", "T"}
local DEFAULT_DECIMAL_PLACE = 0

local NumAbbr = newproxy(true);
local metatable = getmetatable(NumAbbr)
metatable.__index = metatable
metatable.__metatable = "The metatable is locked"
metatable.__tostring = function() return "NumAbbr()" end

local methods = {}
methods.__index = methods
methods.__metatable = "The metatable is locked"

function validateInput(value)
	if not tonumber(value) then
		error('Invalid Input: Expected number/string for input got ' .. typeof(value), 3)
	end
end

function methods:abbreviate(value)
	validateInput(value)

	if math.abs(value) < 1e3 then
		return string.format('%.'..self.decimalPlace..'f', value)
	end

	local integralPart = tostring(value):match("%d+")
	local index = math.min(math.floor(#integralPart / 3.25), #self.suffix)
	local suffixValue = 10 ^ (index * 3)
	print(suffixValue)
	return string.format('%.'..self.decimalPlace..'f' .. self.suffix[index], value / suffixValue)
end

function methods:deabbreviate(value)
	if type(value) ~= "string" then
		return value
	end

	local mul = 1
	for index, suffix in ipairs(self.suffix) do
		value = value:gsub(suffix, function()
			mul = 10 ^ (index * 3)
			return ""
		end)
	end

	return value * mul
end

function methods:__tostring()
	return "NumAbbr(".. table.concat( self.suffix, "," ) ..")"
end

function metatable.new(decimalPlace, suffix)
	local self = {}
	self.suffix = suffix or DEFAULT_SUFFIX
	self.decimalPlace = decimalPlace or DEFAULT_DECIMAL_PLACE
	return setmetatable(self, methods)
end

function formatNum(value)
	validateInput(value)
	local _, _, sign, integralPart, decimal = tostring(value):find("([-+]?)(%d+)([.]?%d*)")
	integralPart = integralPart:reverse():gsub("(%d%d%d)", "%1,")
	return sign .. integralPart:reverse():gsub("^,", "") .. decimal
end

local BYTE_SUFFIX = {"Bytes", "KB", "MB", "GB", "TB", "PB", "EB"}
function abbreviateBytes(bytes, decimalPlace)
	validateInput(bytes)
	if bytes == 0 then return '0 Bytes' end
	decimalPlace = decimalPlace or DEFAULT_DECIMAL_PLACE
	local k = 1024;
	local i = math.floor(math.log(bytes) / math.log(k));
	return string.format("%."..decimalPlace.."f" .. BYTE_SUFFIX[i + 1], (bytes / math.pow(k, i)))
end

return {
	NumAbbr = NumAbbr,
	formatNum = formatNum,
	abbreviateBytes = abbreviateBytes,
}