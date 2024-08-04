this.player_class.sn <- {};
this.player_class.autoCount <- null;
this.player_class.preAutoCount <- null;
this.player_class.autoAttack <- null;
this.player_class.attackType <- null;
this.player_class.autoFunc <- null;
this.player_class.timeFunc <- null;
this.player_class.autoCancelLevel <- null;
this.player_class.autoTable <- null;
this.player_class.autoAttackTimes <- null;
this.player_class.sence <- null;
this.player_class.hide <- false;
this.player_class.sneeze <- 0;
this.player_class.skillE_react <- false;
this.player_class.skillE_line <- null;
this.player_class.roseF <- null;
this.player_class.spellC_List <- null;
this.player_class.occultCycle <- -1;
this.player_class.occultRange <- 0;
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/koishi_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/koishi_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 7;
	this.baseGravity = 0,40000001.0;
	this.baseSlideSpeed = 12,50000000.0;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.autoCount = [
		0,
		0,
		0
	];
	this.preAutoCount = [
		0,
		0,
		0
	];
	this.autoAttack = [
		null,
		null,
		null
	];
	this.attackType = [
		0,
		0,
		0
	];
	this.autoFunc = [
		null,
		null,
		null
	];
	this.timeFunc = [
		null,
		null,
		null
	];
	this.autoCancelLevel = [
		0,
		0,
		0
	];
	this.autoTable = [
		{},
		{},
		{}
	];
	this.autoAttackTimes = [
		0,
		0,
		0
	];
	local t1_ = {};
	t1_.take <- 0;
	t1_.rot <- 0;
	local t2_ = {};
	t2_.take <- 1;
	t2_.rot <- 120 * 0,01745329.0;
	local t3_ = {};
	t3_.take <- 2;
	t3_.rot <- 240 * 0,01745329.0;
	this.sence = [
		this.SetFreeObject(this.x, this.y, this.direction, this.SenceObject, t1_).weakref(),
		this.SetFreeObject(this.x, this.y, this.direction, this.SenceObject, t2_).weakref(),
		this.SetFreeObject(this.x, this.y, this.direction, this.SenceObject, t3_).weakref()
	];
	this.roseF = [];
	this.spellC_List = [];
	this.resetFunc = function ()
	{
		this.autoCount = [
			0,
			0,
			0
		];
		this.preAutoCount = [
			0,
			0,
			0
		];
		this.autoAttack = [
			null,
			null,
			null
		];
		this.attackType = [
			0,
			0,
			0
		];
		this.autoFunc = [
			null,
			null,
			null
		];
		this.timeFunc = [
			null,
			null,
			null
		];
		this.autoCancelLevel = [
			0,
			0,
			0
		];
		this.autoTable = [
			{},
			{},
			{}
		];
		this.autoAttackTimes = [
			0,
			0,
			0
		];
		this.sence = [
			this.SetFreeObject(this.x, this.y, this.direction, this.SenceObject, t1_).weakref(),
			this.SetFreeObject(this.x, this.y, this.direction, this.SenceObject, t2_).weakref(),
			this.SetFreeObject(this.x, this.y, this.direction, this.SenceObject, t3_).weakref()
		];
		this.hide = false;
		this.sneeze = 0;
		this.skillE_react = false;
		this.skillE_line = null;
		this.occultCycle = -1;
		this.occultRange = 0;
		this.roseF = [];
		this.spellC_List = [];
	};
	this.change_reset = function ()
	{
	};
	this.motion_test = [
		function ()
		{
			this.Team_Change_AttackB(null);
		}
	];
	this.Load_SpellCardData("koishi");

	if (this.team.slave == this)
	{
		this.spellcard.id = 0;
	}
};
