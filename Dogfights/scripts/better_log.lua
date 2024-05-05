--[[
	Note (Endo): These are Thonio's BetterLog functions. Anything below 
	this comment is thanks to him. His Discord is Thonio#8037 
	(ID: 760924271915827290), and his Steam is:
	https://steamcommunity.com/profiles/76561198070125787. 
	
	I modified them to work with the infamous 511-character limit of the Log() 
	function which BetterLog() uses underneath its shiny shell.
	
	I made the functions paranoid of extremely long strings and table keys, 
	though carefully-crafted malicious input can still trip these functions up.
--]]

-- use BetterLog for improved log function (convert to string and log tables)
-------------------------------------------------------------------------------
-- Improved Log functions -----------------------------------------------------
-------------------------------------------------------------------------------
-- Function LogTables
-- Log the given table in game format
-- Table : table to log
-- IndentLevel : indentation level of the table content (ex : 1 if it's the 
--               first time the function is called)

function LogTables(Table, IndentLevel)
	local indent_single = "    "
	local function_lead = "loadstring(Base64dec("
	local function_trail = "))"
	local LOG_LIMIT = 511
	if (not Prefix) then Prefix = "" end
	local headroom = function_lead:len() + function_trail:len() + 16
	assert (headroom < LOG_LIMIT)
	
	if Table == nil then
		Log("nil")
	else
		IndentLevel = IndentLevel or 1
		
		--[[ Prevent extreme nesting from overflowing Log() limits ]]--
		if (IndentLevel*indent_single:len() + headroom >= LOG_LIMIT) then
			IndentLevel = 1 
		end
		
		local indent = string.rep(indent_single, IndentLevel)
		local indentinf = string.rep(indent_single, IndentLevel - 1)
		
		-- metatables are a lua feature to modify how table behave (mainly 
		-- operators). Vec3 has one allowing you to use + and * on them 
		-- like a mathematical vector
		local metatable = getmetatable(Table) 
		-- if the table has a built in print method, use it
		if metatable and metatable.__tostring then
			if (IndentLevel > 1) then
				Log(indent .. tostring(Table) .. ",")
			else 
				Log(indent .. tostring(Table))
			end
			
		else -- default print method, same as their format in forts' code
			Log(indentinf .. "{")
			
			for k, v in pairs(Table) do
				--[[ Key ]]--
				if type(k) ~= "number" then
					--[[ FIXME: string keys that contain spaces or are in any 
						 way illegal Lua variable names are output bare!
						 Likewise, both string keys and string data containing 
						 characters like ", ', \, etc. that would mess up a 
						 Lua parser trying to interpret LogTables's output 
						 aren't escaped by the LogLong() function (see 
						 unimplemented escape_special argument in LogLong())
					--]]
					k = tostring(k)
					
					if (k:len() + indent:len() + headroom >= LOG_LIMIT) then
						Log("[")
						LogLong(k, LOG_LIMIT, "\"", "\"", "\\", true)
						Log("] = ")
						k = ""
						
					else
						k = k .. " = "
					end
					
				else
					k = "[" .. tostring(k) .. "] = "
				end
				
				--[[ Value ]]--
				if type(v) == "table" then
					if (key ~= "") then Log(indent .. k) end
					LogTables(v, IndentLevel + 1)
					
				elseif type(v) == "number" or type(v) == "boolean" then 
					Log(indent .. k .. tostring(v))
					
				elseif type(v) == "function" then
					if (indent:len() + k:len() + headroom <= LOG_LIMIT) then
						Log(indent .. k .. function_lead)
						LogLong(Base64Encode(string.dump(v)), LOG_LIMIT)
						Log(indent .. function_trail)
					else
						Log(k .. function_lead)
						LogLong(Base64Encode(string.dump(v)), LOG_LIMIT)
						Log(indent .. function_trail)
					end
					
				elseif type(v) == "string" or type(v) == "wstring" then
					if (v:len() + k:len() + indent:len() + headroom 
					>= LOG_LIMIT) then 
					
						if (k ~= "") then Log(k) end
						LogLong(v, LOG_LIMIT, nil, "]],", nil, true)
						
					else
						if (type(v) == "wstring") then
							Log(indent .. k .. 'L"' .. v .. '",')
						else 
							Log(indent .. k .. '"' .. v .. '",')
						end
					end
					
				else
					Log("-- /!\\ Unknown variable type \"" .. type(v) .. "\":")
					Log(indent .. k .. tostring(v) .. ",")
				end
			end
			
			if IndentLevel > 1 then
				Log(indentinf .. "},")
			else
				Log(indentinf .. "}")
			end
		end
	end
