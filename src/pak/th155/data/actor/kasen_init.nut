this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_eagle.nut", this.player_class);
this.manbow.CompileFile("data/actor/kasen_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/kasen_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/kasen_shot.nut", this.player_effect_class);
this.manbow.CompileFile("data/actor/kasen_eagle.nut", this.shot_class);
this.manbow.CompileFile("data/actor/kasen_eagle.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/kasen_eagle.nut", this.player_effect_class);
this.player_class.eagle <- null;
this.player_class.mark <- null;
this.player_class.dragon <- null;
this.player_class.tiger <- null;
this.player_class.seals <- null;
this.player_class.ball <- null;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
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

	if (this.team.slave == this)
	{
		this.spellcard.id = 0;
	}
};
