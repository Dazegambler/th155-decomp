function Hammock( t )
{
	this.SetMotion(1221, 4);
	this.DrawActorPriority(189);
	this.keyAction = this.ReleaseActor;
}

function Mukon_Sprash( t )
{
	this.SetMotion(1210, 4);
	this.keyAction = this.ReleaseActor;
}

function Mukon_AirAtk( t )
{
	this.SetMotion(1110, 5);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.flag1 = this.Vector3();
	this.flag1.x = 1,00000000.0;
	this.flag1.RotateByDegree(t.rot);
	this.flag2 = this.Vector3();
	this.flag2.x = this.flag1.x * 75,00000000.0;
	this.flag2.y = this.flag1.y * 33;
	this.flag2.RotateByRadian(0,52359873.0);
	this.Warp(this.owner.point0_x + this.flag2.x * this.direction, this.owner.point0_y + this.flag2.y);
	this.stateLabel = function ()
	{
		this.flag2.x = this.flag1.x * 75,00000000.0;
		this.flag2.y = this.flag1.y * 33;
		this.flag2.RotateByRadian(0,52359873.0);
		this.Warp(this.owner.point0_x + this.flag2.x * this.direction, this.owner.point0_y + this.flag2.y);

		if (this.owner.hitStopTime == 0)
		{
			this.flag1.RotateByDegree(8,00000000.0);
		}
	};
}

function Mukon_AirDash( t )
{
	this.SetMotion(1300, 4);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.flag1 = this.Vector3();
	this.flag1.x = 1,00000000.0;
	this.flag1.RotateByDegree(t.rot);
	this.flag2 = this.Vector3();
	this.flag2.x = this.flag1.x * 75,00000000.0;
	this.flag2.y = this.flag1.y * 33;
	this.flag2.RotateByRadian(0,52359873.0);
	this.Warp(this.owner.point0_x + this.flag2.x * this.direction, this.owner.point0_y + this.flag2.y);
	this.stateLabel = function ()
	{
		this.flag2.x = this.flag1.x * 75,00000000.0;
		this.flag2.y = this.flag1.y * 33;
		this.flag2.RotateByRadian(0,52359873.0);
		this.Warp(this.owner.point0_x + this.flag2.x * this.direction, this.owner.point0_y + this.flag2.y);

		if (this.owner.hitStopTime == 0)
		{
			this.flag1.RotateByDegree(8,00000000.0);
		}
	};
}

function Set_Mukon( x_, y_, type_ = 0 )
{
	if (type_ == 1)
	{
		this.owner.mukon.Add(this.SetShot(x_, y_, 1,00000000.0, this.Mukon_Item_Mid, {}));
	}
	else
	{
		this.owner.mukon.Add(this.SetShot(x_, y_, 1,00000000.0, this.Mukon_Item, {}));
		  // [029]  OP_JMP            0      0    0    0
	}
}

function Mukon_Item( t )
{
	this.SetMotion(2508, 0);
	this.alpha = 0,00000000.0;
	this.SetTeamSelfShot();
	this.sx = this.sy = 2,00000000.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;
		this.sx = this.sy -= 0,10000000.0;
	};
	this.func = [
		function ()
		{
			this.SetMotion(2508, 2);
			this.owner.Mukon_Charge(1);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2,00000000.0 - this.sx) * 0,25000000.0;

				if (this.sx > 1,95000005.0)
				{
					this.stateLabel = function ()
					{
						this.SetSpeed_XY((this.owner.x - this.x) * 0,25000000.0, (this.owner.y - 30 - this.y) * 0,25000000.0);
						this.sx = this.sy -= 0,10000000.0;

						if (this.sx <= 0,00000000.0)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetShot(this.x, this.y, this.direction, this.Mukon_Vucume_Shot, {});
			this.ReleaseActor();
		}
	];
	this.keyAction = function ()
	{
		this.SetSpeed_XY(0,00000000.0, -6,00000000.0);
		this.flag1 = this.rand() % 360 * 0,01745329.0;
		this.stateLabel = function ()
		{
			if (this.IsScreen(100))
			{
				this.ReleaseActor();
				return;
			}

			if (this.hitCount > 0)
			{
				this.func[0].call(this);
				return;
			}

			this.VY_Brake(0,20000000.0, -1,00000000.0);
			this.SetSpeed_XY(1,50000000.0 * this.sin(this.flag1), this.va.y);
			this.flag1 += 0,08726646.0;
		};
	};
}

function Mukon_Item_Mid( t )
{
	this.SetMotion(2508, 3);
	this.alpha = 0,00000000.0;
	this.SetTeamSelfShot();
	this.sx = this.sy = 2,00000000.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;
		this.sx = this.sy -= 0,10000000.0;
	};
	this.func = [
		function ()
		{
			this.SetMotion(2508, 5);
			this.owner.Mukon_Charge(5);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2,00000000.0 - this.sx) * 0,25000000.0;

				if (this.sx > 1,95000005.0)
				{
					this.stateLabel = function ()
					{
						this.SetSpeed_XY((this.owner.x - this.x) * 0,25000000.0, (this.owner.y - 30 - this.y) * 0,25000000.0);
						this.sx = this.sy -= 0,10000000.0;

						if (this.sx <= 0,00000000.0)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetShot(this.x, this.y, this.direction, this.Mukon_Vucume_Shot_Mid, {});
			this.ReleaseActor();
		}
	];
	this.keyAction = function ()
	{
		this.SetSpeed_XY(0,00000000.0, -6,00000000.0);
		this.flag1 = this.rand() % 360 * 0,01745329.0;
		this.stateLabel = function ()
		{
			if (this.IsScreen(100))
			{
				this.ReleaseActor();
				return;
			}

			if (this.hitCount > 0)
			{
				this.func[0].call(this);
				return;
			}

			this.VY_Brake(0,20000000.0, -1,00000000.0);
			this.SetSpeed_XY(1,50000000.0 * this.sin(this.flag1), this.va.y);
			this.flag1 += 0,08726646.0;
		};
	};
}

