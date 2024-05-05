perf_counters = 
{
	total = {},
	hud = {},
	planes = {},
	prev_total = 0,
	prev_hud = 0,
	prev_planes = 0,
}
function PerfUpdate(delta)
	if debugging == 1 then
		PerfMark("total")
		if #perf_counters.hud > 125 then
			Log("----------")
			for k, v in pairs(perf_counters) do
				if type(v) == "table" then
					local mean = 0
					for kk, vv in pairs(v) do
						mean = mean + vv
					end
					mean = mean / #v
					Log("Mean " .. k .. " time: " .. tostring(mean * 1000) .. " ms")
				end
			end
			Log("----------")
			perf_counters.total = {}
			perf_counters.hud = {}
			perf_counters.planes = {}
		end
	end
end
function PerfMark(fun)
	if debugging == 1 then
		if perf_counters["prev_" .. fun] > 0 then
			table.insert(perf_counters[fun], GetRealTime() - perf_counters["prev_" .. fun])
			perf_counters["prev_" .. fun] = 0
		else
			perf_counters["prev_" .. fun] = GetRealTime()
		end
	end
end