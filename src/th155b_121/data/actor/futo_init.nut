this.player_class.sn <- {};
this.player_class.dish <- [];
this.player_class.brokenDish <- 0;
this.player_class.dishLevel <- 0;
this.player_class.dish_guage <- null;
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/futo_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/futo_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/futo_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 4;
	this.atkRange = 65;
	this.baseGravity = 0,77999997.0;
	this.baseSlideSpeed = 18,00000000.0;
	this.slave_spell = 1;

	if (this.team.index == 0)
	{
		this.dish_guage = this.SetFreeObject(120, 622, 1,00000000.0, this.Dish_Guage_Back, {}).weakref();
	}
	else
	{
		this.dish_guage = this.SetFreeObject(1120, 622, -1,00000000.0, this.Dish_Guage_Back, {}).weakref();
	}

	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.practice_update = function ()
	{
		if (::battle.futo[this.team.index] >= 0 && this.brokenDish != ::battle.futo[this.team.index])
		{
			this.brokenDish = ::battle.futo[this.team.index];
			this.dish_guage.func[1].call(this.dish_guage, this.brokenDish);
		}
	};
	this.change_reset = function ()
	{
	};
	this.resetFunc = function ()
	{
		this.dish = [];
		this.brokenDish = 0;
		this.dish_guage = null;

		if (this.team.index == 0)
		{
			this.dish_guage = this.SetFreeObject(120, 622, 1,00000000.0, this.Dish_Guage_Back, {}).weakref();
		}
		else
		{
			this.dish_guage = this.SetFreeObject(1120, 622, -1,00000000.0, this.Dish_Guage_Back, {}).weakref();
		}
	};
	this.Load_SpellCardData("futo");

	if (this.team.slave == this)
	{
		this.spellcard.id = 1;
	}
};
