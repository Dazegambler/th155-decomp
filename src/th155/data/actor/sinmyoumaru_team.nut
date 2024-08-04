function Team_Change_AttackB( t_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.cpuState = null;
	this.SetMotion(3913, 0);
	this.PlaySE(3478);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
	this.keyAction = [
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
			this.PlaySE(3416);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,10000000.0);

		if (this.count == 8)
		{
			this.SetMotion(3913, 1);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
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
		local v_ = this.va.y - 5,00000000.0;
		v_ = this.Math_MinMax(v_, -8,00000000.0, -2,00000000.0);
		this.SetSpeed_XY(15,00000000.0 * this.direction, v_);
	}
	else
	{
		this.centerStop = 2;
		local v_ = this.va.y + 5,00000000.0;
		v_ = this.Math_MinMax(v_, 2,00000000.0, 8,00000000.0);
		this.SetSpeed_XY(15,00000000.0 * this.direction, 4,00000000.0);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(3404);
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
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,50000000.0, null);
		this.VX_Brake(0,50000000.0, 4,00000000.0 * this.direction);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.GetFront();
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
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
	this.flag1 = this.Vector3();
	this.flag1.x = 100,00000000.0;
	this.flag2 = 0;
	this.flag3 = 0;
	this.subState = function ()
	{
		this.CenterUpdate(0,15000001.0, 3,00000000.0);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0, -2,00000000.0 * this.direction);
		}
		else
		{
			this.VX_Brake(0,15000001.0, -2,00000000.0 * this.direction);
		}
	};

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3920, 0);
		this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.VX_Brake(0,15000001.0, -2,00000000.0 * this.direction);
		};
	}
	else
	{
		this.SetMotion(3921, 0);
		this.SetSpeed_XY(-8,00000000.0 * this.direction, this.y < this.centerY ? -3,00000000.0 : 3,00000000.0);
		this.stateLabel = function ()
		{
			this.CenterUpdate(0,15000001.0, 3,00000000.0);
			this.VX_Brake(0,15000001.0, -2,00000000.0 * this.direction);
		};
	}

	this.keyAction = [
		function ()
		{
			this.count = 0;

			if (this.target)
			{
				this.team.AddMP(-200, 90);
				this.flag2 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag2 = this.Math_MinMax(this.flag2, -50 * 0,01745329.0, 50 * 0,01745329.0);
			}

			this.PlaySE(3430);
			this.stateLabel = function ()
			{
				this.subState();
				this.flag3++;

				if (this.count == 15)
				{
					this.PlaySE(3430);
				}

				if (this.flag3 == 3)
				{
					this.hitResult = 1;
				}

				if (this.flag3 <= 27)
				{
					if (this.count % 2 == 1)
					{
						local t_ = {};
						t_.rot <- this.flag2;
						t_.v <- 10,00000000.0;
						this.SetShot(this.x + this.flag1.x * this.direction, this.y + this.flag1.y, this.direction, this.Shot_Change, t_);
						this.flag1.RotateByRadian(-0,69813168.0);
					}
				}
			};
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0, -2,00000000.0 * this.direction);
				}
				else
				{
					this.VX_Brake(0,15000001.0, -2,00000000.0 * this.direction);
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
		this.flag2 = -30 * 0,01745329.0;
	}

	if (ky_ > 0)
	{
		this.flag2 = 30 * 0,01745329.0;
	}

	this.keyAction = [
		function ()
		{
			if (this.target)
			{
				this.flag1 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag1 = this.Math_MinMax(this.flag1, -45 * 0,01745329.0, 45 * 0,01745329.0);
			}

			this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
			this.hitResult = 1;
			this.PlaySE(1126);
			local t_ = {};
			t_.rot <- this.flag1 + this.flag2;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChangeFin, t_);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.CenterUpdate(0,10000000.0, 2,00000000.0);
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
		this.Vec_Brake(0,25000000.0);
	};
}

function Team_Change_SpellB( t )
{
	this.Spell_A_Init(t);
	this.keyAction[0] = function ()
	{
		this.UseChangeSpellCard(60, -this.team.sp);
	};
	return true;
}

