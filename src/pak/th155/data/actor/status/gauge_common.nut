this.texture <- ::manbow.Texture();
this.texture.Load("data/actor/status/texture/gauge.png");
this.anime_set <- ::manbow.AnimationSet2D();
this.anime_set.Load("data/actor/status/gauge.pat", null);
this.mat_center <- ::manbow.Matrix();
this.mat_left_top <- ::manbow.Matrix();
this.mat_right_top <- ::manbow.Matrix();
this.mat_left_bottom <- ::manbow.Matrix();
this.mat_right_bottom <- ::manbow.Matrix();
this.mat_center.SetIdentity();
this.mat_left_top.SetIdentity();
this.mat_right_top.SetIdentity();
this.mat_left_bottom.SetIdentity();
this.mat_right_bottom.SetIdentity();
this.mat_identity <- ::manbow.Matrix();
this.mat_identity.SetIdentity();
this.parts <- [];
this.face <- null;
this.gauge <- null;
this.time <- null;
this.stock_list <- null;
this.alpha <- 0;
function AddParts( actor, mat_world, mat_local = this.mat_identity )
{
	local mat = ::manbow.Matrix();
	mat.Set(mat_local);
	mat.Multiply(mat_world);
	actor.SetWorldTransform(mat);
	actor.Update();
	local t = {};
	t.actor <- actor;
	t.mat_local <- mat_local;
	t.mat_world <- mat_world;
	this.parts.push(t);
}

function UpdateParts()
{
	local mat = ::manbow.Matrix();

	foreach( v in this.parts )
	{
		mat.Set(v.mat_local);
		mat.Multiply(v.mat_world);
		v.actor.SetWorldTransform(mat);
		v.actor.Update();
	}
}

class this.Gauge 
{
	env = this;
	actor = null;
	length = 0;
	state = 0;
	function Initialize( index, mat_world )
	{
		this.actor = this.manbow.AnimationControllerDynamic();
		this.actor.Init(this.env.anime_set);
		this.actor.SetMotion(index, 0);
		this.actor.ConnectRenderSlot(::graphics.slot.status, 1000);
		this.length = this.actor.width;
		this.env.AddParts(this.actor, mat_world);
	}

	function SetValue( cur, max, _state = 0 )
	{
		if (this.state != _state)
		{
			this.state = _state;
			this.actor.SetTake(this.state);
			this.length = this.actor.width;
		}

		this.actor.width = this.length * cur / max.tofloat();
		this.actor.Update();
	}

}

this.anime_set_sp <- ::manbow.AnimationSet2D();
this.anime_set_sp.Load("data/actor/status/gauge_sp.pat", null);
class this.SPGauge 
{
	env = this;
	actor = null;
	actor_flash = null;
	length = 0;
	scale = 1;
	max = 1000;
	index = 0;
	state = 0;
	parts = null;
	SetValue = null;
	function Initialize( _max, x, y, dir, mat_world )
	{
		local mat = ::manbow.Matrix();
		this.max = _max;
		this.scale = _max / 1000.00000000;
		this.actor = this.manbow.AnimationControllerDynamic();
		this.actor.Init(this.env.anime_set_sp);
		this.actor.SetMotion(10, 0);
		this.actor.ConnectRenderSlot(::graphics.slot.status, 1100);
		mat.SetScaling(dir * this.scale, 1, 1);
		mat.Translate(x, y, 0);
		this.env.AddParts(this.actor, mat_world, mat);
		this.length = this.actor.width;
		this.parts = [];
		local a = this.Create(0);
		mat = ::manbow.Matrix();
		mat.SetScaling(this.length * this.scale * dir, 1, 1);
		mat.Translate(x, y, 0);
		this.env.AddParts(a, mat_world, mat);
		this.parts.append(a);
		a = this.Create(1);
		mat = ::manbow.Matrix();
		mat.SetScaling(dir, 1, 1);
		mat.Translate(x, y, 0);
		this.env.AddParts(a, mat_world, mat);
		this.parts.append(a);
		a = this.Create(2);
		mat = ::manbow.Matrix();
		mat.SetScaling(dir, 1, 1);
		mat.Translate(x + (this.length * this.scale).tointeger() * dir, y, 0);
		this.env.AddParts(a, mat_world, mat);
		this.parts.append(a);
		this.actor_flash = this.Create(20);
		mat = ::manbow.Matrix();
		mat.SetScaling(dir * this.scale, 1, 1);
		mat.Translate(x, y, 0);
		this.env.AddParts(this.actor_flash, mat_world, mat);
		this.actor_flash.ConnectRenderSlot(::graphics.slot.status, 1101);
	}

