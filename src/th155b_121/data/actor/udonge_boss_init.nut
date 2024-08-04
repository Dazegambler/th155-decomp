this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/udonge_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/udonge_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
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
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("udonge");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/udonge_com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_boss.nut", this.player_class);
