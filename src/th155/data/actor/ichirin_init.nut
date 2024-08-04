this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/ichirin_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/ichirin_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/ichirin_shot.nut", this.player_effect_class);
this.player_class.unzan <- true;
this.player_class.unzanReload <- 0;
this.player_class.unzanAura <- null;
this.player_class.hassyaku <- null;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 2;
	this.baseGravity = 0,40000001.0;
	this.baseSlideSpeed = 13,00000000.0;
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
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("ichirin");

	if (this.team.slave == this)
	{
		this.spellcard.id = 0;
	}
};
