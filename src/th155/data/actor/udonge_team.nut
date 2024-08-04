function Team_Change_AttackB( t_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.cpuState = null;
	this.SetMotion(3913, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3900);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
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
			this.PlaySE(3906);
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
		this.CenterUpdate(0,40000001.0, null);
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

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3920, 0);
		this.SetSpeed_XY(-8,00000000.0 * this.direction, 0,00000000.0);
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

	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 7;
	this.flag3 = 11,00000000.0;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(3902);
			this.team.AddMP(-200, 90);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 3,00000000.0);
				this.VX_Brake(0,15000001.0, -2,00000000.0 * this.direction);

				if (this.count % 2 == 1 && this.flag2 > 0)
				{
					if (this.target)
					{
						this.flag1 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
						this.flag1 = this.Math_MinMax(this.flag1, -35 * 0,01745329.0, 35 * 0,01745329.0);
					}

					this.flag2--;

					if (this.flag2 <= 0)
					{
						this.hitResult = 1;
					}

					local t_ = {};
					t_.rot <- this.flag1;
					t_.san <- this.san_mode;
					t_.v <- this.flag3;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
					this.flag3 -= 0,75000000.0;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 3,00000000.0);
				this.VX_Brake(0,15000001.0);
			};
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,15000001.0);
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

function Team_Change_Skill_FrontB( t, v_ )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(v_.x * 0,50000000.0, v_.y * 0,50000000.0);
	this.AjustCenterStop();

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3950, 0);
		this.stateLabel = function ()
		{
			this.VX_Brake(1,00000000.0);

			if (this.count == 12)
			{
				this.SetSpeed_XY(8,00000000.0 * this.direction, null);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		};
		this.keyAction = [
			function ()
			{
				this.hitResult = 1;
				this.PlaySE(3847);
				this.team.AddMP(-200, 120);
				local t_ = {};
				t_.v <- this.Vector3();
				t_.v.x = 17,00000000.0;
				t_.v.y = -17,00000000.0;
				t_.type <- 0;
				this.box = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_, null).weakref();
				this.count = 0;
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);

					if (this.box && this.count >= 10 && (this.command.rsv_k3 > 0 || this.input.b3 > 0))
					{
						this.Team_Change_Skill_FrontB_2(null);
						return;
					}
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);

					if (this.box && this.count >= 5 && (this.command.rsv_k3 > 0 || this.input.b3 > 0))
					{
						this.Team_Change_Skill_FrontB_2(null);
						return;
					}
				};
			},
			function ()
			{
				this.Team_Change_ChangeSkillEnd(null);
			}
		];
	}
	else
	{
		this.SetMotion(3951, 0);
		this.stateLabel = function ()
		{
			this.CenterUpdate(0,25000000.0, 2,00000000.0);
			this.VX_Brake(0,05000000.0);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.VX_Brake(0,75000000.0);
			}
		};
		this.keyAction = [
			function ()
			{
				this.PlaySE(3847);
				this.team.AddMP(-200, 120);
				local t_ = {};
				t_.v <- this.Vector3();

				if (this.y < this.centerY)
				{
					t_.v.x = 17,00000000.0;
					t_.v.y = -12,50000000.0;
					t_.type <- 2;

					if (this.va.y < 0)
					{
						t_.v.y = -12,50000000.0;
					}
				}
				else
				{
					t_.v.x = 17,00000000.0;
					t_.v.y = -17,00000000.0;
					t_.type <- 0;
				}

				this.box = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_, null).weakref();
				this.count = 0;
				this.stateLabel = function ()
				{
					this.CenterUpdate(0,25000000.0, 2,00000000.0);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.VX_Brake(0,75000000.0);
					}

					if (this.box && this.count >= 15 && this.count <= 30 && (this.command.rsv_k3 > 0 || this.input.b3 > 0))
					{
						this.Team_Change_Skill_FrontB_2(null);
						return;
					}
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						this.VX_Brake(0,75000000.0);
					}

					if (this.box && this.count >= 5 && (this.command.rsv_k3 > 0 || this.input.b3 > 0))
					{
						this.Team_Change_Skill_FrontB_2(null);
						return;
					}
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						this.VX_Brake(0,75000000.0);
					}

					if (this.box && this.count >= 15 && (this.command.rsv_k3 > 0 || this.input.b3 > 0))
					{
						this.Team_Change_Skill_FrontB_2(null);
						return;
					}
				};
			},
			function ()
			{
				this.Team_Change_ChangeSkillEnd(null);
			}
		];
	}

	return true;
}

function Team_Change_Skill_FrontB_2( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.hitResult = 1;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

	if (this.box)
	{
		local pos_ = this.Vector3();
		pos_.x = this.box.x - this.x;
		pos_.y = this.box.y - this.y;
		pos_.Normalize();

		if ((this.box.x - this.x) * this.direction < 0)
		{
			this.direction = -this.direction;
		}

		if (this.fabs(pos_.y) <= 0,50000000.0)
		{
			this.SetMotion(3953, 0);
		}
		else if (pos_.y < 0)
		{
			this.SetMotion(3952, 0);
		}
		else
		{
			this.SetMotion(3954, 0);
		}
	}
	else
	{
		this.SetMotion(3953, 0);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(3850);
			local t_ = {};
			t_.rot <- 0,00000000.0;

			if (this.motion == 3954)
			{
				t_.rot = 45 * 0,01745329.0;
			}

			if (this.motion == 3952)
			{
				t_.rot = -45 * 0,01745329.0;
			}

			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C_Bullet, t_);
		},
		null,
		function ()
		{
			this.Team_Change_ChangeSkillEnd(null);
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1,00000000.0);
	};
	return true;
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