	function Create( index )
	{
		local actor = this.manbow.AnimationController2D();
		actor.Init(this.env.anime_set_sp);
		actor.SetMotion(index, 0);
		actor.ConnectRenderSlot(::graphics.slot.status, 1000);
		return actor;
	}

	function SetValue( cur, enable )
	{
		local c = cur;
		local _state = this.state;

		if (cur >= this.max)
		{
			c = this.max;
			this.state = 2;
			this.actor_flash.visible = enable;
		}
		else
		{
			if (c < 0)
			{
				c = 0;
			}

			this.state = 0;
			this.actor_flash.visible = false;
		}

		this.state = enable ? this.state : 1;

		if (this.state != _state)
		{
			this.actor.SetMotion(10, this.state);
			this.length = this.actor.width;

			foreach( v in this.parts )
			{
				v.SetTake(enable ? 0 : 1);
			}
		}

		this.actor.width = this.length * c / this.max.tofloat();
		this.actor.Update();
		this.actor_flash.alpha = this.env.alpha;
	}

	function Show()
	{
		if (this.actor.visible)
		{
			return;
		}

		this.actor.visible = true;
		this.actor_flash.visible = true;

		foreach( v in this.parts )
		{
			v.visible = true;
		}
	}

	function Hide()
	{
		if (!this.actor.visible)
		{
			return;
		}

		this.actor.visible = false;
		this.actor_flash.visible = false;

		foreach( v in this.parts )
		{
			v.visible = false;
		}
	}

}

function CreateStaticParts( index, mat_world, mat_local = this.mat_identity, set = this.anime_set )
{
	local actor = this.manbow.AnimationController2D();
	actor.Init(set);
	actor.SetMotion(index, 0);
	actor.ConnectRenderSlot(::graphics.slot.status, 1000);
	this.AddParts(actor, mat_world, mat_local);
	return actor;
}

function Terminate()
{
	::graphics.slot.status.Show(false);
	this.parts = null;
	this.face = null;
	this.gauge = null;
	this.time = null;
	this.stock_list = null;
}

function UpdatePosition( count )
{
	local y = count * count * 1.00000000;
	this.mat_center.SetTranslation(0, -y, 0);
	local x = count * count * 3.00000000;
	this.mat_left_top.SetTranslation(-x, 0, 0);
	this.mat_right_top.SetTranslation(x, 0, 0);
	y = count * count * 2.00000000;
	this.mat_left_bottom.SetTranslation(0, y, 0);
	this.mat_right_bottom.SetTranslation(0, y, 0);
}

function Show( _imm = false )
{
	if (_imm)
	{
		this.UpdatePosition(0);
		this.UpdateParts();
		::graphics.slot.status.Show(true);
		return;
	}

	local t = {};
	t.setdelegate(this);
	t.count <- 120;
	t.Update <- function ()
	{
		this.count--;
		this.UpdatePosition(this.count);
		this.UpdateParts();

		if (this.count == 0)
		{
			::battle.DeleteTask(this);
		}
	};
	this.UpdatePosition(t.count);
	this.UpdateParts();
	::graphics.slot.status.Show(true);
	::battle.AddTask(t);
}

function Hide()
{
	local t = {};
	t.setdelegate(this);
	t.count <- 0;
	t.Update <- function ()
	{
		this.count++;
		this.UpdatePosition(this.count);
		this.UpdateParts();

		if (this.count > 30)
		{
			::graphics.slot.status.Show(false);
			::battle.DeleteTask(this);
		}
	};
	::battle.AddTask(t);
}

