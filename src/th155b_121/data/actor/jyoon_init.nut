local pat_name = "data/actor/shion/shion_option.pat";
local palette_name = "data/actor/shion/palette" + (this.color < 100 ? "0" : "") + (this.color < 10 ? "0" : "") + this.color + ".bmp";
this.mgr.LoadAnimationData(pat_name, palette_name);
this.player_class.sn <- {};
this.player_class.shion <- null;
this.player_class.shion_act <- false;
this.player_class.shion_ban <- false;
this.player_class.wait_input <- false;
this.player_class.stg_mode <- false;
this.player_class.bag <- null;
this.player_class.uv <- this.mgr.GetGlobalAnimation(0);
this.player_class.uv_count <- 0;
this.player_class.uv2 <- this.mgr.GetGlobalAnimation(2);
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion_option.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/jyoon_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/jyoon_shot.nut", this.player_effect_class);
this.manbow.CompileFile("data/actor/shion_option.nut", this.shot_class);
this.manbow.CompileFile("data/actor/shion_option.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/shion_option.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 18;
	this.baseGravity = 0,94999999.0;
	this.baseSlideSpeed = 20,00000000.0;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.shion = this.SetObject(this.x - 60 * this.direction, this.y - 50, this.direction, this.Shion_Init, {}).weakref();
	this.resetFunc = function ()
	{
		this.stg_mode = false;
		this.wait_input = false;
		this.shion_act = false;
		this.shion = this.SetObject(this.x - 100 * this.direction, this.y - 50, this.direction, this.Shion_Init, {}).weakref();
		this.bag = null;
	};
	this.change_reset = function ()
	{
		if (this.shion_ban)
		{
			this.shion.Shion_SlaveWait(true);
		}
		else
		{
			this.shion.Shion_SlaveWait(false);
		}
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
			this.WinC(null);
		},
		function ()
		{
			this.WinD(null);
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
	this.Load_SpellCardData("jyoon");

	if (this.team.slave == this)
	{
		this.spellcard.id = 1;
	}
};
