--!native
--!optimize 2

export type Node<T> = {
}

export type SourceNode<T> = {
	cache: T,
}

export type ReactiveNode<T> = {
}


-- TODO: do this asap
local function create<T>(): Node<T>
	local node = {
	}
	return node
end

-- TODO: do this asap
local function destroy<T>(node: Node<T>)
end


-- TODO: do this asap
local function create_source<T>(value: T): SourceNode<T>
	local node = {
		cache = value
	}

	return node
end

-- TODO: do this asap
local function update_source<T>(node: SourceNode<T>, value: T)
end

-- TODO: do this asap
local function push_source<T>(node: SourceNode<T>)
end


-- TODO: do this asap
local function create_reactive<T>(): ReactiveNode<T>
	local node = {
	}

	return node
end

-- TODO: do this asap
local function evaluate_reactive<T>(node: ReactiveNode<T>)
	return 0
end

return {
	create = create,
	destroy = destroy,
	create_source = create_source,
	update_source = update_source,
	push_source = push_source,
	create_reactive = create_reactive,
	evaluate_reactive = evaluate_reactive,
}