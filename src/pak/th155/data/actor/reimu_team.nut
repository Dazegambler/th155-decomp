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
			this.PlaySE(1122);
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
			this.PlaySE(1128);
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
	this.flag1 = 0;
	this.flag2 = 0;
	this.flag3 = 0;
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

				if (this.count % 4 == 1)
				{
					this.flag2++;

					if (this.flag2 >= 5)
					{
						this.hitResult = 1;
					}

					if (this.flag3 == 0 || this.flag3 == 180)
					{
						this.PlaySE(1124);
						local t_ = {};
						t_.rot <- this.flag1;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
					}
					else
					{
						local r_ = 25 * 0.01745329 * this.sin(this.flag3 * 0.01745329);
						this.PlaySE(1124);
						local t_ = {};
						t_.rot <- this.flag1 + r_;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
						local t2_ = {};
						t2_.rot <- this.flag1 - r_;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t2_);
					}

					this.flag3 += 18;
				}

				if (this.count >= 30)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.subState();
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
	this.Spell_A_Init(t);
	this.keyAction[0] = function ()
	{
		this.count = 0;
		this.UseChangeSpellCard(60, -this.team.sp);
		this.PlaySE(1155);

		for( local i = 0; i < 8; i++ )
		{
			local t_ = {};
			t_.rot <- i * 45 * 0.01745329;
			t_.motion <- 4007 + i % 3;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SpellShot_A, t_);
		}

		this.flag5 = this.SetFreeObject(this.point2_x, this.point2_y, this.direction, this.SpellShot_A_Bou, {}).weakref();
		this.stateLabel = function ()
		{
		};
	};
	return true;
}

function Spell_Team_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4090, 0);
	this.count = 0;
	this.flag1 = 0;
	this.direction = t;
	this.SetSpeed_XY(-7.00000000 * this.direction, 0.00000000);
	this.masterAlpha = 0.00000000;
	this.AjustCenterStop();
	this.flag5 = null;
	this.stateLabel = function ()
	{
		this.masterAlpha += 0.05000000;

		if (this.masterAlpha > 1.00000000)
		{
			this.masterAlpha = 1.00000000;
		}

		this.VX_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				t_.rot <- i * 45 * 0.01745329;
				t_.motion <- 4097 + i % 3;
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Spell_Team_Shot_A, t_);
			}

			this.flag5 = this.SetFreeObject(this.point2_x, this.point2_y, this.direction, this.Spell_Team_Bou, {}).weakref();
			this.stateLabel = function ()
			{
				this.masterAlpha += 0.05000000;

				if (this.masterAlpha > 1.00000000)
				{
					this.masterAlpha = 1.00000000;
				}

				this.VX_Brake(0.50000000);
			};
		},
		function ()
		{
			this.count = 0;
			this.flag1 = 0;
			this.stateLabel = function ()
			{
				if (this.count % 10 == 1 && this.flag1 <= 6)
				{
					local t_ = {};
					t_.rot <- (-45 + this.flag1 * 30 % 110) * 0.01745329 * 2.00000000;
					t_.motion <- 4097 + this.flag1 % 3;
					t_.rate <- this.atkRate_Pat;
					this.PlaySE(1156);
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Spell_Team_Bullet, t_);
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Spell_Team_Flash, t_);
					local f_ = this.flag1 % 1;
					this.flag1++;
				}

				if (this.count >= 60)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
					};
					this.flag5.func();
					this.PlaySE(901);
					this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
					this.Team_Bench_In();
				}
			};
		},
		function ()
		{
			this.count = 0;
		},
		null,
		function ()
		{
		}
	];
	return true;
}

function Spell_Team_Shot_A( t )
{
	this.SetMotion(t.motion, 0);
	this.flag1 = {};
	this.flag2 = 20.00000000;
	this.flag1.range <- 20.00000000;
	this.flag1.rot <- t.rot;
	this.sx = this.sy = 0.00000000;
	this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
	this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);
	this.EnableTimeStop(false);
	this.subState = function ()
	{
		if (this.owner.motion == 4090)
		{
			if (this.owner.keyTake == 2)
			{
				this.stateLabel = function ()
				{
					this.sx = this.sy += 0.10000000;
					this.alpha -= 0.10000000;

					if (this.alpha <= 0.00000000)
					{
						this.ReleaseActor();
					}
				};
				return true;
			}

			this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
			this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);
		}
		else
		{
			this.ReleaseActor();
			return true;
		}
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.sx += 0.02500000;

		if (this.sx > 2.00000000)
		{
			this.sx = 2.00000000;
		}

		this.sy = this.sx;
		this.flag1.range += this.flag2;
		this.flag2 -= 2.00000000;

		if (this.flag2 < 2.00000000)
		{
			this.flag2 = 2.00000000;
			this.count++;
		}

		if (this.count >= 35)
		{
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.sy = this.sx *= 0.94999999;
				this.flag1.range *= 0.80000001;
				this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
				this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);
			};
		}

		this.flag1.rot -= 0.07500000;
	};
}

