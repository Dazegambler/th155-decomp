local _spell_back_texture = [];
local t;
t = ::manbow.Texture();
t.Load("data/actor/common_texture/spell_back_1p.png");
_spell_back_texture.append(t);
t = ::manbow.Texture();
t.Load("data/actor/common_texture/spell_back_2p.png");
_spell_back_texture.append(t);
t = ::manbow.Texture();
t.Load("data/actor/common_texture/spell_back_lw.png");
_spell_back_texture.append(t);
class this.SpellCard 
{
	actor = null;
	id = 0;
	mat = null;
	count = 0;
	index = 0;
	spell_back_texture = _spell_back_texture;
	spell_back_ox = 0;
	actor_back = null;
	pic = null;
	x = 0;
	center = 0;
	top = 100;
	bottom = 1000;
	side = 0;
	active = false;
	Update = null;
	function Initialize( _id, _index, _side )
	{
		this.index = _index;
		this.side = _side;
		this.id = _id;
		this.mat = ::manbow.Matrix();
		local texture = _id == 3 ? this.spell_back_texture[2] : this.spell_back_texture[_side];
		this.actor_back = ::manbow.Sprite();
		this.actor_back.Initialize(texture, 0, 0, texture.width, texture.height);
		this.actor_back.y = -12 - 20;

		if (this.side == 1)
		{
			this.actor_back.sx = -1;
		}

		this.spell_back_ox = -32 * this.actor_back.sx;
	}

	function Activate( text = "" )
	{
		this.center = this.side == 0 ? ::battle.gauge.spell_name_x[this.index] : 1280 - ::battle.gauge.spell_name_x[this.index];
		this.top = ::battle.gauge.spell_name_y[this.index];
		this.bottom = ::battle.gauge.spell_name_start_y;

		if (this.side == 0)
		{
			this.actor = this.font.CreateSpellString(text, 1.00000000, 0.50000000, this.id == 3 ? 1.00000000 : 0.50000000);
			this.actor_back.x = -9999;
		}
		else
		{
			this.actor = this.font.CreateSpellString(text, this.id == 3 ? 1.00000000 : 0.50000000, 0.50000000, 1.00000000);
			this.actor.x = -this.actor.width + 16;
			this.actor_back.x = 9999;
		}

		this.actor.y = -20;
		this.x = this.center;
		this.Update = this.State0;
		this.count = 0;
		this.actor.visible = true;
		this.actor.alpha = 0;
		this.active = true;
		this.actor_back.ConnectRenderSlot(::graphics.slot.status, 1199);
		this.actor.ConnectRenderSlot(::graphics.slot.status, 1200);
		::battle.AddTask(this);
	}

	function Deactivate()
	{
		this.active = false;
	}

	function State0()
	{
		local s = 4.00000000 - this.count.tofloat() / 6.00000000;

		if (s <= 1.00000000)
		{
			s = 1.00000000;
			this.Update = this.State1;
			this.count = 0;
			this.actor.alpha = 1;
			this.actor.alpha2 = 1;
		}
		else
		{
			this.actor.alpha = this.count.tofloat() / 18.00000000;
			this.actor.alpha2 = this.actor.alpha;
			this.count++;
		}

		this.mat.SetScaling(s, s, 1);
		this.mat.Translate(this.x, this.bottom, 0);
		this.actor.SetWorldTransform(this.mat);
		this.actor_back.SetWorldTransform(this.mat);
		this.actor.Update();
	}

	function State1()
	{
		if (this.count++ > 15)
		{
			this.Update = this.State2;
			this.count = 0;
		}
		else
		{
			local t = (15 - this.count) * (15 - this.count) * (this.side == 0 ? -1.50000000 : 1.50000000);
			this.actor_back.x = this.spell_back_ox + t;
		}
	}

	function State2()
	{
		local y = this.top + (this.cos(this.count * 6 * 3.14159012 / 180.00000000) + 1.00000000) * (this.bottom - this.top) * 0.50000000;

		if (this.count == 30)
		{
			y = this.top;
			this.Update = this.State3;
			this.count = 0;
		}
		else
		{
			this.count++;
		}

		this.mat.SetTranslation(this.x, y, 0);
		this.actor.SetWorldTransform(this.mat);
		this.actor.Update();
		this.actor_back.SetWorldTransform(this.mat);
	}

	function State3()
	{
		if (!this.active)
		{
			this.Update = this.State4;
			this.count = 0;
		}
	}

	function State4()
	{
		local tx = this.count * this.count * (this.side == 0 ? -0.50000000 : 0.50000000);

		if (this.count++ > 20)
		{
			this.actor.DisconnectRenderSlot();
			this.actor_back.DisconnectRenderSlot();
			::battle.DeleteTask(this);
		}

		this.mat.SetTranslation(this.x + tx, this.top, 0);
		this.actor.SetWorldTransform(this.mat);
		this.actor.Update();
		this.actor_back.SetWorldTransform(this.mat);
	}

}