function Mukon_Item_ChargeShot( t )
{
	this.SetMotion(2508, 3);
	this.alpha = 0,00000000.0;
	this.SetTeamSelfShot();
	this.SetSpeed_Vec(6,00000000.0, t.rot, this.direction);
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;
		this.Vec_Brake(0,20000000.0);
	};
	this.func = [
		function ()
		{
			this.SetMotion(2508, 5);
			this.owner.Mukon_Charge(5);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2,00000000.0 - this.sx) * 0,25000000.0;

				if (this.sx > 1,95000005.0)
				{
					this.stateLabel = function ()
					{
						this.SetSpeed_XY((this.owner.x - this.x) * 0,25000000.0, (this.owner.y - 30 - this.y) * 0,25000000.0);
						this.sx = this.sy -= 0,10000000.0;

						if (this.sx <= 0,00000000.0)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetShot(this.x, this.y, this.direction, this.Mukon_Vucume_Shot_Mid, {});
			this.ReleaseActor();
		}
	];
	this.keyAction = function ()
	{
		this.SetSpeed_XY(0,00000000.0, -6,00000000.0);
		this.flag1 = this.rand() % 360 * 0,01745329.0;
		this.stateLabel = function ()
		{
			if (this.IsScreen(100))
			{
				this.ReleaseActor();
				return;
			}

			if (this.hitCount > 0)
			{
				this.func[0].call(this);
				return;
			}

			this.alpha += 0,10000000.0;
			this.VY_Brake(0,20000000.0, -1,00000000.0);
			this.SetSpeed_XY(1,50000000.0 * this.sin(this.flag1), this.va.y);
			this.flag1 += 0,08726646.0;
		};
	};
}

function Mukon_Vucume_Shot( t )
{
	this.SetMotion(3009, 1);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.cancelCount = 1;
	this.atk_id = 1048576;
	this.flag1 = null;
	this.flag2 = 1,00000000.0;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.flag1 = null;
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;
				this.alpha -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.owner.mukon_se == 0)
			{
				this.PlaySE(4031);
				this.owner.mukon_se = 3;
			}

			this.owner.Mukon_Charge(1);
			this.func[0].call(this);
		}
	];
	this.subState = function ()
	{
		this.vec.x = this.owner.point0_x - this.x;
		this.vec.y = this.owner.point0_y - this.y;

		if (this.vec.Length() <= 25)
		{
			this.func[1].call(this);
			return;
		}

		this.vec.Normalize();
		this.SetSpeed_XY(this.vec.x, this.vec.y);
	};
	this.keyAction = function ()
	{
		this.flag1 = this.SetTrail(this.motion, 4);

		if (this.va.x > 0,00000000.0)
		{
			this.direction = 1,00000000.0;
		}

		if (this.va.x < 0,00000000.0)
		{
			this.direction = -1,00000000.0;
		}

		this.subState = function ()
		{
			this.vec.x = this.owner.point0_x - this.x;
			this.vec.y = this.owner.point0_y - this.y;

			if (this.vec.Length() <= 25)
			{
				this.func[1].call(this);
				return;
			}

			this.vec.Normalize();
			this.flag2 += 1,00000000.0;

			if (this.flag2 > 25,00000000.0)
			{
				this.flag2 = 25,00000000.0;
			}

			this.SetSpeed_XY(this.vec.x * this.flag2, this.vec.y * this.flag2);
		};
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if ((this.owner.motion == 3000 || this.owner.motion == 3001) && (this.owner.keyTake == 1 || this.owner.keyTake == 2))
		{
			this.subState();
		}
		else
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Mukon_Vucume_Shot_Mid( t )
{
	this.SetMotion(3009, 5);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.cancelCount = 3;
	this.atk_id = 1048576;
	this.flag1 = null;
	this.flag2 = 1,00000000.0;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.flag1 = null;
			this.SetMotion(this.motion, 7);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;
				this.alpha -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.PlaySE(4031);
			this.owner.Mukon_Charge(5);
			this.func[0].call(this);
		}
	];
	this.subState = function ()
	{
		this.vec.x = this.owner.point0_x - this.x;
		this.vec.y = this.owner.point0_y - this.y;

		if (this.vec.Length() <= 25)
		{
			this.func[1].call(this);
			return;
		}

		this.vec.Normalize();
		this.SetSpeed_XY(this.vec.x, this.vec.y);
	};
	this.keyAction = function ()
	{
		this.flag1 = this.SetTrail(this.motion, 8);

		if (this.va.x > 0,00000000.0)
		{
			this.direction = 1,00000000.0;
		}

		if (this.va.x < 0,00000000.0)
		{
			this.direction = -1,00000000.0;
		}

		this.subState = function ()
		{
			this.vec.x = this.owner.point0_x - this.x;
			this.vec.y = this.owner.point0_y - this.y;

			if (this.vec.Length() <= 25)
			{
				this.func[1].call(this);
				return;
			}

			this.vec.Normalize();
			this.flag2 += 0,50000000.0;

			if (this.flag2 > 20,00000000.0)
			{
				this.flag2 = 20,00000000.0;
			}

			this.SetSpeed_XY(this.vec.x * this.flag2, this.vec.y * this.flag2);
		};
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if ((this.owner.motion == 3000 || this.owner.motion == 3001) && (this.owner.keyTake == 1 || this.owner.keyTake == 2))
		{
			this.subState();
		}
		else
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Shot_Normal_Sub( t )
{
	this.SetMotion(2009, 0);
	this.func = [
		function ()
		{
			this.SetMotion(2009, 1);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,94999999.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.owner.target.team.current.SetCommonFreeObject(this.x, this.y, this.direction, this.Occult_Power, {});
			this.func[0].call(this);
		},
		function ()
		{
			this.Set_Mukon(this.x, this.y);
			this.func[0].call(this);
		}
	];
}

function Shot_Normal( t )
{
	this.cancelCount = 5;
	this.flag1 = [];
	this.flag2 = this.Vector3();
	this.flag2.x = 1,00000000.0;
	this.flag3 = 2,00000000.0;
	this.atk_id = 16384;
	this.cancelCount = 5;

	for( local i = 0; i < 12; i++ )
	{
		this.flag1.append(this.SetShot(this.x, this.y, this.direction, this.Shot_Normal_Sub, {}).weakref());
	}

	foreach( a in this.flag1 )
	{
		a.hitOwner = this;
	}

	this.func = [
		function ()
		{
			if (this.hitResult & 1)
			{
				foreach( a in this.flag1 )
				{
					a.func[2].call(a);
					a.hitOwner = null;
				}
			}
			else
			{
				foreach( a in this.flag1 )
				{
					a.func[0].call(a);
					a.hitOwner = null;
				}
			}

			this.ReleaseActor();
		}
	];
	this.SetSpeed_Vec(3,00000000.0, t.rot, this.direction);
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return;
		}

		if (this.owner.IsDamage())
		{
			foreach( a in this.flag1 )
			{
				a.func[1].call(a);
				a.hitOwner = null;
			}

			this.ReleaseActor();
			return;
		}

		if (this.hitCount >= 3 || this.cancelCount <= 0 || this.grazeCount > 5)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(1);
		this.rz += 0,03490658.0;
		this.flag2.RotateByRadian(-0,10471975.0);
		this.flag3 += (150 - this.flag3) * 0,01500000.0;
		this.AddSpeed_Vec(0,15000001.0, null, 15,00000000.0, this.direction);

		foreach( a in this.flag1 )
		{
			this.flag2.RotateByRadian(0,52359873.0);
			local v_ = this.Vector3();
			v_.x = this.flag2.x * this.flag3;
			v_.y = this.flag2.y * this.flag3 * 0,33000001.0;
			v_.RotateByRadian(this.rz);
			a.Warp(this.x + v_.x * this.direction, this.y + v_.y);
		}
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 0);
	this.cancelCount = 1;
	this.atk_id = 65536;
	this.flag1 = this.y + 100;
	this.SetSpeed_XY(10,00000000.0 * this.direction, -7,50000000.0);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 2);
			this.flag1 = 2,00000000.0 + this.rand() % 10 * 0,10000000.0;
			this.flag2 = 0,10471975.0 + this.rand() % 12 * 0,01745329.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (this.flag1 - this.sx) * 0,15000001.0;
				this.flag2 *= 0,93000001.0;
				this.rz += this.flag2;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(75,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0)
		{
			this.Set_Mukon(this.x, this.y, 1);
			this.func[0].call(this);
			return;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,89999998.0);

		if (this.keyTake == 0 && this.va.y > 0)
		{
			this.SetMotion(this.motion, 1);
		}

		if (this.va.y > 0 && this.y >= this.flag1)
		{
			this.PlaySE(4026);
			this.SetMotion(this.motion, 0);
			this.SetSpeed_XY(14,00000000.0 * this.direction, -14,50000000.0);
		}
	};
}

