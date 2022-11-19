// ZEUS MODULE: DCSARMA - Radio chat
["DCSARMA Chat", "Radio Message",
	{
		private _module_position = param [0, [0,0,0], [[]]];
		private _selected_object = param [1, ObjNull, [ObjNull]];
		private _SenderName = "";
		private _Header = "RADIO MESSAGE";
		if !(_selected_object isEqualTo objNull) then {
			_SenderName = name _selected_object;
			_Header = _Header + " (" + _SenderName + ")";
		};
		[
			_Header,
			[
				[
					"EDIT",
					"Sender Name",
					[
						_SenderName,
						nil,
						1
					],
					false
				],
				[
					"EDIT:MULTI",
					"Text",
					[
						"",
						nil,
						5
					],
					false
				],
				[
					"EDIT",
					"Frequency",
					[
						"50",
						nil,
						1
					],
					false
				]
			],
			{
				[((_this select 0) select 0), ((_this select 0) select 1), ((_this select 0) select 2)] remoteExec ["STNE_fnc_chat_SendRadio", 0];
			},
			{},
			[_selected_object]
		] call zen_dialog_fnc_create;
	},
	STNE_icon_Radio
] call zen_custom_modules_fnc_register;