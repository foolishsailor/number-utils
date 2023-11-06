local Number = {}

function validateInput(value)
	if not tonumber(value) then
		error("Invalid Input: Expected number/string for input got " .. typeof(value), 3)
	end
end

function Number.toString(num: number, decimals: number)
	validateInput(num)

	local formatString = "%." .. tostring(decimals) .. "f"
	return string.format(formatString, num)
end

function Number.toFormattedString(num, decimals)
	local numberFormat = "%." .. tostring(decimals) .. "f"
	local formattedNumber = string.format(numberFormat, num)

	local integerPart, decimalPart = formattedNumber:match("^(%-?%d+)(%.%d*)$")

	integerPart = integerPart:reverse()

	local withCommas = integerPart:gsub("(%d%d%d)", "%1,")

	withCommas = withCommas:reverse()

	if withCommas:sub(1, 1) == "," then
		withCommas = withCommas:sub(2)
	end

	formattedNumber = withCommas .. (decimalPart or "")

	return formattedNumber
end

return Number
