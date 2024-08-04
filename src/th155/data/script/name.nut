::character_name <- [
	"reimu",
	"marisa",
	"ichirin",
	"hijiri",
	"futo",
	"miko",
	"nitori",
	"koishi",
	"mamizou",
	"kokoro",
	"kasen",
	"mokou",
	"sinmyoumaru",
	"usami",
	"udonge",
	"doremy",
	"tenshi",
	"yukari",
	"jyoon"
];
::character_name_b <- [
	"��\x2593",
	"�����\x2563",
	"���",
	"�\x2563",
	"�z�s",
	"�_�q",
	"�\x2554�Ƃ�",
	"�\x2592����",
	"�}�~�]�E",
	"�\x2592�\x2592��",
	"�ؐ�",
	"���g",
	"�j���\x2588",
	"�\x2510�q",
	"���ǂ�\x2591",
	"�h���~�[",
	"�V�q",
	"��",
	"����"
];
::character_id <- {};

for( local i = 0; i < this.character_name.len(); i++ )
{
	::character_id[::character_name[i]] <- i;
}

::character_id_story <- clone ::character_id;
::character_id_story.shion <- this.character_name.len();
::character_map <- [
	[
		"reimu",
		"random",
		"marisa"
	],
	[
		"ichirin",
		"nitori",
		"futo"
	],
	[
		"hijiri",
		"kokoro",
		"miko"
	],
	[
		"koishi",
		null,
		"kasen"
	],
	[
		"mokou",
		"mamizou",
		"sinmyoumaru"
	],
	[
		"udonge",
		"doremy",
		"usami"
	],
	[
		"tenshi",
		"jyoon",
		"yukari"
	]
];
function GetCharacterSelectMap()
{
	if ("jyoon" in ::savedata.character)
	{
		return ::character_map;
	}

	local t = clone ::character_map;
	t[6] = [
		"tenshi",
		null,
		"yukari"
	];
	return t;
}

