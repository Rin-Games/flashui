--!native
--!optimize 2

local types = require("../types")
local apply = require("./apply")

local cache = {}

setmetatable(
	cache,
	{
		__index = function(self, class)
			local success = pcall(Instance.new, class)
			if not success then
				warn(`add logger`)
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

local function create<class>(
	class: class | keyof<types.Instances> | ""
): (
	properties: types.GetProperties<types.Instances, class>
) -> (
	types.GetInstance<types.Instances, class>
)
	local this = cache[class]
	return function(properties)
		return apply(this(), properties) :: any
	end
end

return create