function UpdateGauge( env )
{
	this.life.SetValue(this.team.life, this.team.life_max, this.team.life == this.team.life_max ? 1 : 0);
	this.regain.SetValue(this.team.regain_life, this.team.life_max, 3);
	this.damage.SetValue(this.team.damage_life, this.team.life_max, 2);

	if (this.team.op_stop > 0)
	{
		this.op.SetValue(this.team.op_stop, this.team.op_stop_max, 1);

		if (this.op_state.keyTake != 0)
		{
			this.op_state.SetTake(0);
		}

		this.op_state.visible = true;
		this.op_flash.visible = false;
		this.op_flash2.visible = false;

		if (this.face_slave && this.face_slave.keyTake != 2)
		{
			this.face_slave.SetTake(2);
		}
	}
	else if (this.team.current == this.team.slave)
	{
		this.op.SetValue(this.team.op, 2000, 0);

		if (this.op_state.keyTake != 1)
		{
			this.op_state.SetTake(1);
		}

		if (this.face_slave && this.face_slave.keyTake != 1)
		{
			this.face_slave.SetTake(1);
		}

		this.op_state.visible = true;
		this.op_flash.visible = false;
		this.op_flash2.visible = true;
		this.op_flash2.alpha = env.alpha;
	}
	else
	{
		if (this.team.op == 2000)
		{
			this.op.SetValue(this.team.op, 2000, 2);
			this.op_flash.visible = true;
			this.op_flash.alpha = env.alpha;

			if (this.face_slave && this.face_slave.keyTake != 1)
			{
				this.face_slave.SetTake(1);
			}
		}
		else if (this.team.op >= 1000)
		{
			this.op.SetValue(this.team.op, 2000, 2);
			this.op_flash.visible = false;

			if (this.face_slave && this.face_slave.keyTake != 1)
			{
				this.face_slave.SetTake(1);
			}
		}
		else
		{
			this.op.SetValue(this.team.op, 2000, 0);
			this.op_flash.visible = false;

			if (this.face_slave && this.face_slave.keyTake != 2)
			{
				this.face_slave.SetTake(2);
			}
		}

		this.op_state.visible = false;
		this.op_flash2.visible = false;
	}

	local cur = this.team.mp / 200;

	for( local j = 0; j < 5; j = ++j )
	{
		if (j == cur)
		{
			this.mp[j].SetValue(this.team.mp % 200, 200, 0);
		}
		else if (j < cur)
		{
			this.mp[j].SetValue(200, 200, 1);
		}
		else
		{
			this.mp[j].SetValue(0, 200, 0);
		}
	}

	this.sp[0].SetValue(this.team.sp, this.team.sp_stop == 0);

	if (this.team.sp2_enable)
	{
		this.sp[1].Show();
		this.sp[1].SetValue(this.team.sp - this.team.sp_max, this.team.sp_stop == 0);
	}
	else
	{
		this.sp[1].Hide();
	}
}

function FlashTime()
{
	local t = {};
	t.setdelegate(this);
	t.count <- 30;
	t.Update <- function ()
	{
		this.count--;
		this.time.blue = this.time.green = 1.00000000 - this.count / 30.00000000;

		if (this.count == 0)
		{
			::battle.DeleteTask(this);
		}
	};
	::battle.AddTask(t);
}

function SetWin( side, index )
{
	if (index >= this.gauge[side].win.len())
	{
		return;
	}

	this.gauge[side].win[index].SetTake(1);
}

function SetFace( target_name, src_name, index, take = 0 )
{
	if ((target_name in this.face) && src_name in ::actor.actor_list)
	{
		this.face[target_name].Init(::actor.actor_list[src_name].mgr.GetAnimationSet2D());
		this.face[target_name].SetMotion(index, take);
		this.face[target_name].Update();
	}
}

function SetCard( side, name, id )
{
	::spell.SetCardSprite(this.gauge[side].spell, name, id);
}

