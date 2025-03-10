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
			this.PlaySE(4072);
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
	this.flag1 = ::manbow.Actor2DProcGroup();
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
			this.PlaySE(4074);

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				t_.rot <- i * 45;
				this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Mukon_AirAtk, t_));
			}

			this.lavelClearEvent = function ()
			{
				this.flag1.Foreach(function ()
				{
					this.func[0].call(this);
				});
			};
		},
		function ()
		{
			if (this.lavelClearEvent)
			{
				this.lavelClearEvent();
			}

			this.lavelClearEvent = null;
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
		null,
		this.EndtoFreeMove,
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.50000000, null);
		this.VX_Brake(0.50000000, 4.00000000 * this.direction);

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
}

function Team_Change_ShotB( va_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 0;
	this.flag3 = -1.57079601;
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

	this.keyAction = [
		function ()
		{
			this.count = 0;

			if (this.target)
			{
				this.team.AddMP(-200, 90);
				this.flag1 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag1 = this.Math_MinMax(this.flag1, -30 * 0.01745329, 30 * 0.01745329);
			}

			this.stateLabel = function ()
			{
				this.subState();

				if (this.flag2 <= 10 && this.count % 4 == 1)
				{
					this.flag2++;
					this.hitResult = 1;
					local r_ = 25 * 0.01745329 * this.sin(this.flag3 * 0.01745329);
					this.PlaySE(4026);
					local t_ = {};
					t_.rot <- -0.78539813;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
					this.flag3 += 0.15707962;
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
			this.PlaySE(4024);
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

function Team_Change_Skill_FrontB( t, v_ )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(v_.x * 0.50000000, v_.y * 0.50000000);
	this.AjustCenterStop();
	this.SetMotion(3950, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1100);
			this.hitResult = 1;

			for( local i = 0; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- (-6.00000000 + 4.00000000 * i) * 0.01745329;
				t_.take <- 0;
				this.SetShot(this.point0_x + (i * 20 - 50) * this.cos(t_.rot + 3.14159203 * 0.50000000) * this.direction, this.point0_y + (20 * i - 50) * this.sin(t_.rot + 3.14159203 * 0.50000000), this.direction, this.SPShot_A, t_);
			}
		},
		null,
		function ()
		{
			this.stateLabel = null;
		},
		function ()
		{
			this.Team_Change_ChangeSkillEnd(null);
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.25000000, 2.00000000);
		this.VX_Brake(0.25000000);
	};
	return true;
}

function Team_Change_SpellB( t )
{
	this.Spell_C_Init(t);
	this.keyAction[0] = function ()
	{
		this.count = 0;
		this.UseChangeSpellCard(60, -this.team.sp);
		this.flag1.x = this.va.x;
		this.flag1.y = this.va.y;
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.stateLabel = function ()
		{
		};
	};
	return true;
}

