// ZEUS MODULE: DCSARMA - Direct chat
["DCSARMA Chat", "Conversation",
	{
		private _module_position = param [0, [0,0,0], [[]]];
		private _selected_object = param [1, ObjNull, [ObjNull]];
		if (_selected_object isEqualTo objNull) then {
			["Place on an object"] call zen_common_fnc_showMessage;
		} else {
			[
				"CONVERSATION (" + name _selected_object + ")",
				[
					[
						"EDIT:MULTI",
						"Text",
						[
							"",
							nil,
							5
						],
						false
					]
				],
				{
					[((_this select 1) select 0), ((_this select 0) select 0)] remoteExec ["STNE_fnc_chat_SendDirect", 0];
				},
				{},
				[_selected_object]
			] call zen_dialog_fnc_create;
		};
	},
	STNE_icon_Chat
] call zen_custom_modules_fnc_register;