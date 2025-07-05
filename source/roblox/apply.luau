--!native
--!optimize 2

local function apply<instance>(instance: instance, properties: {[any]: any}): instance

	for key, value in properties do
		local key_type = type(key)
		local value_type = type(value)
		if key_type == "string" then
			if value_type == "function" then
				if typeof((instance :: any)[key]) == "RBXScriptSignal" then
					--RBX_SCRIPT_SIGNAL
				else
					--FUNCTION_RETURN_PROPERTY
				end
			else
				--PROPERTY
			end
		elseif key_type == "number" then
			if value_type == "function" then
				--FUNCTION_RETURN_CHILDREN
			elseif value_type == "table" then
				--ACTION
			elseif value_type == "userdata" then
				--CHILDREN
			end
		end
	end

	return instance
end

return apply