function Shot_BarrageFire( t )
{
	this.SetMotion(2026, 2);
	this.stateLabel = function ()
	{
		this.alpha = this.blue = this.green -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, 0);
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_BarrageFire, {});
	this.atk_id = 262144;
	this.SetSpeed_Vec(5,00000000.0, t.rot, this.direction);
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, 1);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,92000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.keyAction = this.func;
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2029, 0);
	this.SetSpeed_XY(17,50000000.0 * this.direction, -6,50000000.0);
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.flag1 = 0,52359873.0;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.hitCount > 0)
			{
				for( local i = 0; i < 6; i++ )
				{
					local t_ = {};
					t_.rot <- i * 1,04719746.0;
					this.SetShot(this.x, this.y, this.direction, this.Mukon_Item_ChargeShot, t_);
				}
			}

			this.HitReset();
			this.PlaySE(4028);
			this.SetMotion(2028, 0);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.cancelCount = 3;
			this.keyAction = this.ReleaseActor;
			this.rz = 0,00000000.0;
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP.call(this, this.x, this.y, 10) || this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		this.count++;
		this.rz += this.flag1;
		this.VX_Brake(0,40000001.0, 4,00000000.0 * this.direction);
		this.AddSpeed_XY(0,00000000.0, this.va.y < 0,00000000.0 ? 0,50000000.0 : 0,50000000.0);

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.count >= 45)
		{
			this.func[1].call(this);
			return;
		}
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.cancelCount = 1;
	this.atk_id = 536870912;
	this.flag1 = this.y + 100;
	this.flag2 = 0;
	this.SetSpeed_XY(6,00000000.0 * this.direction, -12,50000000.0);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 2);
			this.flag1 = 2,00000000.0 + this.rand() % 10 * 0,10000000.0;
			this.flag2 = 0,10471975.0 + this.rand() % 12 * 0,01745329.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (this.flag1 - this.sx) * 0,15000001.0;
				this.flag2 *= 0,93000001.0;
				this.rz += this.flag2;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(150,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0)
		{
			this.Set_Mukon(this.x, this.y, 0);
			this.func[0].call(this);
			return;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,89999998.0);

		if (this.keyTake == 0 && this.va.y > 0)
		{
			this.SetMotion(this.motion, 1);
		}

		this.count++;

		if (this.count >= 33)
		{
			if (this.flag2 >= 4)
			{
				this.func[0].call(this);
				return;
			}
			else
			{
				this.count = 0;
				this.PlaySE(4026);
				this.SetMotion(this.motion, 0);
				local r_ = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
				r_ = this.Math_MinMax(r_, -1,04719746.0, 1,04719746.0);
				this.SetSpeed_Vec(6,00000000.0, r_, this.direction);
				this.flag2++;
				this.AddSpeed_XY(0,00000000.0, -14,50000000.0);
			}
		}
	};
}

function SPShot_Vuccum( t )
{
	this.DrawActorPriority(189);
	this.SetMotion(3009, 0);
	this.atk_id = 1048576;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag1 = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.flag1 += 0,50000000.0;

		if (this.flag1 >= 7,50000000.0)
		{
			this.flag1 = 7,50000000.0;
		}

		local d_ = this.owner.target.x - this.x;

		if (d_ * this.direction >= 0)
		{
			this.owner.target.vf.x = -d_ * 0,10000000.0;
			this.owner.target.vf.x = this.Math_MinMax(this.owner.target.vf.x, -this.flag1, this.flag1);
			this.owner.target.ConvertTotalSpeed();
		}
	};
}

