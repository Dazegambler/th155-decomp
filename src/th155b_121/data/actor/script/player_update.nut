function CommonUpdateGuage()
{
}

function MainLoopFirst()
{
	this.targetDist = this.target.x - this.x;
	this.targetHeight = this.target.y - this.y;

	if (this.colorFunction)
	{
		this.colorFunction.call(this);
	}

	if (this.spellBackTime > 0)
	{
		this.spellBackTime--;
	}

	if (this.disableDash > 0)
	{
		this.disableDash--;
	}

	if (this.autoGuardCount > 0)
	{
		this.autoGuardCount--;
	}

	if (this.forceBariaCount > 0)
	{
		this.forceBariaCount--;
	}

	if (this.disableGuard > 0)
	{
		this.disableGuard--;
	}

	this.team_update.call(this.team);

	if (this.IsGuard() == 3)
	{
		if (this.input.x * this.direction <= 0,00000000.0 && this.input.y == 0 && this.input.b4 == 1 || this.autoBaria == 1 || this.autoBaria == 2)
		{
			local t_ = {};
			t_.atkRank <- this.flag1;
			t_.atk <- this.flag2;
			this.BariaGuard_Input(t_);
		}
	}

	if (this.damageStopTime > 0)
	{
		this.damageStopTime--;
		this.hitStopTime = 0;
		return false;
	}

	if (this.hitStopTime > 0)
	{
		this.hitStopTime--;
		return false;
	}

	return true;
}

function MainLoop()
{
	this.wall = this.IsWall(0,00000000.0);
	this.ground = this.IsGround(this.vy);

	if (this.IsFree())
	{
		this.hitBackFlag = 0,00000000.0;
	}

	if (!this.freeMap && this.wall && this.hitStopTime <= 0 && this.damageStopTime <= 0)
	{
		if (this.wall * this.vfBaria.x >= 1,00000000.0 && this.bariaBackFlag > 0,00000000.0)
		{
			if (this.abs(this.target.vfBaria.x) < this.abs(this.vfBaria.x))
			{
				this.target.vfBaria.x = -this.vfBaria.x;
				this.vfBaria.x = 0;
			}

			this.bariaBackFlag = 0;
		}

		if (this.hitBackFlag > 0,00000000.0 && this.hitBackFlag <= 1,00000000.0)
		{
			if (this.damageTarget && this.damageTarget.owner)
			{
				if (this.damageTarget.owner.actorType == 1)
				{
					if (this.abs(this.damageTarget.owner.vf.x) < this.abs(this.va.x * this.hitBackFlag))
					{
						this.damageTarget.owner.vf.x = -this.va.x * this.hitBackFlag;
					}
				}
			}

			this.hitBackFlag = 0;
		}
	}

	this.MainLoopCount();

	if (this.afterImage)
	{
		this.afterImage.Update();
	}

	if (this.occultAura)
	{
		this.occultAura[0].Update();
		this.occultAura[1].call(this);
	}

	if (this.stateLabel)
	{
		this.stateLabel.call(this);
	}

	if (this.y == this.centerY)
	{
		this.centerStopCheck = 0;
	}
	else
	{
		this.centerStopCheck = this.y < this.centerY ? -1 : 1;
	}

	return true;
}

function MainLoopCount()
{
	this.count++;

	if (this.recover > 0)
	{
		this.recover--;
	}

	if (this.invinObject > 0)
	{
		this.invinObject--;
	}

	if (this.invin > 0)
	{
		this.invin--;
	}

	if (this.invinBoss > 0)
	{
		if (this.invinBoss > 30 && !this.IsDamage() && !this.IsRecover())
		{
			this.invinBoss = 30;
		}

		this.invinBoss--;
	}

	if (this.invinGrab > 0)
	{
		this.invinGrab--;
	}

	if (this.graze > 0)
	{
		this.graze--;
	}

	if (this.vx_slow > 0)
	{
		this.vx_slow--;
	}

	if (this.armor > 0)
	{
		this.armor--;
	}

	if (this.stanBossCount > 0)
	{
		this.stanBossCount--;
	}

	if (this.shotGuardCount > 0)
	{
		this.shotGuardCount--;

		if (this.shotGuardCount == 0)
		{
			this.shotGuardRate = 1,00000000.0;
		}
	}

	if (this.team.current == this)
	{
		if (this.team.kaiki_scale != 1,00000000.0 && this.IsFree())
		{
			this.team.kaiki_scale = 1,00000000.0;
		}

		if (this.team.combo_reset_count > 0 && this.g_timeStop[0] == 0 && this.g_timeStop[1] == 0)
		{
			this.team.combo_reset_count--;

			if (this.team.combo_reset_count <= 0)
			{
				this.team.combo_reset_count = 0;

				if (!this.IsDamage())
				{
					this.team.ResetCombo();
				}
			}
		}
	}

	this.BuffLoop();
	this.DebuffLoop();

	if (!(this.flagState & 16777216))
	{
		if (this.IsDamage() || this.IsGuard())
		{
			this.CenterUpdate(0,50000000.0, this.baseSlideSpeed);
		}
		else
		{
			this.CenterUpdate(this.baseGravity, this.baseSlideSpeed);
		}
	}

	if (!this.IsDamage())
	{
		this.endureCount--;

		if (this.endureCount < 0)
		{
			this.endure = 0;
			this.endureCount = 0;
		}
	}
}

