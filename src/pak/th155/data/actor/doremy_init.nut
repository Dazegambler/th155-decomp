this.player_class.sn <- {};
this.player_class.back_park <- null;
this.player_class.back_hole <- null;
this.player_class.mukon <- null;
this.player_class.mukon_se <- 0;
this.player_class.mukon_charge <- 0;
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/doremy_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/doremy_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 15;
	this.baseGravity = 0.60000002;
	this.baseSlideSpeed = 14.00000000;
	this.back_park = null;
	this.back_hole = [];
	this.mukon = ::manbow.Actor2DProcGroup();
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.change_reset = function ()
	{
	};
	this.resetFunc = function ()
	{
		this.back_park = null;
		this.back_hole = [];
		this.mukon.Clear();
		this.mukon_se = 0;
		this.mukon_charge = 0;
	};
	this.motion_test = [
		function ()
		{
			this.BeginBattleA(null);
		},
		function ()
		{
			this.BeginBattleB(null);
		},
		function ()
		{
			this.WinA(null);
		},
		function ()
		{
			this.WinB(null);
		},
		function ()
		{
			this.Lose(null);
		},
		function ()
		{
			this.Spell_A_Init(null);
		},
		function ()
		{
			this.Spell_B_Init(null);
		},
		function ()
		{
			this.Spell_C_Init(null);
		}
	];
	this.Load_SpellCardData("doremy");

	if (this.team.slave == this)
	{
		this.spellcard.id = 2;
	}
};