function SPShot_Bound_Fire( t )
{
	this.SetMotion(3019, 5);
	this.keyAction = this.ReleaseActor;
}

function SPShot_Bound_Main( t )
{
	this.SetMotion(3019, 2);
	this.SetTaskAddRotation(0, 0, -0,08726646.0);
	this.rz = 0,01745329.0 * (this.rand() % 360);
	this.SetSpeed_Vec(13,00000000.0, t.rot, this.direction);
	this.cancelCount = 2;
	this.atk_id = 2097152;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.SetSpeed_XY(-this.va.x, -4,50000000.0);
			this.SetTaskAddRotation(0, 0, -0,08726646.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);

		if (this.Vec_Brake(0,50000000.0, 6,00000000.0))
		{
			this.subState = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 3))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0)
		{
			this.Set_Mukon(this.x, this.y, 1);
			this.func[0].call(this);
			return;
		}

		if (this.grazeCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function SPShot_B_Mukon( t )
{
	this.SetMotion(3019, 4);
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.SetMotion(3019, 4);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,10000000.0;
				this.alpha -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > this.owner.centerY)
		{
			this.AddSpeed_XY(0,00000000.0, -0,75000000.0, 0,00000000.0, -15,00000000.0);

			if (this.y + this.va.y <= this.owner.centerY)
			{
				this.Warp(this.x, this.owner.centerY);
				this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			}
		}
		else
		{
			this.AddSpeed_XY(0,00000000.0, 0,75000000.0, 0,00000000.0, 15,00000000.0);

			if (this.y + this.va.y >= this.owner.centerY)
			{
				this.Warp(this.x, this.owner.centerY);
				this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			}
		}
	};
}

