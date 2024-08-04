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
	"—ì–\x2593",
	"–‚—\x2563",
	"ˆê—Ö",
	"\x2563",
	"•z“s",
	"_Žq",
	"‚\x2554‚Æ‚è",
	"‚\x2592‚¢‚µ",
	"ƒ}ƒ~ƒ]ƒE",
	"‚\x2592‚\x2592‚ë",
	"‰Øî",
	"–…g",
	"j–­Š\x2588",
	"ä\x2510Žq",
	"‚¤‚Ç‚ñ‚\x2591",
	"ƒhƒŒƒ~[",
	"“VŽq",
	"Ž‡",
	"—‰‘"
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