end

--[[
	The paranoid string Log() function. Logs the string in chunks if it's too 
	long for the Log() function.
	s : the input string that may be too long
	limit_size (optional) : overrides the default character limit of Log() with 
	                        the provided value. 511 is the default
	s_lead (optional) : The character(s) that will be prepended to the string,
	                    like '"' or two opening square brackets (default)
	s_trail (optional) : The character(s) that will be appended to the string, 
	                     like '"' or two closing square brackets (default)
	s_line_end (optional) : The character(s) that will be appended on each new 
	                        line the function outputs. The two square brackets 
	                        notation doesn't need to escape new lines, but 
	                        when using double-quotes or single-quotes for 
	                        strings, a newline must be escaped with '\'.
	                        Default is "" (empty)
	escape_special (optional) : NOT IMPLEMENTED YET. Escape characters that 
	                            may mess up Lua strings. Default is false.
--]]
function LogLong(s, limit_size, s_lead, s_trail, s_line_end, escape_special)
	if (not s) then Log("nil"); return; end
	local characters_requiring_escape = {"\\", "\"", "\'", "\[", "\]"}

	s = tostring(s)
	if (s:len() <= 0) then Log(" "); return; end
	
	s_lead = s_lead or "[["
	s_trail = s_trail or "]]"
	s_line_end = s_line_end or ""
	
	-- default: per-line console character limit (w/o NULL)
	limit_size = (limit_size or 511) - s_line_end:len()
	assert (limit_size >= 1)
	assert (limit_size >= math.max(s_lead:len() + s_line_end:len(), 
								   s_trail:len() + s_line_end:len()))
	
	s = s_lead .. s
	
	local index = 1
	while (index <= s:len()) do
		index_next = index + limit_size
		
		if (index_next - s_trail:len() + s_line_end:len() > s:len()) then 
			index_next = index_next - s_trail:len() + s_line_end:len()
			s_line_end = s_trail
			
		elseif (index_next > s:len()) then 
			index_next = index_next - s_trail:len() + s_line_end:len()
		end
		
		Log(s:sub(index, index_next - 1) .. s_line_end)
		index = index_next
	end
end

--[[
	Base-64-encoder for encoding Lua bytecode of functions into Log()-friendly 
	ASCII text. Used in LogTables() instead of LogFunction()
--]]
function Base64Encode(data)
	local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	return ((data:gsub('.', function(x) 
		local r,b='',x:byte()
		for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
		return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (#x < 6) then return '' end
		local c=0
		for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
		return b:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#data%3+1])
end

-------------------------------------------------------------------------------
-- Function LogFunction
-- If FindFunctionName is present, logs the name of the function (instead of 
-- the memory adress)
--[[
	NOTE (Endo): This function isn't used internally in this BetterLog version.
	It's still here in case you try to use this version as a drop-in 
	replacement and you use it in your stuff.
--]]

function LogFunction(Func)
	if FindFunctionName and FindFunctionName(Func) then
		Log("function : " .. FindFunctionName(Func))
	else
		Log(tostring(Func))
	end
end

-------------------------------------------------------------------------------
-- Function BetterLog
-- Log the argument in the approriate format. convert it automatically to a 
-- string if needed.
-- v : variable to log (any type)

function BetterLog(v)
	if (not v) then Log("nil"); return; end
	
	local LOG_LIMIT = 511
	
	if type(v) == "table" then
		LogTables(v)
		
	elseif type(v) == "function" then
		Log("loadstring(Base64dec(  -- Function bytecode in Base-64 follows:")
		LogLong(Base64Encode(string.dump(v)))
		Log("))")
		
	elseif type(v) == "number" or type(v) == "boolean" then 
		Log(tostring(v))
		
	else
		v_type = type(v)
		v = tostring(v)
		if (v:len() <= 0) then 
			Log("\"\"")
			return
		end
		
		if (v:len() >= LOG_LIMIT) then
			LogLong(v)
		else
			if (v_type == "wstring") then
				Log("L\"" .. v .. "\"")
			else 
				Log("\"" .. v .. "\"")
			end
		end
	end
end