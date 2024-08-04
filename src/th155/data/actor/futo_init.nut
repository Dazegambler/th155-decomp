this.player_class.sn <- {};
this.player_class.dish <- [];
this.player_class.brokenDish <- 0;
this.player_class.dishLevel <- 0;
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/futo_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/futo_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 4;
	this.baseGravity = 0,77999997.0;
	this.baseSlideSpeed = 18,00000000.0;
	this.slave_spell = 1;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.change_reset = function ()
	{
	};
	this.resetFunc = function ()
	{
		this.dish = [];
		this.brokenDish = 0;
	};
	this.Load_SpellCardData("futo");

	if (this.team.slave == this)
	{
		this.spellcard.id = 1;
	}
};
