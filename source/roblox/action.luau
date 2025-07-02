--!native
--!optimize 2

local types = require("../types")

local metatable = table.freeze({})

local function is_action(object: any): boolean
	return getmetatable(object) == metatable
end

local function create(
	callback: (Instance) -> (),
	priority: number?
): types.Action
	local self = setmetatable(
		{
			callback = callback,
			priority = priority or 1,
		},
		metatable
	)
	return self
end

return {
	metatable = metatable,
	create = create,
	is_action = is_action,
}