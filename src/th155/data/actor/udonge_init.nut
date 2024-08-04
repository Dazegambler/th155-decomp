this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_common.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/udonge_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/udonge_shot.nut", this.player_effect_class);
this.player_class.hide <- false;
this.player_class.vision <- 0;
this.player_class.kune <- null;
this.player_class.box <- null;
this.player_class.san <- 0;
local d_ = 1,00000000.0;
this.player_class.san_gauge <- null;
this.player_class.san_mode <- false;
this.player_class.skillB_SE <- false;
this.player_class.skillA_table <- null;
this.player_class.skillA_table2 <- null;
this.player_class.skillE_air <- false;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 14;
	this.baseGravity = 0,85000002.0;
	this.baseSlideSpeed = 18,00000000.0;
	this.atkRange = 65,00000000.0;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_beginDemoSkip = function ()
	{
		this.CommonBeginBattleSkip();
		this.freeMap = false;
	};
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.colorFunction = this.UdongeColorUpdate;
	local d_ = 1,00000000.0;

	if (this.team.index == 1)
	{
		d_ = -1,00000000.0;
	}

	this.san_gauge = this.SetFreeObject(640 + 300 * d_, 520, d_, this.SAN_Gauge, {}, this.weakref());
	this.skillA_table = [
		-0,18799999.0,
		0,54000002.0,
		-0,23999999.0,
		0,08000000.0,
		-0,10000000.0,
		0,22000000.0
	];
	this.skillA_table2 = [
		-0,03800000.0,
		-0,03300000.0,
		-0,02900000.0,
		-0,03400000.0,
		-0,04500000.0,
		-0,06600000.0
	];
	this.resetFunc = function ()
	{
		this.hide = false;
		this.vision = 0;
		this.kune = null;
		this.box = null;
		this.san = 0;
		local d_ = 1,00000000.0;

		if (this.team.index == 1)
		{
			d_ = -1,00000000.0;
		}

		this.san_gauge = this.SetFreeObject(640 + 300 * d_, 520, d_, this.SAN_Gauge, {}, this.weakref());
		this.san_mode = false;
		this.skillB_SE = false;
		this.skillE_air = false;
	};
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("udonge");

	if (this.team.slave == this)
	{
		this.spellcard.id = 2;
	}
};
