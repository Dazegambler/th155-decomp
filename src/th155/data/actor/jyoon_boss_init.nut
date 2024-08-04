this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/jyoon_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/jyoon_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
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
		this.shion_act = false;
		this.shion = this.SetObject(this.x - 100 * this.direction, this.y - 50, this.direction, this.Shion_Init, {}).weakref();
		this.bag = null;
	};
	this.event_defeat = this.Common_BossKoEvent;
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
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/jyoon_com_function.nut", this.player_class);
