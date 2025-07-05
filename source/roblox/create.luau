--!native
--!optimize 2

local apply = require("./apply")
local types = require("../types")

local cache = {}

setmetatable(
	cache,
	{
		__index = function(self, class)
			local success = pcall(Instance.new, class)
			if not success then
				error(`cannot crete class {class}`, 2)
			end
			local function cached()
				return Instance.new(class)
			end
			cache[class] = cached
			return cached
		end
	}
)

local function create<Class>(
	class: Class | keyof<types.Instances> | ""
): (
	properties: types.GetProperties<types.Instances, Class>
) -> (
	types.GetInstance<types.Instances, Class>
)
	local this = cache[class]
	return function(properties)
		return apply(this(), properties) :: any
	end
end

return create