function FormatNumber(number, decimals)
  if number and type(number) == "number" then
    return string.format("%." .. (decimals or 0) .. "f", number)
  end
  return "NaN"
end

PRECISION = -1
function SSEParams(...)
  local localFormatNumber = PRECISION == -1 and _G["tostring"] or function(n)
    return FormatNumber(n, PRECISION)
  end
  
  local params=''
  for index, value in ipairs(arg) do
    local type = type(value)
    params = params .. (index>1 and ',' or '')
    
    if     type=='number' then
      params = params .. localFormatNumber(value)
      
    elseif type=='boolean' then
      params = params .. tostring(value)
      
    elseif type=='table' and value.x and value.y then -- Vec3
      if PRECISION == -1 then
        params = params .. "Vec3"..tostring(value)
      else
        params = params .. "Vec3("..localFormatNumber(value.x)..
                               ","..localFormatNumber(value.y)
        if value.z then
          params = params ..   ","..localFormatNumber(value.z)
        end
        params = params .. ")"
      end
      
    elseif type=='table' and value.metal and value.energy then -- Value
      params = params .. "Value("..localFormatNumber(value.metal)..
                              ','..localFormatNumber(value.energy)..")"
      
    else
      params = params .. "'"..tostring(value).."'"
    end
    
  end
  
  if string.len(params) > 128 then
    Log("Error: SSEPrepare(): param string is to long for SendScriptEvent, try lower precision.")
  end
  return params
end