function Spell_Team_Bullet( t )
{
	this.SetMotion(t.motion, 1);
	this.target = this.owner.target.weakref();
	this.sx = this.sy = 0.50000000;
	this.SetSpeed_Vec(20.00000000, t.rot, this.direction);
	this.PlaySE(1156);
	this.cancelCount = 3;
	this.SetTrail(this.motion, 6, 20, 100);
	this.func = function ()
	{
		this.rz += 8.00000000 * 0.01745329;

		if (this.hitResult)
		{
			if (this.cancelCount <= 0 || this.hitCount >= 1)
			{
				local t_ = {};
				t_.motion <- this.motion;
				this.owner.Spell_Team_Hit.call(this, t_);
			}
			else
			{
				this.HitReset();
			}
		}
		else if (this.count >= 180 || this.IsScreen(300.00000000))
		{
			local t_ = {};
			t_.motion <- this.motion;
			this.owner.Spell_Team_Hit.call(this, t_);
		}
	};
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000, 1.00000000);
		this.count++;
		this.sx = this.sy += 0.05000000;

		if (this.sx > 1.75000000)
		{
			this.sx = this.sy = 1.75000000;
		}

		if (this.count >= 40)
		{
			this.TargetHoming(this.owner.target, 360.00000000 * 0.01745329, this.direction);
			this.stateLabel = function ()
			{
				this.count++;
				this.TargetHoming(this.owner.target, 3.00000000 * 0.01745329, this.direction);
				this.AddSpeed_Vec(3.00000000, null, 45.00000000, this.direction);
				this.func();
				return;
			};
			return;
		}

		this.TargetHoming(this.owner.target, 3.00000000 * 0.01745329, this.direction);
		this.func();
	};
}

function Spell_Team_Flash( t )
{
	this.SetMotion(t.motion, 2);
	this.sx = this.sy = 0.25000000 + this.rand() % 50 * 0.01000000;
	this.rz = 0.01745329 * this.rand() % 360;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.02500000;
		this.alpha -= 0.04000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_Team_Trail( t )
{
	this.SetMotion(t.motion, 4);
	this.sx = this.sy = 1.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.92000002;
		this.alpha -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_Team_Hit( t )
{
	this.SetMotion(t.motion, 2);
	this.sx = this.sy = 1.00000000;
	this.rz = 0.01745329 * this.rand() % 360;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.stateLabel = function ()
	{
		this.linkObject[0].alpha -= 0.10000000;
		this.linkObject[0].anime.length *= 0.80000001;
		this.linkObject[0].anime.radius0 *= 0.80000001;

		if (this.linkObject[0].alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}

		this.sx = this.sy *= 0.99000001;
		this.alpha -= 0.04000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
	local t_ = {};
	t_.motion <- this.motion;
	local init_ = function ( t__ )
	{
		this.SetMotion(t__.motion, 5);
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0.05000000;
		};
		this.keyAction = function ()
		{
			this.ReleaseActor();
		};
	};
	this.SetFreeObject(this.x, this.y, this.direction, init_, t_);
}

function Spell_Team_Bou( t )
{
	this.SetMotion(4006, 0);
	this.flag1 = this.Vector3();
	this.flag2 = this.Vector3();
	this.flag1.x = this.x;
	this.flag1.y = this.y;
	this.EnableTimeStop(false);
	this.flag2.y = -25.00000000;
	this.func = function ()
	{
		local pos_ = this.Vector3();
		this.GetPoint.call(this.owner, 2, pos_);
		this.Warp(pos_.x, pos_.y - 600.00000000);
		this.flag1.x = this.x;
		this.flag1.y = this.y;
		this.flag2.y = 40.00000000;
	};
	this.stateLabel = function ()
	{
		local pos_ = this.Vector3();
		this.GetPoint.call(this.owner, 2, pos_);
		this.flag1.y += this.flag2.y;
		this.flag1.x = pos_.x;
		this.Warp(this.flag1.x, this.flag1.y);

		if (this.owner.motion != 4090)
		{
			this.ReleaseActor();
			return;
		}
	};
}

