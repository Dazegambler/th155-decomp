this.player_class.sn <- {};
this.player_class.back_park <- null;
this.player_class.back_hole <- null;
this.player_class.mukon <- null;
this.player_class.balloon <- null;
this.player_class.mukon_se <- 0;
this.player_class.mukon_charge <- 0;
this.player_class.mukon_stock <- [];
this.player_class.mukon_pos <- [];
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
	this.baseGravity = 0,44999999.0;
	this.baseSlideSpeed = 14,00000000.0;
	this.back_park = null;
	this.back_hole = [];
	this.mukon = ::manbow.Actor2DProcGroup();
	this.balloon = ::manbow.Actor2DProcGroup();
	this.mukon_se = 0;
	this.mukon_charge = 0;
	this.mukon_stock = [];
	local vec_ = this.Vector3();
	vec_.x = 100,00000000.0;
	local vec2_ = this.Vector3();
	vec2_.y = 100,00000000.0;
	local vec3_ = this.Vector3();
	vec3_.x = -100,00000000.0;
	local vec4_ = this.Vector3();
	vec4_.y = -100,00000000.0;
	this.mukon_pos = [
		vec_,
		vec2_,
		vec3_,
		vec4_
	];
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
		this.balloon.Clear();
		this.mukon_se = 0;
		this.mukon_charge = 0;
		this.mukon_stock = [];
		local vec_ = this.Vector3();
		vec_.x = 100,00000000.0;
		local vec2_ = this.Vector3();
		vec2_.y = 100,00000000.0;
		local vec3_ = this.Vector3();
		vec3_.x = -100,00000000.0;
		local vec4_ = this.Vector3();
		vec4_.y = -100,00000000.0;
		this.mukon_pos = [
			vec_,
			vec2_,
			vec3_,
			vec4_
		];
	};
	this.practice_update = function ()
	{
		if (::battle.doremy[this.team.index] >= 0)
		{
			if (this.mukon_charge != ::battle.doremy[this.team.index])
			{
				if (::battle.doremy[this.team.index] > this.mukon_charge)
				{
					this.Mukon_Charge(::battle.doremy[this.team.index] - this.mukon_charge);
				}
				else
				{
					this.mukon_charge = ::battle.doremy[this.team.index];

					if (this.mukon_stock.len() == 4 && this.mukon_charge <= 99)
					{
						this.mukon_stock[0].func[0].call(this.mukon_stock[0]);
						this.mukon_stock.remove(0);
					}

					if (this.mukon_stock.len() == 3 && this.mukon_charge <= 74)
					{
						this.mukon_stock[0].func[0].call(this.mukon_stock[0]);
						this.mukon_stock.remove(0);
					}

					if (this.mukon_stock.len() == 2 && this.mukon_charge <= 49)
					{
						this.mukon_stock[0].func[0].call(this.mukon_stock[0]);
						this.mukon_stock.remove(0);
					}

					if (this.mukon_stock.len() == 1 && this.mukon_charge <= 24)
					{
						this.mukon_stock[0].func[0].call(this.mukon_stock[0]);
						this.mukon_stock.remove(0);
					}
				}
			}
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
