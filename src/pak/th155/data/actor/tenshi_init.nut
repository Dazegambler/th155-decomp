this.player_class.occult_back <- null;
this.player_class.occult_time <- 0;
this.player_class.occult_cycle <- 0;
this.player_class.stone <- null;
this.player_class.sword <- null;
this.player_class.momo_time <- 0;
this.player_class.momo_aura <- null;
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/tenshi_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/tenshi_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 16;
	this.baseGravity = 0.80000001;
	this.baseSlideSpeed = 17.00000000;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_beginDemoSkip = function ()
	{
		this.CommonBeginBattleSkip();

		if (this.stone)
		{
			if (this.team.current == this)
			{
				this.stone.func[2].call(this.stone);
			}
			else
			{
				this.stone.func[4].call(this.stone);
			}
		}
	};
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.resetFunc = function ()
	{
		this.stone = this.SetFreeObject(this.x, this.y, this.direction, this.Foot_Stone, {}).weakref();
		this.sword = null;
		this.momo_time = 0;
		this.momo_aura = null;
		this.occult_back = null;
		this.occult_time = 0;
		this.occult_cycle = 0;
	};
	this.change_reset = function ()
	{
		if (this.momo_aura)
		{
			this.momo_aura.func[1].call(this.momo_aura);
		}

		this.stone.func[0].call(this.stone);
		this.Vanish_Sword();
	};
	this.stone = this.SetFreeObject(this.x, this.y, this.direction, this.Foot_Stone, {}).weakref();
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
	this.Load_SpellCardData("tenshi");

	if (this.team.slave == this)
	{
		this.spellcard.id = 0;
	}
};
