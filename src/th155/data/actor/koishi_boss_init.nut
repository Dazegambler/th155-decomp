this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/koishi_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/koishi_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 7;
	this.baseGravity = 0.40000001;
	this.baseSlideSpeed = 12.50000000;
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
	t2_.rot <- 120 * 0.01745329;
	local t3_ = {};
	t3_.take <- 2;
	t3_.rot <- 240 * 0.01745329;
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
	this.event_defeat = this.Common_BossKoEvent;
	this.Load_SpellCardData("koishi");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/koishi_com_function.nut", this.player_class);