function CenterUpdate( g_, max_ )
{
	if (this.y > this.centerY)
	{
		if (this.centerStop == 0)
		{
			this.centerStop = 2;
		}

		if (this.va.y < 0)
		{
			this.va.y -= this.centerStop * this.centerStop <= 1 ? 0,50000000.0 : g_;

			if (max_ != null)
			{
				if (this.va.y < -max_)
				{
					this.va.y = -max_;
				}
			}
		}
		else
		{
			this.va.y -= this.centerStop * this.centerStop <= 1 ? 0,50000000.0 : g_;
		}
	}
	else if (this.y < this.centerY)
	{
		if (this.centerStop == 0)
		{
			this.centerStop = -2;
		}

		if (this.va.y > 0)
		{
			this.va.y += this.centerStop * this.centerStop <= 1 ? 0,50000000.0 : g_;

			if (max_ != null)
			{
				if (this.va.y > max_)
				{
					this.va.y = max_;
				}
			}
		}
		else
		{
			this.va.y += this.centerStop * this.centerStop <= 1 ? 0,50000000.0 : g_;
		}
	}

	if (this.centerStop == -3 && this.va.y >= 0,00000000.0)
	{
		this.centerStop = -2;
	}

	if (this.centerStop == 3 && this.va.y <= 0,00000000.0)
	{
		this.centerStop = 2;
	}

	if (this.airSlide)
	{
		if (this.centerStop == -3 && this.y <= this.centerY || this.centerStop == 3 && this.y >= this.centerY)
		{
			this.airSlide = false;
		}
	}

	if (this.centerStop * this.centerStop == 1)
	{
		if ((this.centerY - this.y) * (this.centerY - this.y) <= this.va.y * this.va.y && (this.centerY - this.y) * this.va.y >= 0,00000000.0)
		{
			this.SetSpeed_XY(this.va.x, 0,00000000.0);
			this.centerStop = 0;
			this.y = this.centerY;
		}
	}
	else if (this.centerStop * this.centerStop == 4)
	{
		if (this.y + this.va.y <= this.centerY && this.centerStopCheck >= 0 || this.y + this.va.y >= this.centerY && this.centerStopCheck <= 0)
		{
			if (this.centerStop == -2)
			{
				this.centerStop = 1;
			}
			else
			{
				this.centerStop = -1;
			}

			if (this.va.y < -3,00000000.0)
			{
				this.SetSpeed_XY(null, -3,00000000.0);
			}

			if (this.va.y > 3,00000000.0)
			{
				this.SetSpeed_XY(null, 3,00000000.0);
			}

			this.Warp(this.x, this.centerY);
		}
	}

	if (this.centerStop * this.centerStop <= 1)
	{
		this.dashCount = 0;
		this.slideCount = 0;
		this.airSlide = false;
	}

	this.ConvertTotalSpeed();
}

function CommonColorUpdate()
{
	if (this == this.team.slave && this.IsGuard())
	{
		if (this.team.op <= 100)
		{
			if (this.g_count % 6 <= 2)
			{
				this.alpha = this.masterAlpha;
				this.red = 1,00000000.0;
				this.blue = 0,00000000.0;
				this.green = 0,00000000.0;
			}
			else
			{
				this.alpha = this.masterAlpha;
				this.red = 1,00000000.0;
				this.blue = 0,50000000.0;
				this.green = 0,50000000.0;
			}
		}
		else if (this.team.op <= 200)
		{
			if (this.g_count % 6 <= 2)
			{
				this.alpha = this.masterAlpha;
				this.red = 1,00000000.0;
				this.blue = 0,69999999.0;
				this.green = 0,69999999.0;
			}
			else
			{
				this.alpha = this.masterAlpha;
				this.red = 1,00000000.0;
				this.blue = 0,89999998.0;
				this.green = 0,89999998.0;
			}
		}
		else
		{
			this.alpha = this.masterAlpha;
			this.red = this.masterRed;
			this.green = this.masterGreen;
			this.blue = this.masterBlue;
		}
	}
	else
	{
		this.alpha = this.masterAlpha;
		this.red = this.masterRed;
		this.green = this.masterGreen;
		this.blue = this.masterBlue;
	}

	if (this.debuff_poison.time > 0)
	{
		this.green *= 0,50000000.0;
	}

	if (this.invinBoss > 0)
	{
		if (this.damageStopTime <= 0 && this.invinBoss % 8 <= 3)
		{
			this.alpha = 0,00000000.0;
		}
	}
}

