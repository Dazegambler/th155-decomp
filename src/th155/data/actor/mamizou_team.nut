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
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
			this.PlaySE(2615);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.10000000);

		if (this.count == 8)
		{
			this.SetMotion(3913, 1);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
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
	this.SetMotion(3914, 0);
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
			this.PlaySE(2602);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.GetFront();
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
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

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3920, 0);
		this.SetSpeed_XY(-8.00000000 * this.direction, 0.00000000);
		this.stateLabel = function ()
		{
			this.VX_Brake(0.15000001, -2.00000000 * this.direction);
		};
	}
	else
	{
		this.SetMotion(3921, 0);
		this.SetSpeed_XY(-8.00000000 * this.direction, this.y < this.centerY ? -3.00000000 : 3.00000000);
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.15000001, 3.00000000);
			this.VX_Brake(0.15000001, -2.00000000 * this.direction);
		};
	}

	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 0;
	this.subState = function ()
	{
		this.CenterUpdate(0.15000001, 3.00000000);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000, -3.00000000 * this.direction);
		}
		else
		{
			this.VX_Brake(0.15000001, -3.00000000 * this.direction);
		}
	};
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 90);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			}
			else
			{
				this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			}

			local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			r_ = this.Math_MinMax(r_, -0.87266457, 0.87266457);
			this.count = 0;
			local t_ = {};
			t_.v <- 0.10000000;
			t_.rot <- r_;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
			local t_ = {};
			t_.v <- 0.20000000;
			t_.rot <- r_;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
			local t_ = {};
			t_.v <- 0.30000001;
			t_.rot <- r_;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
			local t_ = {};
			t_.rot <- -1.57079601 + r_;
			t_.rot2 <- r_;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change_Core, t_);
			local t_ = {};
			t_.rot <- 1.57079601 + r_;
			t_.rot2 <- r_;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change_Core, t_);
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
				else
				{
					this.VX_Brake(0.15000001, -1.00000000 * this.direction);
				}
			};
		}
	];
}

function Team_Change_ShotFin( t )
{
	local v_ = this.Vector3();
	v_.x = this.va.x;
	v_.y = this.va.y;
	this.Team_Change_Common();
	this.team.current.Warp(this.x, this.y);
	this.team.current.Team_Change_ShotFinB(v_);
}

function Team_Change_ShotFinB( va_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.SetSpeed_XY(va_.x, va_.y);
	this.SetMotion(3930, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = this.centerStop * this.centerStop >= 4 && this.y > this.centerY;
	this.keyAction = [
		function ()
		{
			if (this.target)
			{
				this.flag1 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag1 = this.Math_MinMax(this.flag1, -25 * 0.01745329, 25 * 0.01745329);
			}

			if (this.flag2)
			{
				this.centerStop = 3;
				this.SetSpeed_XY(-19.50000000 * this.direction, 3.00000000);
			}
			else
			{
				this.centerStop = -3;
				this.SetSpeed_XY(-19.50000000 * this.direction, -6.00000000);
			}

			this.hitResult = 1;
			this.PlaySE(1295);
			local t_ = {};
			t_.rot <- this.flag1;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChangeFin_Core, t_);
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(0.75000000, 5.00000000))
				{
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.50000000, null);

						if (this.centerStop == 0)
						{
							this.VX_Brake(0.50000000);
						}
					};
				}
			};
		},
		null,
		null,
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

function Team_Change_SpellB( t )
{
	this.Spell_B_Init(t);
	this.keyAction[0] = function ()
	{
		this.count = 0;
		this.UseChangeSpellCard(60, -this.team.sp);
		this.SetSpeed_XY(-7.00000000 * this.direction, -15.00000000);
		this.centerStop = -2;
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0.00000000, 0.50000000);
		};
	};
	return true;
}

