STRINGS =
{
	['English'] =
	{
		controls = L"[HL=00ff00ff]Plane controls: [/HL][HL]Switch plane:[/HL] click on plane, or PG up/down. [HL]Exit:[/HL] right click. [HL]Elevator:[/HL] A,D,←,→ (LSHIFT to aim). [HL]Throttle:[/HL] W,S,↑,↓.",
		controls2 = L"[HL]Controls rebindable via top left button.[/HL]",
		plane_occupied = L"Allied plane already in use",
		spacebar = L"Space",
		speed = L"Speed",
		altitude = L"Altitude",
	},
	['Chinese'] =
	{
		--provided by SamZong
		controls = L"[HL=00ff00ff]可操控飞机控制指南: [/HL][HL]切换飞机:[/HL] 左键点击飞机,或者按PgUp或PgDn. [HL]取消选中飞机:[/HL] 右键. [HL]高度控制:[/HL] A, D, ←, →. [HL]速度控制:[/HL] W, S, ↑, ↓.",
		controls2 = L"[HL]可通过屏幕左上角的按钮重新绑定飞机操控快捷键。[/HL]", --manual calibration
		plane_occupied = L"队友已在控制这架飞机。", --manual calibration
		spacebar = L"空格",
		speed = L"速度",
		altitude = L"海拔高度",
	},
}

function GetLanguage()
	local templang = Language()
	if STRINGS[templang] then
		lang = templang
	else
		lang = 'English'
	end
end