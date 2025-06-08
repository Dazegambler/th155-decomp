::manbow.CompileFile("data/actor/script/actor_check.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/actor_collision.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/actor_create.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/actor_function.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/actor_game.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/actor_input.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/actor_member.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/actor_screen.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/actor_team.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/actor_update.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/class_other.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/script/input_command.nut", ::manbow.Actor2D);
::effect.Load("hit_spark_low.eft", 1000);
::effect.Load("hit_spark_mid.eft", 1001);
::effect.Load("hit_spark_high.eft", 1002);
::effect.Load("hit_spark_upper.eft", 1003);
::effect.Load("hit_spark_front.eft", 1004);
::effect.Load("hit_spark_under.eft", 1005);
::effect.Load("graze_petal.eft", 1006);
this.static_var <- ::manbow.actor2d_static_variable;
::manbow.CompileFile("data/actor/effect.nut", ::manbow.Actor2D);
::manbow.CompileFile("data/actor/object_common.nut", ::manbow.Actor2D);
this.effect_class = ::manbow.Actor2D.DerivedClass();
::manbow.CompileFile("data/actor/script/effect_member.nut", this.effect_class);
::manbow.CompileFile("data/actor/script/effect_update.nut", this.effect_class);
::manbow.CompileFile("data/actor/script/effect_function.nut", this.effect_class);
this.effect_class.effect_class <- this.effect_class.weakref();
function PlayerClassDef( c )
{
	::manbow.CompileFile("data/actor/script/object_member.nut", c);
	::manbow.CompileFile("data/actor/script/player_member.nut", c);
	::manbow.CompileFile("data/actor/script/player_buff.nut", c);
	::manbow.CompileFile("data/actor/script/player_check.nut", c);
	::manbow.CompileFile("data/actor/script/player_function.nut", c);
	::manbow.CompileFile("data/actor/script/player_game.nut", c);
	::manbow.CompileFile("data/actor/script/player_input.nut", c);
	::manbow.CompileFile("data/actor/script/player_update.nut", c);
	::manbow.CompileFile("data/actor/script/player_spell.nut", c);
}

function ShotClassDef( c )
{
	::manbow.CompileFile("data/actor/script/object_member.nut", c);
	::manbow.CompileFile("data/actor/script/shot_member.nut", c);
	::manbow.CompileFile("data/actor/script/shot_function.nut", c);
	::manbow.CompileFile("data/actor/script/shot_game.nut", c);
	::manbow.CompileFile("data/actor/script/shot_update.nut", c);
}

function CollisionObjectClassDef( c )
{
	::manbow.CompileFile("data/actor/script/object_member.nut", c);
	::manbow.CompileFile("data/actor/script/object_function.nut", c);
	::manbow.CompileFile("data/actor/script/object_game.nut", c);
	::manbow.CompileFile("data/actor/script/object_update.nut", c);
}

function PlayerEffectClassDef( c )
{
	::manbow.CompileFile("data/actor/script/player_effect_member.nut", c);
	::manbow.CompileFile("data/actor/script/player_effect_function.nut", c);
	::manbow.CompileFile("data/actor/script/player_effect_game.nut", c);
	::manbow.CompileFile("data/actor/script/player_effect_update.nut", c);
}

