Root = --Text = "$ArtileryPanel.ArtileryPanel",
{
	Name = "SB_PP_Root",
	Type = "Static",
	Style = "Normal",
	Texture = "ui/textures/FE-Panel.tga",
	Colour ={0,0,0,0},
	Control =
	{
		--Anchor = 0,
		Position = {0,35}, -- TODO: dynamic move with 1st weapon group
		--Size = {0,0},
		Children =
		{
			{
				Name = "SB_PP_Pin",
				Type = "Button",
				Style = "Normal",
				Normal = { 255, 255, 255, 150 },
				Pressed = { 255, 255, 255, 255 },
				Rollover = { 255, 255, 255, 200 },
				--Checkbox = true,
				Static =
				{
					Texture = "ui/textures/FE-Panel.tga",
					Control =
					{
						Position = {0,0},
						ScriptX = "ParentL + 10",
						ScriptY = "ParentT + 10",
						Size = {25,25},
						Effect = "ui/setting",
					},
				},
			},
			{
				Type = "Static",
				Name = "SB_PP_Box",
				Style = "Normal",
				Texture = "ui/textures/FE-PanelTiny.tga",
				Colour = { 0, 0, 0, 0 },
				--ColourLower = { 120, 120, 120, 64 },
				Control =
				{
					Position = { 45, 10, },
					ScriptX = "ParentL + 45",
					ScriptY = "ParentT + 10",
					Size = { 100,100, }, -- 120, 41 -- 91
					--Anchor = 0,
					Children =
					{
						{
							Name = "SB_PP_Confirm",
							Type = "Button",
							Style = "Go",
							Normal = { 255, 255, 255, 150 },
							Pressed = { 255, 255, 255, 255 },
							Rollover = { 255, 255, 255, 200 },
							--Checkbox = true,
							Static =
							{
								Texture = "ui/textures/FE-CheckBox-Tick.dds",
								Control =
								{
									Position = {-35,40},
									ScriptX = "ParentL - 32",
									ScriptY = "ParentT + 55",
									Size = {35,35},
									Effect = "ui/main",
								},
							},
						},
						{
							Name = "SB_PP_Back",
							Type = "Button",
							Style = "Stop",
							Normal = { 255, 255, 255, 150 },
							Pressed = { 255, 255, 255, 255 },
							Rollover = { 255, 255, 255, 200 },
							--Checkbox = true,
							Static =
							{
								Texture = "ui/textures/FE-CheckBox-Cross.dds",
								Control =
								{
									Position = {-35,40},
									ScriptX = "ParentL - 32",
									ScriptY = "ParentT + 90",
									Size = {35,35},
									Effect = "ui/back",
								},
							},
						},
						{
							Type = "Static",
							Name = "SB_PP_VisualBoxParent",
							Style = "Normal", -- Panel
							Texture = "ui/textures/FE-PanelTiny.tga",
							Colour = { 200, 200, 200, 80 },
							ColourLower = {80, 80, 80, 5 },
							Control =
							{
								Position = { 0, 0, },
								Size = { 175, 210, },
								Children =
								{
--subtracting 8 indents for Root.Control.Children[2].Control.Children[3].Control.Children
{
	Type = "Text",
	Name = "SB_PP_Name1",
	Style = "Normal", --List
	Text = "Action",
	Control =
	{
		Position = { 0, 0, },
		ScriptX = "ParentL + 10", --ParentMiddleX
		ScriptY = "ParentT + 9",
		--Size = { 40, 10, },
		Anchor = 0, --1
	},
},
{
	Type = "Text",
	Name = "SB_PP_Name2",
	Style = "Normal", --List
	Text = "Key",
	Control =
	{
	Position = { 0, 0, },
	ScriptX = "ParentR - 10",
	ScriptY = "ParentT + 9",
	--Size = { 40, 10, },
	Anchor = 7,
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_Fire1", -- TODO: consider constructing as list, slightly harder but more expandbile
	Style = "ListToolTips", --List
	Text = 
	{
		Text = "Fire Primary",
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10", --Buttons.Left
			ScriptY = "ParentT + 30",
			Anchor = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_Fire1Key",
					Style = "ListToolTips",
					Text = "Space Bar",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
		},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_Fire2",
	Style = "ListToolTips", --List
	Text = 
	{
		Text = "Fire Secondary",
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 50",
			Anchor = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_Fire2Key",
					Style = "ListToolTips",
					Text = "B",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
		},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_Fire3",
	Style = "ListToolTips", --List
	Text = 
	{
		Text = "Fire Tertiary",
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 70",
			Anchor = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_Fire3Key",
					Style = "ListToolTips",
					Text = "N",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
		},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_ThrottleUp",
	Style = "ListToolTips",
	Text =
	{
		Text = "Throttle Up ↑",
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 90",
			Anchor = 0,
			TabStop = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_ThrottleUpKey",
					Style = "ListToolTips",
					Text = "W",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
		},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_ThrottleDown",
	Style = "ListToolTips",
	Text =
	{
		Text = "Throttle Down ↓",
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 110",
			Anchor = 0,
			TabStop = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_ThrottleDownKey",
					Style = "ListToolTips",
					Text = "S",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
		},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_ElevatorUp",
	Style = "ListToolTips",
	Text =
	{
		Text = "Turn Clockwise", --↻
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 130",
			Anchor = 0,
			TabStop = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_ElevatorUpKey",
					Style = "ListToolTips",
					Text = "D",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
	  	},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_ElevatorDown",
	Style = "ListToolTips",
	Text =
	{
		Text = "Turn Counter Clockwise", --↺
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 150",
			Anchor = 0,
			TabStop = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_ElevatorDownKey",
					Style = "ListToolTips",
					Text = "A",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
	  	},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_SelectNext",
	Style = "ListToolTips",
	Text =
	{
	  	Text = "Select Next", --↺
	  	Control =
	  	{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 170",
			Anchor = 0,
			TabStop = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_SelectNextKey",
					Style = "ListToolTips",
					Text = "Page Up",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
		},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_SelectPrev",
	Style = "ListToolTips",
	Text =
	{
		Text = "Select Previous", --↺
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 190",
			Anchor = 0,
			TabStop = 0,
			Effect = "ui/setting",
			Children =
			{
				{
				Type = "Text",
				Name = "SB_PP_SelectPrevKey",
				Style = "ListToolTips",
				Text = "Page Down",
				--Colour = { 255, 255, 255, 255 },
				--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
		},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_CommanderAbility",
	Style = "ListToolTips",
	Text =
	{
		Text = "Commander Ability", --↺
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 210",
			Anchor = 0,
			TabStop = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_CommanderAbilityKey",
					Style = "ListToolTips",
					Text = "t",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
		},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_PrecisionModifier",
	Style = "ListToolTips",
	Text =
	{
		Text = "Aim Modifier", --↺
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 230",
			Anchor = 0,
			TabStop = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_PrecisionModifierKey",
					Style = "ListToolTips",
					Text = "L SHIFT",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
		},
	},
},
{
	Type = "TextButton",
	Name = "SB_PP_CameraPan",
	Style = "ListToolTips",
	Text =
	{
		Text = "Camera Pan", --↺
		Control =
		{
			Position = { 0, 0, },
			ScriptX = "ParentL + 10",
			ScriptY = "ParentT + 250",
			Anchor = 0,
			TabStop = 0,
			Effect = "ui/setting",
			Children =
			{
				{
					Type = "Text",
					Name = "SB_PP_CameraPanKey",
					Style = "ListToolTips",
					Text = "Middle Mouse",
					--Colour = { 255, 255, 255, 255 },
					--ColourLower = { 255, 255, 255, 155 },
					Control =
					{
						Position = { 155, 0, },
						Size = { 0, 0, },
						Anchor = 7,
					},
				},
			},
		},
	},
},
--end of subtracting 8 indents for Root.Control.Children[2].Control.Children[3].Control.Children
								},
							},
						},
					},
				},
			},
		},
	},
}