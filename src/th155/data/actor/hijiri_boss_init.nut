this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/hijiri_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/hijiri_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/hijiri_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/hijiri_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/hijiri_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/hijiri_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 3;
	this.baseGravity = 0.94999999;
	this.baseSlideSpeed = 21.00000000;
	this.slave_spell = 1;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	local t1_ = {};
	t1_.rot <- 0.00000000;
	local t2_ = {};
	t2_.rot <- 72.00000000 * 0.01745329;
	local t3_ = {};
	t3_.rot <- 144.00000000 * 0.01745329;
	local t4_ = {};
	t4_.rot <- 216.00000000 * 0.01745329;
	local t5_ = {};
	t5_.rot <- 288.00000000 * 0.01745329;
	this.chantCountBall = [
		this.SetFreeObject(this.x, this.y, this.direction, this.Chant_Counter, t1_).weakref(),
		this.SetFreeObject(this.x, this.y, this.direction, this.Chant_Counter, t2_).weakref(),
		this.SetFreeObject(this.x, this.y, this.direction, this.Chant_Counter, t3_).weakref(),
		this.SetFreeObject(this.x, this.y, this.direction, this.Chant_Counter, t4_).weakref(),
		this.SetFreeObject(this.x, this.y, this.direction, this.Chant_Counter, t5_).weakref()
	];
	this.change_reset = function ()
	{
	};
	this.event_defeat = this.Common_BossKoEvent;
	this.resetFunc = function ()
	{
		this.shotNum = 0;
		this.chant = 0;
		this.byke = null;
		this.airByke = false;
		local t1_ = {};
		t1_.rot <- 0.00000000;
		local t2_ = {};
		t2_.rot <- 72.00000000 * 0.01745329;
		local t3_ = {};
		t3_.rot <- 144.00000000 * 0.01745329;
		local t4_ = {};
		t4_.rot <- 216.00000000 * 0.01745329;
		local t5_ = {};
		t5_.rot <- 288.00000000 * 0.01745329;
		this.chantCountBall = [
			this.SetFreeObject(this.x, this.y, this.direction, this.Chant_Counter, t1_).weakref(),
			this.SetFreeObject(this.x, this.y, this.direction, this.Chant_Counter, t2_).weakref(),
			this.SetFreeObject(this.x, this.y, this.direction, this.Chant_Counter, t3_).weakref(),
			this.SetFreeObject(this.x, this.y, this.direction, this.Chant_Counter, t4_).weakref(),
			this.SetFreeObject(this.x, this.y, this.direction, this.Chant_Counter, t5_).weakref()
		];
	};
	this.Load_SpellCardData("hijiri");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/hijiri_com_function.nut", this.player_class);
