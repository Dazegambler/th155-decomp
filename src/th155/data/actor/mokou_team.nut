function Team_Change_AttackB( t_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.cpuState = null;
	this.SetMotion(3913, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
	this.keyAction = [
		null,
		function ()
		{
			if (this.occultCount)
			{
				this.SetMotion(this.motion, 3);
			}

			this.PlaySE(3298);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.10000000);

		if (this.count == 8)
		{
			this.SetMotion(3913, 1);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
}

function Team_Change_Attack_AirB( t_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.cpuState = null;

	if (this.occultCount)
	{
		this.SetMotion(3915, 0);
	}
	else
	{
		this.SetMotion(3914, 0);
	}

	this.AjustCenterStop();
	this.count = 0;

	if (this.y < this.centerY)
	{
		this.centerStop = -2;
		local v_ = this.va.y - 5.00000000;
		v_ = this.Math_MinMax(v_, -8.00000000, -2.00000000);
		this.SetSpeed_XY(15.00000000 * this.direction, v_);
	}
	else
	{
		this.centerStop = 2;
		local v_ = this.va.y + 5.00000000;
		v_ = this.Math_MinMax(v_, 2.00000000, 8.00000000);
		this.SetSpeed_XY(15.00000000 * this.direction, 4.00000000);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(3300);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.GetFront();
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
		null,
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.40000001, null);
		this.VX_Brake(0.50000000, 4.00000000 * this.direction);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.GetFront();
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	};
}

function Team_Change_ShotB( va_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();

	if (this.occultCount)
	{
		this.SetMotion(3921, 0);
	}
	else
	{
		this.SetMotion(3920, 0);
	}

	this.count = 0;
	this.flag1 = 0;
	this.subState = function ()
	{
		this.CenterUpdate(0.15000001, 3.00000000);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000, -2.00000000 * this.direction);
		}
		else
		{
			this.VX_Brake(0.15000001, -2.00000000 * this.direction);
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.hitResult = 1;
			this.count = 0;

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			}
			else
			{
				this.SetSpeed_XY(-10.00000000 * this.direction, this.y < this.centerY ? -3.00000000 : 3.00000000);
			}

			if (this.target)
			{
				this.flag1 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag1 = this.Math_MinMax(this.flag1, -45 * 0.01745329, 45 * 0.01745329);
			}

			this.PlaySE(3302);

			for( local i = 1; i < 5; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag1 + 6.50000000 * i * 0.01745329;
				t_.v <- 13.00000000 - i * 0.50000000;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
			}

			for( local i = 1; i < 5; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag1 - 6.50000000 * i * 0.01745329;
				t_.v <- 13.00000000 - i * 0.50000000;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
			}

			for( local i = 0; i < 6; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag1;
				t_.v <- 14.00000000 - i * 1.50000000;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
			}

			this.stateLabel = function ()
			{
				this.subState();
			};
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
}

function Team_Change_ShotFin( t, ky_ )
{
	local v_ = this.Vector3();
	v_.x = this.va.x;
	v_.y = this.va.y;
	this.Team_Change_Common();
	this.team.current.Warp(this.x, this.y);
	this.team.current.Team_Change_ShotFinB(v_, ky_);
}

function Team_Change_ShotFinB( va_, ky_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.SetSpeed_XY(va_.x, va_.y);
	this.SetMotion(3930, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 0;

	if (ky_ < 0)
	{
		this.flag2 = -30 * 0.01745329;
	}

	if (ky_ > 0)
	{
		this.flag2 = 30 * 0.01745329;
	}

	this.keyAction = [
		null,
		function ()
		{
			if (this.target)
			{
				this.flag1 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag1 = this.Math_MinMax(this.flag1, -45 * 0.01745329, 45 * 0.01745329);
			}

			this.hitResult = 1;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
				this.CenterUpdate(0.10000000, 2.00000000);
			};
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
	};
}

function Team_Change_Skill_FrontB( t, v_ )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.SetMotion(3950, 0);
	this.keyAction = [
		function ()
		{
			this.Team_Change_Skill_Front_Fall(null);
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Team_Change_Skill_Front_Fall( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag1 = 0;
	this.team.AddMP(-200, 120);

	if (this.occultCount)
	{
		this.SetMotion(3951, 1);
	}
	else
	{
		this.SetMotion(3950, 1);
	}

	this.centerStop = 2;
	this.PlaySE(3250);
	this.SetSpeed_XY(12.50000000 * this.direction, 12.50000000);
	this.SetSelfDamage(200);
	this.hitCount = 0;
	local l_ = this.team.regain_life - this.team.life;

	if (l_ >= 2000)
	{
		this.SetMotion(this.motion, 5);
	}
	else if (l_ >= 1000)
	{
		this.SetMotion(this.motion, 3);
	}

	this.stateLabel = function ()
	{
		this.SetSelfDamage(10);

		if (this.hitCount < 4)
		{
			this.HitCycleUpdate(1);
		}

		local t_ = {};
		t_.occult <- this.occultCount;
		this.SetFreeObject(this.x + (48 - 40 + this.rand() % 80) * this.direction, this.y + 25 - 40 + this.rand() % 80, this.direction, this.SPShot_A2, t_);

		if (this.y > this.centerY + 150 && this.count >= 13 || this.y > this.centerY + 50 && this.hitCount >= 4 || this.ground)
		{
			if (this.ground)
			{
				this.SetSpeed_XY(null, 0.00000000);
			}

			this.Team_Change_Skill_Front_KickEnd();
		}
	};
}

function Team_Change_Skill_Front_KickEnd()
{
	this.LabelClear();
	this.count = 0;
	this.flag1 = 0;
	this.SetMotion(3952, 0);
	local pos_ = this.Vector3();
	this.GetPoint(0, pos_);
	this.SetFreeObject(pos_.x, pos_.y, this.direction, this.SPShot_A, {});
	this.SetSpeed_XY(6.00000000 * this.direction, 6.00000000);
	this.centerStop = 2;
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.Team_Change_ChangeSkillEnd(null);
		}
	];
}

function Team_Change_SpellB( t )
{
	this.Spell_A_Init(t);
	this.keyAction[0] = function ()
	{
		this.count = 0;
		this.UseChangeSpellCard(60, -this.team.sp);
		this.occultCount = 0;
		local rate_ = 1.00000000 + (this.team.regain_life - this.team.life) / 5000.00000000 * 0.60000002;

		if (rate_ < 1.00000000)
		{
			rate_ = 1.00000000;
		}

		if (rate_ > 1.60000002)
		{
			rate_ = 1.60000002;
		}

		this.atkRate_Pat *= rate_;
	};
	return true;
}

