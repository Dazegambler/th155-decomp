function BuffLoop()
{
	local c_ = false;

	if (this.atkBuff.len() > 0)
	{
		for( local i = 0; i < this.atkBuff.len(); i++ )
		{
			if (this.atkBuff[i].time > 0)
			{
				this.atkBuff[i].time--;
			}

			if (this.atkBuff[i].time == 0 || this.atkBuff[i].func && this.atkBuff[i].func.call(this))
			{
				this.atkBuff.remove(i);
				c_ = true;
				i--;
			}

			if (this.atkBuff.len() <= 0)
			{
				break;
			}
		}
	}

	if (c_)
	{
		this.AtkBuffSet();
	}
}

function DamageBuffAjust()
{
	this.defRate = this.baseDefRate;
	this.atkRate = this.baseAtkRate;

	if (this.baseBuff)
	{
		this.baseBuff();
	}
}

function DebuffLoop()
{
	if (this.debuff_hate.time > 0)
	{
		this.debuff_hate.time--;

		if (this.debuff_hate.time == 0)
		{
			this.DebuffEnd_Hate();
		}
	}

	if (this.debuff_fear.time > 0)
	{
		this.debuff_fear.time--;

		if (this.debuff_fear.time == 0)
		{
			this.DebuffEnd_Fear();
		}
	}

	if (this.debuff_hyper.time > 0)
	{
		this.debuff_hyper.time--;

		if (this.debuff_hyper.time == 0)
		{
			this.DebuffEnd_Hyper();
		}
	}

	if (this.debuff_animal.time > 0)
	{
		this.debuff_animal.time--;

		if (this.debuff_animal.time == 0)
		{
			this.DebuffEnd_Animal();
		}
	}

	if (this.debuff_poison.time > 0)
	{
		this.debuff_poison.time--;

		if (this.team.life > 0 && this.debuff_poison.time % 40 == 39 && ::battle.state == 8)
		{
			if (this.team.life > 50)
			{
				this.team.life -= 50;
			}
			else
			{
				this.team.life = 1;
			}
		}

		if (this.debuff_poison.time == 0)
		{
			this.DebuffEnd_Poison();
		}
	}
}

function BuffReset()
{
	this.DebuffEnd_Hate();
	this.DebuffEnd_Hyper();
	this.DebuffEnd_Fear();

	if (this.debuff_animal.time > 0)
	{
		this.SetEffect(this.x, this.y, this.direction, this.EF_DebuffAnimal, {});
	}

	this.DebuffEnd_Animal();
	this.DebuffEnd_Poison();
}

function AtkBuffAdd( type_, rate_, time_, func_ )
{
	local t_ = {};
	t_.type <- type_;
	t_.rate <- rate_;
	t_.time <- time_;
	t_.func <- func_;
	this.atkBuff.append(t_);
	this.AtkBuffSet();
}

function AtkBuffDel( type_ )
{
	foreach( val, a in this.atkBuff )
	{
		if (a.type == type_)
		{
			this.atkBuff.remove(val);
		}
	}

	this.AtkBuffSet();
}

function AtkBuffSet()
{
	this.atkRate = 1,00000000.0;

	for( local i = 0; i < this.atkBuff.len(); i++ )
	{
		this.atkRate *= this.atkBuff[i].rate;
	}
}

function DebuffFunc_Overlap()
{
	this.DebuffEnd_Hate();
	this.DebuffEnd_Hyper();
	this.DebuffEnd_Fear();
}

function DebuffSet_Hate( time_ )
{
	this.DebuffFunc_Overlap();
	this.debuff_hate.time = time_;
	local t_ = {};
	t_.owner <- this.owner;
	this.debuff_hate.object = this.SetEffect(this.x, this.y - 75, this.direction, this.EF_DebuffHate, t_).weakref();
}

function DebuffEnd_Hate()
{
	this.debuff_hate.time = 0;

	if (this.debuff_hate.object)
	{
		this.debuff_hate.object.Release();
	}

	this.debuff_hate.object = null;
}

function DebuffSet_Hyper( time_ )
{
	this.DebuffFunc_Overlap();
	this.debuff_hyper.time = time_;
	local t_ = {};
	t_.owner <- this.owner;
	this.debuff_hyper.object = this.SetEffect(this.x, this.y - 75, this.direction, this.EF_DebuffHyper, t_).weakref();
}

function DebuffEnd_Hyper()
{
	this.debuff_hyper.time = 0;

	if (this.debuff_hyper.object)
	{
		this.debuff_hyper.object.Release();
	}

	this.debuff_hyper.object = null;
}

function DebuffSet_Fear( time_ )
{
	this.DebuffFunc_Overlap();
	this.debuff_fear.time = time_;
	this.autoBaria = 1;
	local t_ = {};
	t_.owner <- this.owner;
	this.debuff_fear.object = this.SetEffect(this.x, this.y - 75, this.direction, this.EF_DebuffFear, t_).weakref();
}

function DebuffEnd_Fear()
{
	this.debuff_fear.time = 0;
	this.autoBaria = 0;

	if (this.debuff_fear.object)
	{
		this.debuff_fear.object.Release();
	}

	this.debuff_fear.object = null;
}

function DebuffSet_Animal( time_ )
{
	this.debuff_animal.time = time_;
	this.SetEffect(this.x, this.y, this.direction, this.EF_DebuffAnimal, {});
	local t_ = {};
	t_.direction <- this.direction;
	t_.atkRank <- 2;
	this.DamageAnimalBegin_Init.call(this, t_);
}

function DebuffEnd_Animal()
{
	this.debuff_animal.time = 0;
}

function DebuffSet_Poison( time_ )
{
	this.DebuffEnd_Poison();
	this.debuff_poison.time = time_;
}

function DebuffEnd_Poison()
{
	this.debuff_poison.time = 0;
}

