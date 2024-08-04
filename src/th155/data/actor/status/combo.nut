this.texture <- ::manbow.Texture();
this.texture.Load("data/actor/status/texture/gauge.png");
this.anime_set <- ::manbow.AnimationSet2D();
this.anime_set.Load("data/actor/status/combo.pat", null);
class this.Combo 
{
	set = this.anime_set;
	tex = this.texture;
	mat = null;
	ox = 20;
	x = 0;
	y = 140;
	count = 0;
	combo = 0;
	damage = 0;
	rate = 0;
	stun = 0;
	base_x = null;
	base_y = null;
	actor_list = null;
	team = null;
	Update = null;
	scale = 1;
	constructor()
	{
		this.Update = this.Update0;
	}

	function Initialize( side )
	{
		this.team = ::battle.team[side];

		switch(side)
		{
		case 0:
			this.ox = 970;
			break;

		case 1:
			this.ox = 180;
			break;
		}

		this.mat = ::manbow.Matrix();
		this.actor_list = [];
		local actor = this.manbow.AnimationController2D();
		actor.Init(this.set);
		actor.SetMotion(0, 0);
		actor.ConnectRenderSlot(::graphics.slot.status, 1300);
		this.actor_list.push(actor);
		this.combo = ::manbow.Number();
		this.combo.Initialize(this.tex, 0, 592, 48, 54, 3, -10, false);
		this.combo.ox = 24;
		this.combo.oy = 27;
		this.combo.filter = 1;
		this.damage = ::manbow.Number();
		this.damage.Initialize(this.tex, 0, 575, 16, 18, 5, -5, false);
		this.damage.filter = 1;
		this.rate = ::manbow.Number();
		this.rate.Initialize(this.tex, 0, 575, 16, 18, 4, -5, false);
		this.rate.filter = 1;
		this.stun = ::manbow.Number();
		this.stun.Initialize(this.tex, 0, 575, 16, 18, 4, -5, false);
		this.stun.filter = 1;
		local number_actor = [];
		number_actor.push(this.combo);
		number_actor.push(this.damage);
		number_actor.push(this.rate);
		number_actor.push(this.stun);
		actor = this.manbow.AnimationController2D();
		actor.Init(this.set);
		actor.SetMotion(1, 0);
		actor.ConnectRenderSlot(::graphics.slot.status, 1300);
		this.actor_list.push(actor);

		foreach( i, v in number_actor )
		{
			v.x = actor.GetFramePointX(i);
			v.y = actor.GetFramePointY(i);
			v.filter = 2;
			v.ConnectRenderSlot(::graphics.slot.status, 1300);
			this.actor_list.push(v);
		}

		foreach( v in this.actor_list )
		{
			v.visible = false;
		}
	}

	function Activate()
	{
		this.scale = 1,50000000.0;

		if (this.Update == this.Update1)
		{
			return;
		}

		this.Update = this.Update1;
		local mat = ::manbow.Matrix();
		mat.SetTranslation(this.ox + this.x, this.y, 0);

		foreach( v in this.actor_list )
		{
			v.SetWorldTransform(mat);
			v.visible = true;
			v.alpha = 1;
		}

		this.Update();
	}

	function Deactivate()
	{
		if (this.Update != this.Update1)
		{
			return;
		}

		this.Update = this.Update2;
		this.count = 0;
	}

	function Update0()
	{
		if (this.team.combo_count == 0 && this.team.damage_life > this.team.life)
		{
			this.team.damage_life -= 64;
		}
	}

	function Update1()
	{
		if (this.scale > 1,00000000.0)
		{
			this.scale -= 0,10000000.0;
			this.combo.sx = this.scale;
			this.combo.sy = this.scale;
		}

		this.combo.SetValue(this.team.combo_count.tointeger());
		this.damage.SetValue(this.team.combo_damage.tointeger());
		this.rate.SetValue((this.team.damage_scale * 100).tointeger());
		this.stun.SetValue(this.team.combo_stun.tointeger());
	}

	function Update2()
	{
		if (this.count++ > 60)
		{
			this.Update = this.Update3;
			this.count = 0;
		}
	}

	function Update3()
	{
		this.count++;
		local a = 1,00000000.0 - this.count / 15,00000000.0;

		if (a <= 0)
		{
			foreach( v in this.actor_list )
			{
				v.visible = false;
			}

			this.Update = this.Update0;
			return;
		}

		foreach( v in this.actor_list )
		{
			v.alpha = a;
		}
	}

	function IsVisible()
	{
		return this.Update != this.Update0;
	}

}