function SPShot_Bomb_Sub( t )
{
	this.SetMotion(3029, 1);
	this.SetParent(t.pare, 0, 0);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha += 0,03300000.0;
			};
		},
		function ()
		{
			this.alpha = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (3,00000000.0 - this.sx) * 0,10000000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function SPShot_Bomb_Main( t )
{
	this.SetMotion(3029, 0);
	this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_Bomb_Sub, {}, this.weakref()).weakref();
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(25,00000000.0, t.rot, this.direction);
	this.flag1 = 0,26179937.0;
	this.atk_id = 4194304;
	this.subState = function ()
	{
		this.Vec_Brake(1,00000000.0, 6,00000000.0);
	};
	this.func = [
		function ()
		{
			if (this.flag2)
			{
				this.flag2.ReleaseActor();
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.subState = function ()
			{
				this.Vec_Brake(0,15000001.0);
			};

			if (this.flag2)
			{
				this.flag2.func[1].call(this.flag2);
			}
		},
		function ()
		{
			this.PlaySE(4037);
			this.sx = this.sy = 2,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

			if (this.flag2)
			{
				this.flag2.func[2].call(this.flag2);
			}

			this.SetMotion(this.motion, 2);
			this.cancelCount = 3;
			this.alpha = 1,25000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2,50000000.0 - this.sx) * 0,20000000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
		this.count++;

		if (this.count == 30)
		{
			this.func[1].call(this);
		}

		if (this.count == 90)
		{
			this.func[2].call(this);
			return;
		}

		this.rz += this.flag1;
		this.flag1 *= 0,99000001.0;

		if (this.va.x > 0 && this.x > ::camera.camera2d.right || this.va.x < 0 && this.x < ::camera.camera2d.left)
		{
			this.va.x *= -1,00000000.0;
		}

		if (this.va.y < 0 && this.y < ::camera.camera2d.top || this.va.y > 0 && this.y > ::camera.camera2d.bottom)
		{
			this.va.y *= -1,00000000.0;
		}

		this.ConvertTotalSpeed();
	};
}

function SPShot_Bed_Fire( t )
{
	this.SetMotion(3039, 1);
	this.rz = t.rot;
	this.keyAction = this.ReleaseActor;
}

function SPShot_Bed_Canon( t )
{
	this.SetMotion(3039, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.sx = this.sy = 0,10000000.0;
	this.atk_id = 8388608;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.sx = this.sy = 1,00000000.0;
			this.SetMotion(3039, 1);
			this.stateLabel = null;
		},
		function ()
		{
			this.PlaySE(4040);
			this.SetParent(null, 0, 0);
			this.rz = this.atan2(this.target.y - 20 - this.y, (this.target.x - this.x) * this.direction);
			this.rz = this.Math_MinMax(this.rz, -0,34906584.0, 0,34906584.0);
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_Bed_Fire, t_);
			this.SetMotion(3039, 2);
			this.cancelCount = 1;
			this.SetSpeed_Vec(25,00000000.0, this.rz, this.direction);
			this.stateLabel = function ()
			{
				if (this.IsScreen(300) || this.Damage_ConvertOP(this.x, this.y, 5))
				{
					this.ReleaseActor();
					return;
				}

				if (this.cancelCount <= 0)
				{
					this.func[2].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.SetMotion(3039, 4);
			this.SetSpeed_XY(this.va.x * 0,20000000.0, this.va.y * 0,20000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
				this.alpha = this.red = this.green = this.blue -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.keyAction = [
		null,
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy += 0,25000000.0;

		if (this.sx > 1,00000000.0)
		{
			this.subState = function ()
			{
				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
	};
}

function SPShot_Balloon( t )
{
	this.SetMotion(3049, 0);
	this.sx = this.sy = 0,33000001.0;
	this.flag1 = 1,00000000.0;
	this.atk_id = 16777216;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.PlaySE(4043);
			::camera.shake_radius = 4,00000000.0;

			if (this.owner.flag1 == this)
			{
				this.owner.flag1 = null;
			}

			this.ReleaseActor();
		},
		function ()
		{
			local t_ = {};
			t_.rot <- -15 * 0,01745329.0;
			t_.take <- 2;
			t_.scale <- this.sx;
			t_.vx <- this.owner.va.x;
			t_.vy <- this.owner.va.y;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_BalloonFree, t_);
			local t_ = {};
			t_.rot <- 0 * 0,01745329.0;
			t_.take <- 3;
			t_.scale <- this.sx;
			t_.vx <- this.owner.va.x;
			t_.vy <- this.owner.va.y;
			this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.SPShot_BalloonFree, t_);
			local t_ = {};
			t_.rot <- 15 * 0,01745329.0;
			t_.take <- 4;
			t_.scale <- this.sx;
			t_.vx <- this.owner.va.x;
			t_.vy <- this.owner.va.y;
			this.SetFreeObject(this.point2_x, this.point2_y, this.direction, this.SPShot_BalloonFree, t_);
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += (this.flag1 - this.sx) * 0,10000000.0;

		if (this.sx >= 1,00000000.0 && this.keyTake == 0)
		{
			this.SetMotion(this.motion, 1);
		}

		this.flag1 += 0,01000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

function SPShot_BalloonFree( t )
{
	this.SetMotion(3049, t.take);
	this.sx = this.sy = t.scale;
	this.SetSpeed_XY(t.vx, t.vy);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, -0,10000000.0);

		if (this.y < ::battle.scroll_top - 200)
		{
			this.ReleaseActor();
		}

		this.rz += -this.rz * 0,07500000.0;
	};
}

function Occult_Back( t )
{
	this.SetMotion(2509, 0);
	this.anime.is_equal = true;
	this.DrawActorPriority(10);
	this.stateLabel = function ()
	{
		this.sx = this.sy = 1,00000000.0 / ::camera.zoom;
		this.Warp((::camera.camera2d.left + ::camera.camera2d.right) * 0,50000000.0 - (::camera.target_x - 640) * 0,10000000.0, (::camera.camera2d.bottom + ::camera.camera2d.top) * 0,50000000.0 - (::camera.target_y - 360) * 0,10000000.0);
	};
}

function Occult_Mukon( t )
{
	this.SetMotion(2509, 4);
	this.sx = this.sy = 0,10000000.0;
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(2509, 6);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,10000000.0);
				this.sx = this.sy *= 0,89999998.0;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy += 0,10000000.0;

		if (this.sx >= 1,00000000.0)
		{
			this.SetMotion(2509, 5);
			this.subState = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,10000000.0);

				if (this.hitCount > 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 32 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		this.subState();
	};
}

function Occult_Hole( t )
{
	this.SetMotion(2509, 1);
	this.DrawActorPriority(9);
	this.anime.is_write = true;
	this.anime.stencil = this.owner.back_park;
	this.flag1 = t.scale;
	this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.Occult_HoleRing, {}).weakref();
	this.flag3 = 0;
	this.flag5 = {};
	this.flag5.range <- 88;
	this.flag5.point <- this.Vector3();
	this.flag5.shotRot <- 90,00000000.0;
	this.flag5.shotRotSpeed <- -30;
	this.flag5.shotPos <- this.Vector3();
	this.flag5.shotPos.y = 1,00000000.0;
	this.sx = this.sy = 0,10000000.0;
	this.func = [
		function ()
		{
			foreach( val, a in this.owner.back_hole )
			{
				if (a == this)
				{
					this.owner.back_hole.remove(val);
				}
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ( root_ )
		{
			local t_ = {};
			t_.scale <- this.flag1;
			this.flag4 = root_.weakref();
			this.SetFreeObject(this.x, this.y, this.direction, this.Occult_ReactRing, t_);
			this.PlaySE(4046);
			this.flag5.shotRot = 90;
			this.flag3 = 0;
			this.subState = function ()
			{
				this.flag3++;

				if (this.flag3 == 20)
				{
					foreach( a in this.owner.back_hole )
					{
						if (a && a != this && a != this.flag4)
						{
							this.flag5.point.x = a.x - this.x;
							this.flag5.point.y = a.y - this.y;

							if (this.flag5.point.Length() <= this.flag5.range * this.flag1 + a.flag5.range * a.flag1)
							{
								a.func[1].call(a, this);
							}
						}
					}
				}

				if (this.flag3 >= 25 && this.count % 3 == 1)
				{
					if (this.flag5.shotRot == 90,00000000.0 || this.flag5.shotRot == -90,00000000.0)
					{
						this.SetShot(this.x + this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
					}
					else
					{
						this.SetShot(this.x + this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
						this.SetShot(this.x - this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
					}

					if (this.flag5.shotRot <= -90,00000000.0)
					{
						this.func[0].call(this);
						return;
					}

					this.flag5.shotRot += this.flag5.shotRotSpeed;
					this.flag5.shotPos.RotateByDegree(this.flag5.shotRotSpeed);
				}
			};

			foreach( val, a in this.owner.back_hole )
			{
				if (a == this)
				{
					this.owner.back_hole.remove(val);
				}
			}
		},
		function ()
		{
			local t_ = {};
			t_.scale <- this.flag1;
			this.SetFreeObject(this.x, this.y, this.direction, this.Occult_ReactRing, t_);
			this.PlaySE(4046);
			this.subState = function ()
			{
				if (this.count >= 1200)
				{
					this.func[0].call(this);
					return;
				}

				this.flag3++;

				if (this.flag3 == 25)
				{
					foreach( a in this.owner.back_hole )
					{
						if (a && a != this)
						{
							this.flag5.point.x = a.x - this.x;
							this.flag5.point.y = a.y - this.y;

							if (this.flag5.point.Length() <= this.flag5.range * this.flag1 + a.flag5.range * a.flag1)
							{
								a.func[1].call(a, this);
							}
						}
					}
				}

				if (this.flag3 >= 25 && this.count % 3 == 1)
				{
					if (this.flag5.shotRot >= -90,00000000.0)
					{
						if (this.flag5.shotRot == 90,00000000.0 || this.flag5.shotRot == -90,00000000.0)
						{
							this.SetShot(this.x + this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
						}
						else
						{
							this.SetShot(this.x + this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
							this.SetShot(this.x - this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
						}

						this.flag5.shotRot += this.flag5.shotRotSpeed;
						this.flag5.shotPos.RotateByDegree(this.flag5.shotRotSpeed);
					}
				}
			};
		}
	];

	switch(t.level)
	{
	case 4:
		this.func[2].call(this);
		this.flag5.shotRotSpeed = -6,00000000.0;
		break;

	case 3:
		this.func[2].call(this);
		this.flag5.shotRotSpeed = -10,00000000.0;
		break;

	case 2:
		this.func[2].call(this);
		this.flag5.shotRotSpeed = -15,00000000.0;
		break;

	case 1:
		this.func[2].call(this);
		this.flag5.shotRotSpeed = -22,50000000.0;
		break;

	default:
		this.subState = function ()
		{
			if (this.count >= 1200)
			{
				this.func[0].call(this);
			}
		};
		break;
	}

	this.stateLabel = function ()
	{
		local x_ = this.flag1 + 0,05000000.0 * this.sin(this.count * 0,05235988.0);
		this.sx = this.sy += (x_ - this.sx) * 0,15000001.0;

		if (this.flag2)
		{
			this.flag2.sx = this.flag2.sy = this.sx;
		}

		this.count++;
		this.subState();
	};
}

function Occult_HoleRing( t )
{
	this.SetMotion(2509, 3);
	this.DrawActorPriority(10);
	this.sx = this.sy = 0,10000000.0;
	this.stateLabel = function ()
	{
		this.alpha -= 0,03300000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Occult_ReactRing( t )
{
	this.SetMotion(2509, 3);
	this.DrawActorPriority(10);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = t.scale;
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Occult_Stump( t )
{
	this.SetMotion(2509, 2);
	this.DrawActorPriority(189);
	this.keyAction = this.ReleaseActor;
}

function SpellShot_A( t )
{
	this.SetMotion(4009, 0);
	this.DrawActorPriority(180);
	this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
	this.cancelCount = 10;
	this.atk_id = 67108864;
	this.target = this.owner.target.weakref();
	this.flag1 = this.Vector3();
	this.sx = this.sy = 0,15000001.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.func = [
		function ()
		{
			this.SetKeyFrame(1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,05000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (0,75000000.0 - this.sx) * 0,07500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.count++;

		if (this.count % 15 == 1)
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.SS_A_Wave, {}, this.weakref());
		}

		this.flag1.x = this.team.target.x - this.x;
		this.flag1.y = this.team.target.y - this.y;

		if (this.flag1.Length() <= 10)
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		}
		else
		{
			this.flag1.SetLength(3,00000000.0);
			this.SetSpeed_XY(this.flag1.x, this.flag1.y);
		}

		this.HitCycleUpdate(3);

		if (this.count >= 150 || this.hitCount >= 10 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function SS_A_Wave( t )
{
	this.SetMotion(4009, 2);
	this.SetParent(t.pare, 0, 0);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.alpha = 0,00000000.0;
	this.SetTaskAddScaling(0,05000000.0, 0,05000000.0);
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_B( t )
{
	this.atk_id = 67108864;
	this.func = [
		function ()
		{
			foreach( a in this.flag1 )
			{
				a.func[0].call(a);
			}

			this.ReleaseActor();
		},
		function ()
		{
			foreach( a in this.flag1 )
			{
				a.func[1].call(a);
			}

			this.stateLabel = function ()
			{
				this.flag2 -= 1,25000000.0;

				if (this.flag2 <= 0)
				{
					this.func[2].call(this);
					return;
				}

				this.flag1[0].Warp(this.x, this.y - this.flag2);
				this.flag1[1].Warp(this.x, this.y + this.flag2);
				this.flag1[0].rx += 0,12500000.0 * 0,01745329.0;
				this.flag1[1].rx -= 0,12500000.0 * 0,01745329.0;
			};
		},
		function ()
		{
			foreach( a in this.flag1 )
			{
				a.ReleaseActor();
			}

			this.SetMotion(4019, 3);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,10000000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.flag1 = [
		this.SetShotStencil(this.x, this.y - 350, this.direction, this.SS_B_Vortex, {}).weakref(),
		this.SetShotStencil(this.x, this.y + 350, this.direction, this.SS_B_Vortex, {}).weakref()
	];
	this.flag1[0].rx = 80 * 0,01745329.0;
	this.flag1[1].rx = 100 * 0,01745329.0;
	this.flag2 = 350;
	this.stateLabel = function ()
	{
		local y_ = (125 - this.flag2) * 0,20000000.0;

		if (y_ > -0,50000000.0)
		{
			y_ = -0,50000000.0;
		}

		this.flag2 += y_;
		this.flag1[0].Warp(this.x, this.y - this.flag2);
		this.flag1[1].Warp(this.x, this.y + this.flag2);
	};
}

function SS_B_Back( t )
{
	this.SetMotion(4019, 4);
	this.anime.is_equal = true;
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function SS_B_VortexSub( t )
{
	this.SetMotion(4019, 2);
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.alpha = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.rz += 0,05235988.0;
				this.alpha -= 0,10000000.0;
				this.sx = this.sy -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function SS_B_Vortex( t )
{
	this.SetMotion(4019, 0);
	this.atk_id = 67108864;
	this.DrawActorPriority(180);
	this.anime.is_write = true;
	this.flag1 = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.SS_B_Back, {}).weakref();
	this.flag1.anime.stencil = this;
	this.flag1.SetParent(this, 0, 0);
	this.flag2 = null;
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 0,50000000.0;
	this.func = [
		function ()
		{
			this.alpha = 1,00000000.0;
			this.SetMotion(4019, 0);

			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.flag2 = null;
			this.stateLabel = function ()
			{
				this.rz += 0,05235988.0;
				this.alpha -= 0,10000000.0;
				this.sx = this.sy -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4019, 1);
			this.cancelCount = 3;
			this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.SS_B_VortexSub, {}).weakref();
			this.flag2.SetParent(this, 0, 0);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;
				this.rz += 0,34906584.0;
				this.HitCycleUpdate(4);

				if (this.flag2)
				{
					this.flag2.rx = this.rx;
					this.flag2.sx = this.flag2.sy = this.sx;
					this.flag2.rz -= 0,10471975.0;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;
		this.alpha += 0,10000000.0;
		this.rz += 0,05235988.0;
	};
}

function SpellShot_C( t )
{
	this.SetMotion(4029, 5);
	this.DrawActorPriority(189);
	this.SetSpeed_Vec(10,00000000.0 + this.rand() % 6, t.rot, this.direction);
	this.rz = t.rot;
	this.cancelCount = 1;
	this.atk_id = 67108864;
	this.func = [
		function ()
		{
			this.DrawActorPriority(200);
			this.SetMotion(4029, 6);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.alpha = 1,50000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (1,70000005.0 - this.sx) * 0,15000001.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.grazeCount > 0 || this.IsScreen(10))
		{
			this.func[0].call(this);
			return;
		}

		this.TargetHoming(this.team.target, 1,00000000.0 * 0,01745329.0, this.direction);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);
	};
}

function SpellShot_C_PartA( t )
{
	this.SetMotion(4028, 0);
	this.DrawActorPriority(180);
	this.SetSpeed_Vec(10, -0,17453292.0, this.direction);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (0,75000000.0 - this.sx) * 0,20000000.0;
		this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
		this.count++;

		if (this.count >= 30)
		{
			this.alpha = this.red = this.blue = this.green -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SpellShot_C_PartB( t )
{
	this.SetMotion(4028, 1);
	this.DrawActorPriority(180);
	this.SetSpeed_Vec(10, -160 * 0,01745329.0, this.direction);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (0,80000001.0 - this.sx) * 0,20000000.0;
		this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
		this.count++;

		if (this.count >= 30)
		{
			this.alpha = this.red = this.blue = this.green -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SpellShot_C_PartC( t )
{
	this.SetMotion(4028, 2);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,75000000.0 - this.sx) * 0,20000000.0;
		this.count++;

		if (this.count >= 30)
		{
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SpellShot_C_PartD( t )
{
	this.SetMotion(4028, 3);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,20000000.0;
		this.count++;

		if (this.count >= 30)
		{
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_Circle( t )
{
	this.SetMotion(4905, 1);
	this.SetParent(this.owner, 0, 0);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.center_x = 0;
	this.anime.center_y = 0;
	this.anime.radius0 = t.size;
	this.anime.radius1 = t.size;
	this.anime.length = t.size;
	this.anime.vertex_alpha1 = 1,00000000.0;
	this.anime.vertex_blue1 = 1,00000000.0;
	this.anime.vertex_red1 = 1,00000000.0;
	this.anime.vertex_green1 = 1,00000000.0;
	this.rx = (-90 + this.rand() % 181) * 0,01745329.0;
	this.ry = (-90 + this.rand() % 181) * 0,01745329.0;
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.anime.length *= 0,89999998.0;
		this.count++;
		this.anime.radius0 = this.anime.radius1 += 0,50000000.0;
		this.rz -= 15 * 0,01745329.0;
		this.anime.length *= 0,94999999.0;

		if (this.anime.length <= 5)
		{
			this.alpha -= 0,10000000.0;
		}
		else
		{
			this.alpha += (1,00000000.0 - this.alpha) * 0,25000000.0;
		}

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_Shot( t )
{
	this.SetMotion(4905, 2);
	this.SetParent(this.owner, 0, 0);
	this.atk_id = 134217728;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(10);
	};
}

function Climax_Seat( t )
{
	this.SetMotion(4909, 1);
	this.DrawScreenActorPriority(100);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.stateLabel = function ()
			{
			};
		}
	};
}

function Climax_Back_Black( t )
{
	this.DrawScreenActorPriority(79);
	this.SetMotion(4909, 1);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_Back( t )
{
	this.DrawScreenActorPriority(80);
	this.SetMotion(4909, 3);
	this.sx = this.sy = 1,75000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.flag5.face)
				{
					this.Warp(this.owner.flag5.face.x, this.owner.flag5.face.y);
				}

				this.sx = this.sy -= 0,02000000.0;

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		local s_ = (1,33000004.0 - this.sx) * 0,10000000.0;

		if (s_ > -0,00100000.0)
		{
			s_ = -0,00100000.0;
		}

		this.sx = this.sy += s_;
		this.SetSpeed_XY(0,00000000.0, -0,05000000.0 * this.sx);
	};
}

function Climax_Squeez( t )
{
	this.DrawScreenActorPriority(100);
	this.SetMotion(4909, 4);
	this.sx = this.sy = 3,00000000.0;
	this.rx = 45;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.flag5.face)
				{
					this.Warp(this.owner.flag5.face.x, this.owner.flag5.face.y);
				}

				this.sx = this.sy -= 0,02000000.0;

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}

				this.rz += 3,50000000.0 * 0,01745329.0;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.rz += 0,50000000.0 * 0,01745329.0;
		this.sx = this.sy += (1,25000000.0 - this.sx) * 0,10000000.0;
	};
}

function Climax_EnemyStun( t )
{
	this.SetMotion(309, 1);
	this.DrawScreenActorPriority(90);
	this.sx = this.sy = 6,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.target.flag5.face)
				{
					this.Warp(this.owner.target.flag5.face.x, this.owner.target.flag5.face.y);
				}

				this.sx = this.sy -= 0,05000000.0;

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		local s_ = (2,25000000.0 - this.sx) * 0,10000000.0;

		if (s_ > -0,00500000.0)
		{
			s_ = -0,00500000.0;
		}

		this.sx = this.sy += s_;
	};
}

function Climax_Gate( t )
{
	this.SetMotion(4909, 5);
	this.DrawScreenActorPriority(95);
	this.ry = -80 * 0,01745329.0;
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.flag5.face)
				{
					this.Warp(this.owner.flag5.face.x - 625 * this.sx * this.direction, this.owner.flag5.face.y);
				}

				this.sx = this.sy -= 0,02000000.0;
				this.alpha += 0,07500000.0;
				this.flag1 += 0,01000000.0 * 0,01745329.0;

				if (this.flag1 > 6,00000000.0 * 0,01745329.0)
				{
					this.flag1 = 6,00000000.0 * 0,01745329.0;
				}

				this.ry += this.flag1;

				if (this.ry >= 0,00000000.0)
				{
					this.ry = 0,00000000.0;
				}

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,07500000.0;
		this.flag1 += 0,01000000.0 * 0,01745329.0;

		if (this.flag1 > 6,00000000.0 * 0,01745329.0)
		{
			this.flag1 = 6,00000000.0 * 0,01745329.0;
		}

		this.ry += this.flag1;

		if (this.ry >= 0,00000000.0)
		{
			this.ry = 0,00000000.0;
			this.stateLabel = null;
		}
	};
}

function Climax_ChainPre( t )
{
	this.DrawScreenActorPriority(96);
	this.SetMotion(4908, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.flag1.x *= 1,01999998.0;
				this.flag1.y *= 1,01999998.0;

				if (this.owner.flag5.face)
				{
					this.Warp(this.owner.flag5.face.x + this.flag1.x, this.owner.flag5.face.y + this.flag1.y);
				}

				this.sx = this.sy -= 0,02000000.0;

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 1);
			this.subState = function ()
			{
				if (this.flag2 >= 1,00000000.0)
				{
					this.flag2 -= 1,00000000.0;
				}
				else
				{
					this.flag2 -= 0,10000000.0;
				}

				if (this.flag2 <= 0)
				{
					this.flag2 = -3,00000000.0;
					this.subState = function ()
					{
						this.flag2 += 1,00000000.0;

						if (this.flag2 > 0)
						{
							this.flag2 = 0;
							this.subState = function ()
							{
							};
						}
					};
				}
			};
			this.stateLabel = function ()
			{
				this.subState();
				this.anime.top += this.flag2;
			};
		}
	];
	this.flag1 = this.Vector3();
	this.flag1.x = this.x - 640;
	this.flag1.y = this.y - 360;
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 15,00000000.0;
	this.flag4 = this.sx * 0,00500000.0;
	this.rz = t.rot;
	this.flag2 = 10,00000000.0;
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.alpha += 0,05000000.0;
		this.anime.top += this.flag2;
		this.sx = this.sy += (this.initTable.scale - this.sx) * 0,15000001.0;
	};
}

function Climax_Chain( t )
{
	this.DrawScreenActorPriority(95);
	this.SetMotion(4908, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.flag5.face)
				{
					this.Warp(this.owner.flag5.face.x, this.owner.flag5.face.y);
				}

				this.sx = this.sy -= 0,02000000.0;

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 30,00000000.0;
	this.rz = 45 * 0,01745329.0;
	this.flag1 = 10,00000000.0;
	this.flag2 = 4,00000000.0;
	this.flag3 = 0,00000000.0;
	this.subState = function ()
	{
		if (this.count >= 50)
		{
			if (this.keyTake == 0 && this.flag1 < 10)
			{
				this.SetMotion(this.motion, 1);
			}

			if (this.flag1 >= 1,00000000.0)
			{
				this.flag1 -= 1,00000000.0;
			}
			else
			{
				this.flag1 -= 0,10000000.0;
			}

			if (this.flag1 <= 0)
			{
				this.flag1 = -3,00000000.0;
				this.subState = function ()
				{
					this.flag1 += 1,00000000.0;

					if (this.flag1 > 0)
					{
						this.flag1 = 0;
						this.subState = function ()
						{
						};
					}
				};
			}
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.count++;
		this.anime.top += this.flag1;
		this.flag2 -= 0,00750000.0;
		this.flag3 += 0,02000000.0;

		if (this.flag3 > 1,00000000.0)
		{
			this.flag3 = 1,00000000.0;
		}

		this.sx = this.sy = this.Math_Bezier(30,00000000.0, this.flag2, 25,00000000.0, this.flag3);

		if (this.sx < this.flag2)
		{
			this.sx = this.sy = this.flag2;
		}

		this.alpha += 0,10000000.0;
		this.Warp(this.x - (this.x - 640) * 0,15000001.0, this.y);
	};
}

function Climax_MidBack( t )
{
	this.DrawScreenActorPriority(100);
	this.SetMotion(4909, 1);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;
	};
}

function Climax_Cut( t )
{
	this.DrawScreenActorPriority(101);
	this.SetMotion(4909, 8);
	this.sx = this.sy = 5,00000000.0;
	this.alpha = 0,00000000.0;
	this.flag1 = null;
	this.flag2 = -0,01000000.0;
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Climax_CutFlash, {}).weakref();
			this.stateLabel = function ()
			{
				local s_ = (1,00000000.0 - this.sx) * 0,10000000.0;

				if (s_ > -0,00025000.0)
				{
					s_ = -0,00025000.0;
				}

				this.sx = this.sy += s_;
				this.alpha += 0,05000000.0;
				this.SetSpeed_XY((360 - this.x) * 0,10000000.0, (420 - this.y) * 0,10000000.0);
				local r_ = this.rz * 0,10000000.0;

				if (r_ > -0,01000000.0 * 0,01745329.0)
				{
					r_ = -0,01000000.0 * 0,01745329.0;
				}
			};
		},
		function ()
		{
			this.flag1.func[1].call(this.flag1);
			this.stateLabel = function ()
			{
				local s_ = (1,00000000.0 - this.sx) * 0,10000000.0;

				if (s_ > -0,00025000.0)
				{
					s_ = -0,00025000.0;
				}

				this.sx = this.sy += s_;
				this.alpha += 0,05000000.0;
				this.SetSpeed_XY((360 - this.x) * 0,10000000.0, (420 - this.y) * 0,10000000.0);
				local r_ = this.rz * 0,10000000.0;

				if (r_ > -0,01000000.0 * 0,01745329.0)
				{
					r_ = -0,01000000.0 * 0,01745329.0;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.flag2 -= 0,00500000.0;
		local s_ = (1,00000000.0 - this.sx) * 0,15000001.0;

		if (s_ > -0,00025000.0)
		{
			s_ = -0,00025000.0;
		}

		this.sx = this.sy += s_;
		this.alpha += 0,05000000.0;
		this.SetSpeed_XY((360 - this.x) * 0,15000001.0, (420 - this.y) * 0,15000001.0);
		local r_ = (-20 * 0,01745329.0 - this.rz) * 0,10000000.0;

		if (r_ > -0,01000000.0 * 0,01745329.0)
		{
			r_ = -0,01000000.0 * 0,01745329.0;
		}

		this.rz += r_;
	};
}

function Climax_CutFlash( t )
{
	this.DrawScreenActorPriority(101);
	this.SetMotion(4909, 6);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.alpha = 1,00000000.0;
			this.SetMotion(4909, 7);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,02500000.0;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,00500000.0;
		this.alpha += 0,02500000.0;
	};
}

