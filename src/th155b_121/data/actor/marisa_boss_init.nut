this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/marisa_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/marisa_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 1;
	this.baseGravity = 0,85000002.0;
	this.baseSlideSpeed = 19,50000000.0;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.resetFunc = function ()
	{
		this.okltItem = null;
		this.bitCore = 0;
		this.bitList = ::manbow.Actor2DProcGroup();
		this.bitShot = 0;
	};
	this.resetPracticeFunc = function ()
	{
		this.okltSelect = 0;
	};
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("marisa");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa_com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_boss.nut", this.player_class);
