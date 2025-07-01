--!native
--!optimize 2

local function create_source(value)
	local node = {
		cache = value
	}

	return node
end

local function update_source(node, value)
end

local function push_source(node)
end

return {
	create_source = create_source,
	update_source = update_source,
	push_source = push_source,
}