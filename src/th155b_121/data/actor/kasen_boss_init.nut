this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/kasen_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/kasen_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 10;
	this.baseGravity = 0.50000000;
	this.baseSlideSpeed = 14.00000000;
	this.atkRange = 65;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_beginDemoSkip = function ()
	{
		this.CommonBeginBattleSkip();

		if (this.eagle)
		{
			this.eagle.x = this.x - 50 * this.direction;
			this.eagle.y = this.centerY - 400;
			this.eagle.Eagle_Wait(null);
		}
	};
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.resetFunc = function ()
	{
		this.eagle = this.SetShot(this.x - 50 * this.direction, this.y - 400, this.direction, this.Eagle_Wait, {}).weakref();
		this.mark = [];
		this.dragon = null;
		this.tiger = null;
		this.seals = null;
		this.ball = null;
	};
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
	};
	this.eagle = this.SetShot(this.x - 50 * this.direction, this.y - 400, this.direction, this.Eagle_Wait, {}).weakref();
	this.mark = [];
	this.dragon = null;
	this.tiger = null;
	this.seals = null;
	this.ball = null;
	this.Load_SpellCardData("kasen");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_boss.nut", this.player_class);
