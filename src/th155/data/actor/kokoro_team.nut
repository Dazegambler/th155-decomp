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
				this.VX_Brake(0.50000000);
			};
		},
		function ()
		{
			this.PlaySE(2998);
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
			this.PlaySE(2802);
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
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.50000000, null);
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
	this.count = 0;
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

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3920, 0);
		this.SetSpeed_XY(-3.00000000 * this.direction, 0.00000000);
		this.stateLabel = function ()
		{
			this.VX_Brake(0.15000001);
		};
	}
	else
	{
		this.SetMotion(3921, 0);
		this.SetSpeed_XY(-3.00000000 * this.direction, this.y < this.centerY ? -3.00000000 : 3.00000000);
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.15000001, 3.00000000);
			this.VX_Brake(0.15000001);
		};
	}

	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.count = 0;
			this.team.AddMP(-200, 90);
			this.PlaySE(2921);
			this.count = 0;
			this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change_MaskCore, {}).weakref();
			this.ChangeEmotion(-1);
			this.lavelClearEvent = function ()
			{
				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
				}
			};
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.15000001, 3.00000000);
				this.VX_Brake(0.15000001);

				if (this.count >= 30)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.05000000);
						this.CenterUpdate(0.10000000, 5.00000000);

						if (this.subState)
						{
							this.subState();
						}
					};
				}
			};
		},
		null,
		function ()
		{
			this.PlaySE(2922);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			}
			else
			{
				this.SetSpeed_XY(-10.00000000 * this.direction, this.y < this.centerY ? -3.00000000 : 3.00000000);
			}

			if (this.flag2)
			{
				this.flag2.func[1].call(this.flag2);
			}

			this.lavelClearEvent = null;
			this.flag2 = null;
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000, -2.00000000 * this.direction);
				}
				else
				{
					this.VX_Brake(0.15000001, -2.00000000 * this.direction);
				}
			};
		}
	];
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
		function ()
		{
			if (this.target)
			{
				this.flag1 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag1 = this.Math_MinMax(this.flag1, -45 * 0.01745329, 45 * 0.01745329);
			}

			this.SetSpeed_XY(-15.00000000 * this.direction, 0.00000000);
			this.hitResult = 1;
			this.PlaySE(1126);
			local t_ = {};
			t_.rot <- this.flag1 + this.flag2;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChangeFin, t_);
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
	this.Spell_C_Init(t);
	this.keyAction[0] = function ()
	{
		this.UseChangeSpellCard(60, -this.team.sp);
	};
	return true;
}

