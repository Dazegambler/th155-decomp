this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/ichirin_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/ichirin_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 2;
	this.baseGravity = 0.40000001;
	this.baseSlideSpeed = 13.00000000;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.unzanAura = this.SetFreeObject(this.x, this.y, this.direction, this.unzanAuraEffect, {}).weakref();
	this.resetFunc = function ()
	{
		this.unzan = true;
		this.unzanReload = 0;
		this.unzanAura = this.SetFreeObject(this.x, this.y, this.direction, this.unzanAuraEffect, {}).weakref();
		this.hassyaku = null;
	};
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("ichirin");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin_com_function.nut", this.player_class);
