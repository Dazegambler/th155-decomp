this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/mamizou_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/mamizou_shot.nut", this.player_effect_class);
this.player_class.shapeshift <- false;
this.player_class.raccoon <- 4;
this.player_class.revive <- 0;
this.player_class.hyakki <- 0;
this.player_class.spellC_Hit <- false;
this.player_class.alien <- null;
this.player_class.karasaka <- null;
this.player_class.space <- 0;
this.player_class.tanuki_gauge <- null;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 8;
	this.baseGravity = 0.40000001;
	this.baseSlideSpeed = 13.00000000;
	this.atkRange = 175.00000000;
	this.alien = [];
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_beginDemoSkip = function ()
	{
		this.CommonBeginBattleSkip();
		this.freeMap = false;
	};
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.resetFunc = function ()
	{
		this.shapeshift = false;
		this.raccoon = 4;
		this.revive = 0;
		this.hyakki = 0;
		this.spellC_Hit = false;
		this.karasaka = null;
		this.space = 0;
		this.alien = [];

		if (this.team.index == 0)
		{
			this.tanuki_gauge = this.SetFreeObject(20, 580, 1.00000000, this.Tanuki_Guage_Back, {}).weakref();
		}
		else
		{
			this.tanuki_gauge = this.SetFreeObject(1260, 580, -1.00000000, this.Tanuki_Guage_Back, {}).weakref();
		}

		if (this.tanuki_gauge)
		{
			this.tanuki_gauge.func[1].call(this.tanuki_gauge, this.raccoon);
		}
	};

	if (this.team.index == 0)
	{
		this.tanuki_gauge = this.SetFreeObject(20, 580, 1.00000000, this.Tanuki_Guage_Back, {}).weakref();
	}
	else
	{
		this.tanuki_gauge = this.SetFreeObject(1260, 580, -1.00000000, this.Tanuki_Guage_Back, {}).weakref();
	}

	if (this.tanuki_gauge)
	{
		this.tanuki_gauge.func[1].call(this.tanuki_gauge, this.raccoon);
	}

	this.func_beginDemoSkip = function ()
	{
		this.CommonBeginBattleSkip();
		this.freeMap = false;
	};
	this.change_reset = function ()
	{
		this.event_getAttack = null;
	};
	this.practice_update = function ()
	{
		if (::battle.mamizou[this.team.index] >= 0 && this.raccoon != ::battle.mamizou[this.team.index])
		{
			this.raccoon = ::battle.mamizou[this.team.index];
			this.revive = 0;

			if (this.tanuki_gauge)
			{
				this.tanuki_gauge.func[1].call(this.tanuki_gauge, this.raccoon);
			}
		}
	};
	this.resetPracticeFunc = function ()
	{
		this.hyakki = 0;
		this.space = 0;
	};
	this.motion_test = [
		function ()
		{
			this.Func_BeginBattle();
		},
		function ()
		{
			this.Func_Win();
		},
		function ()
		{
			this.Func_Lose();
		}
	];
	this.Load_SpellCardData("mamizou");

	if (this.team.slave == this)
	{
		this.spellcard.id = 1;
	}
};
