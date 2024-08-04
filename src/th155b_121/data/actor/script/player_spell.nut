function Load_SpellCardData( name_ )
{
	::manbow.LoadCSVtoArray("data/spell/" + name_ + ".csv", this.spellList);
}

function Set_SpellCardData( type_ )
{
	if (this.spellList && this.spellList.len() > 0)
	{
		local t_ = this.spellList[type_];
		this.team.sp_max = t_.sp;
	}
	else
	{
	}
}

function Set_SlaveCardData( type_ )
{
	if (this.spellList && this.spellList.len() > 0)
	{
		local t_ = this.spellList[type_];
		this.team.sp_max2 = this.team.sp_max + t_.sp;
	}
	else
	{
	}
}

function CallSpellCard( time_, type_ = 0 )
{
	local t_ = this.spellList[type_];
	this.EndSpellCard();

	if (time_ > 0)
	{
		this.SetTimeStop(time_);
	}

	this.team.spell_active = true;
	this.team.spell_time = 9999;
	this.team.spell_use_count = 0;
	this.team.master.spellcard.Activate(this.spellList[this.spellcard.id].name);

	if (this.team.sp >= this.team.sp_max2 && this.team.slave && this.team.slave.type != 19 && !this.team.slave_ban)
	{
		this.PlaySE(827);
		this.SetEffect(0, 0, 1,00000000.0, this.Call_Delay, {}, this.weakref());

		if (this.team.index == 0)
		{
			this.SetFreeObjectStencil(-1480, 360 + 444, 1,00000000.0, this.SpellFace, {}, this.weakref());

			if (this.team.slave)
			{
				this.team.slave.SetFreeObjectStencil(1280 + 1480, 360 - 444, -1,00000000.0, this.SpellFace_Slave, {}, this.weakref());
			}
		}
		else
		{
			this.SetFreeObjectStencil(1280 + 1480, 360 + 444, -1,00000000.0, this.SpellFace, {}, this.weakref());

			if (this.team.slave)
			{
				this.team.slave.SetFreeObjectStencil(-1480, 360 - 444, 1,00000000.0, this.SpellFace_Slave, {}, this.weakref());
			}
		}
	}
	else
	{
		this.PlaySE(826);
		this.SetFreeObjectStencil(this.team.index == 0 ? -1480 : 1280 + 1480, 360 + 442, this.team.index == 0 ? 1,00000000.0 : -1,00000000.0, this.SpellFace, {}, this.weakref());
	}
}

function Call_Delay( t )
{
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 30)
		{
			if (this.initTable.pare.team.slave)
			{
				this.initTable.pare.team.slave.spellcard.Activate(this.initTable.pare.team.slave.spellList[this.initTable.pare.team.slave.spellcard.id].name);
			}

			this.Release();
		}
	};
}

function EndSpellCard()
{
	if (!this.team.spell_active || this.team.spell_time < 0)
	{
		return;
	}

	this.SetSpellBack(false);
	this.team.spell_time = 0;
	this.team.master.spellcard.Deactivate();

	if (this.team.slave)
	{
		this.team.slave.spellcard.Deactivate();
	}

	if (this.spellEndFunc)
	{
		this.spellEndFunc();
		this.spellEndFunc = null;
	}

	this.team.spell_active = false;

	if (this.team.spell_use_count <= 1)
	{
		this.team.spell_use_count++;
		this.team.sp -= this.team.sp_max;

		if (this.team.sp < 0)
		{
			this.team.sp = 0;
		}

		this.team.spell_time = 0;
	}
	else
	{
		this.team.sp = 0;
	}
}

function UseSpellCard( time_, sp_ )
{
	this.SetTimeStop(time_);

	if (this.team.spell_use_count < 0)
	{
		this.team.sp -= this.team.sp_max;

		if (this.team.sp < 0)
		{
			this.team.sp = 0;
		}
	}

	if (this.team.spell_use_count >= 0)
	{
		this.team.spell_time = 1;
		this.team.spell_use_count++;
	}

	this.PlaySE(820);
	this.SetSpellBack(true);
	this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_SpellFlash, {});

	if (this.team.index == 0)
	{
		this.SetFreeObject(640 + 640, 720, 1,00000000.0, this.SpellUseFace, {});
	}
	else
	{
		this.SetFreeObject(640 - 640, 720, -1,00000000.0, this.SpellUseFace, {});
	}
}

function UseChangeSpellCard( time_, sp_ )
{
	this.SetTimeStop(time_);
	::trophy.ChangeSpell(this.team.index);
	this.team.spell_time = 1;
	this.team.spell_use_count++;
	this.PlaySE(821);
	this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_SpellFlash, {});
}

function UseClimaxSpell( time_, name_ )
{
	this.PlaySE(824);
	this.atkRate_Pat = 0,60000002.0 + 0,40000001.0 * ((this.team.sp - 1000) / 2000,00000000.0);
	this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_ClimaxFlash, {});
	this.SetTimeStop(time_);
	this.lastword.Activate(name_);
	this.team.AddOP(-2000, 60);
	this.team.sp = 0;
	this.EndSpellCard();
}

