this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/nitori_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/nitori_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/nitori_shot.nut", this.player_effect_class);
this.player_class.bulletCharge <- 0;
this.player_class.charge <- 1000;
this.player_class.skillC_chain <- false;
this.player_class.occult <- 0;
this.player_class.robo <- null;
this.player_class.airWire <- false;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
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
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("nitori");

	if (this.team.slave == this)
	{
		this.spellcard.id = 2;
	}
};
