this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/nitori_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/nitori_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 6;
	this.baseGravity = 0.50000000;
	this.baseSlideSpeed = 16.00000000;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.resetFunc = function ()
	{
		this.bulletCharge = 0;
		this.charge = 1000;
		this.skillC_chain = false;
		this.occult = 0;
		this.robo = null;
		this.airWire = false;
	};
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("nitori");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori_com_function.nut", this.player_class);
