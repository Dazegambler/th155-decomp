::manbow.CompileFile("data/script/scene/vs.nut", this);
this.position <- [
	-1,
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15,
	16,
	17,
	18,
	19,
	20
];
this.life <- [
	-1,
	1,
	2500,
	5000,
	7500,
	9999
];
this.regain <- [
	-1,
	1,
	2500,
	5000,
	7500,
	9999
];
this.mp <- [
	-1,
	0,
	200,
	400,
	600,
	800,
	1000
];
this.op <- [
	-1,
	0,
	500,
	1000,
	1500,
	2000
];
this.sp <- [
	-1,
	0,
	1,
	2
];
this.guard <- [
	-1,
	0,
	1,
	2,
	3,
	4,
	5
];
this.slave_2p <- [
	-1,
	0,
	1
];
this.marisa <- [
	-1,
	3,
	0,
	1,
	2
];
this.hijiri <- [
	-1,
	0,
	1,
	2,
	3,
	4,
	5
];
this.futo <- [
	-1,
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10
];
this.miko <- [
	-1,
	0,
	1,
	2
];
this.mamizou <- [
	-1,
	0,
	1,
	2,
	3,
	4
];
this.kokoro <- [
	-1,
	3,
	0,
	1,
	2
];
this.udonge <- [
	-1,
	0,
	1000,
	2000,
	3000,
	4000,
	5000,
	6000,
	7000,
	8000,
	9000,
	10000
];
this.doremy <- [
	-1,
	0,
	25,
	50,
	75,
	100
];
class this.InitializeParam 
{
	game_mode = 40;
	difficulty = 0;
	device_id = [];
	mode = [];
	master_id = [];
	slave_id = [];
	master_color = [];
	slave_color = [];
	spell = [];
	background_id = 26;
	bgm_id = 1;
	seed = 0;
	constructor()
	{
		this.device_id = [
			-2,
			-2
		];
		this.mode = [
			0,
			0
		];
		this.master_id = [
			0,
			0
		];
		this.slave_id = [
			0,
			0
		];
		this.master_color = [
			0,
			0
		];
		this.slave_color = [
			0,
			0
		];
		this.spell = [
			0,
			0
		];
	}

}

