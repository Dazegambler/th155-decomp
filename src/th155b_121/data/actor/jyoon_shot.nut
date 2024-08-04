function WinC_Object_Taxi( t )
{
	this.SetMotion(9012, 3);
	this.DrawActorPriority(189);
	this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
	this.PlaySE(4677);
	this.func = function ()
	{
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 65)
		{
			this.SetMotion(9012, 4);
			this.stateLabel = function ()
			{
				if (this.VX_Brake(1,50000000.0))
				{
					this.SetSpeed_XY(-3,00000000.0 * this.direction, 0,00000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(1,00000000.0);
					};
				}
			};
		}
	};
}

function BattleBeginObject_A( t )
{
	this.SetMotion(9002, 0);

	if (this.owner.demoObject == null)
	{
		this.owner.demoObject = [];
	}

	this.owner.demoObject.append(this.weakref());
	this.sx = this.sy = 0,75000000.0 + this.rand() % 15 * 0,10000000.0;
	this.rz = (360 - this.rand() % 720) * 0,01745329.0;
	this.red = this.rand() % 10 * 0,10000000.0;
	this.green = this.rand() % 10 * 0,10000000.0;
	this.blue = this.rand() % 10 * 0,10000000.0;
	this.stateLabel = function ()
	{
		this.rz *= 0,98000002.0;
		this.AddSpeed_XY(0,00000000.0, 0,10000000.0);
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

function BattleBeginObject_B( t )
{
	this.SetMotion(9002, 0);

	if (this.owner.demoObject == null)
	{
		this.owner.demoObject = [];
	}

	this.owner.demoObject.append(this.weakref());
	this.sx = this.sy = 0,75000000.0 + this.rand() % 15 * 0,10000000.0;
	this.rz = (360 - this.rand() % 720) * 0,01745329.0;
	this.red = this.rand() % 10 * 0,10000000.0;
	this.green = this.rand() % 10 * 0,10000000.0;
	this.blue = this.rand() % 10 * 0,10000000.0;
	this.stateLabel = function ()
	{
		this.rz *= 0,98000002.0;
		this.AddSpeed_XY(0,00000000.0, 0,10000000.0);
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

function BattleWinObject_B( t )
{
	this.DrawActorPriority(210);
	this.SetMotion(9011, 3);
	this.owner.demoObject = [];
	this.owner.demoObject.append(this.weakref());
	this.sx = this.sy = 0,00000000.0;
	this.rx = 75 * 0,01745329.0;
	this.rz = (360 - this.rand() % 720) * 0,01745329.0;
	this.flag1 = this.Vector3();
	this.flag1.x = this.x;
	this.flag1.y = this.y;
	this.flag2 = this.Vector3();
	this.stateLabel = function ()
	{
		this.flag2.x = (::camera.camera2d.left + ::camera.camera2d.right) * 0,50000000.0;
		this.flag2.y = (::camera.camera2d.top + ::camera.camera2d.bottom) * 0,50000000.0;
		this.rz += 28 * 0,01745329.0;
		this.flag3 += 0,04000000.0;
		this.sx = this.sy = this.flag3 * 6,00000000.0;
		local tx_ = this.flag1.x + (this.flag2.x - this.flag1.x) * (1 - this.cos(this.flag3 * 3,14159203.0 * 0,50000000.0));
		local ty_ = this.flag1.y + (this.flag2.y - this.flag1.y) * (1 - this.cos(this.flag3 * 3,14159203.0 * 0,50000000.0));
		this.Warp(tx_, ty_);

		if (this.flag3 >= 1,00000000.0)
		{
			this.PlaySE(1094);
			::camera.Shake(10);
			this.sx = this.sy = 1,00000000.0;
			this.y += 50;
			this.SetMotion(9011, 4);
			this.rx = 0,00000000.0;
			this.rz = 15 * 0,01745329.0;
			this.stateLabel = null;
		}
	};
}

function Grab_Gold( t )
{
	this.SetMotion(1802, 6);
	this.DrawActorPriority(180);
	this.keyAction = this.ReleaseActor;
}

class this.shot_normal 
{
}

function Shot_Normal( t )
{
	this.flag1 = this.rand() % 4;
	this.SetMotion(2008, this.flag1);
	this.atk_id = 16384;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.direction = 1,00000000.0;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, this.flag1 + 4);
		this.stateLabel = function ()
		{
			this.Vec_Brake(1,00000000.0);
			this.sx = this.sy += 0,06000000.0;
			this.alpha -= 0,15000001.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitResult)
		{
			this.func();
			return true;
		}

		return false;
	};
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,15000001.0, 1,00000000.0);
		this.rz += 0,05235988.0;
		this.subState();
	};
	this.keyAction = this.func;
}

function Shot_Front( t )
{
	this.SetMotion(2019, 0);
	this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
	this.keyAction = this.ReleaseActor;
	this.cancelCount = 3;
	this.atk_id = 65536;
	this.func = [
		function ()
		{
			this.alpha = 1,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.callbackMask = 0;
			this.SetKeyFrame(1);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -0,75000000.0);
				this.sx = this.sy *= 0,92500001.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.sx = this.sy = 1,00000000.0;
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
				this.sx = this.sy -= 0,20000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.sx = this.sy = 0,10000000.0;
					this.SetMotion(this.motion, 2);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.subState())
						{
							return;
						}

						this.count++;

						if (this.cancelCount <= 0 || this.hitCount > 0 || this.hitResult & 32 || this.count >= 60)
						{
							this.func[0].call(this);
							return true;
						}

						this.sx = this.sy += (1,00000000.0 - this.sx) * 0,15000001.0;
						this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
					};
				}
			};
		},
		function ()
		{
			this.cancelCount = 3;
			this.HitCycleUpdate(0);
			this.keyAction = this.ReleaseActor;
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.Damage_ConvertOP(this.x, this.y, 10) || this.cancelCount <= 0)
				{
					this.func[0].call(this);
					return true;
				}

				this.sx = this.sy += (2,00000000.0 - this.sx) * 0,15000001.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
				this.count++;

				if (this.hitCount < 3)
				{
					this.HitCycleUpdate(3);
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 10) || this.cancelCount <= 0 || this.hitResult & 32 || this.hitCount >= 3)
		{
			this.func[0].call(this);
			return true;
		}
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.count++;

		if (this.count == 30)
		{
			if (this.hitCount == 0)
			{
				this.func[2].call(this);
				return;
			}
			else
			{
				this.callbackMask = 0;
			}
		}

		this.VX_Brake(0,33000001.0, 0,50000000.0 * this.direction);
		this.HitCycleUpdate(3);
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, 0);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = t.rot;
	this.SetSpeed_Vec(t.v, this.rz, this.direction);
	this.keyAction = this.ReleaseActor;
	this.cancelCount = 1;
	this.atk_id = 262144;
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
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		this.Vec_Brake(0,80000001.0, 4,00000000.0);

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2029, 1);
	this.sx = this.sy = 0,00000000.0;
	this.flag1 = {};
	this.flag1.bound <- 2;
	this.flag1.roll <- 5,00000000.0 * 0,01745329.0;
	this.flag1.trail <- null;
	this.cancelCount = 3;
	this.flag2 = 0;
	this.subState = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 10))
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.ReleaseActor();
			return true;
		}
	};
	this.func = [
		function ()
		{
			this.cancelCount = 3;
			this.HitReset();
			this.flag1.roll <- 10,00000000.0 * 0,01745329.0;
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.rz += this.flag1.roll;

				if (this.hitCount >= 1 || this.cancelCount <= 0 || this.owner.motion == 2020 && this.owner.keyTake == 0)
				{
					this.func[1].call(this);
					return;
				}

				this.HitCycleUpdate(0);

				if ((this.va.y > 0,00000000.0 && this.y + 27 >= ::camera.camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 27 <= ::camera.camera2d.top) && this.flag1.bound > 0)
				{
					this.PlaySE(1108);
					this.flag1.bound--;
					this.SetSpeed_XY(null, -this.va.y);

					if (this.va.LengthXY() > 8,00000000.0)
					{
						this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
					}

					if (this.va.y > 0,00000000.0)
					{
						if (this.keyTake == 2)
						{
							this.SetMotion(this.motion, 3);
						}
						else
						{
							this.SetMotion(this.motion, 5);
						}
					}
					else if (this.keyTake == 3)
					{
						this.SetMotion(this.motion, 2);
					}
					else
					{
						this.SetMotion(this.motion, 4);
					}
				}
			};
			local v_ = 12,00000000.0;

			if (this.initTable.rot <= 0,00000000.0)
			{
				this.SetMotion(this.motion, 2);
			}
			else
			{
				this.SetMotion(this.motion, 3);
			}

			this.SetSpeed_Vec(v_, this.initTable.rot, this.direction);
		},
		function ()
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.flag1.trail = null;
			this.SetMotion(this.motion, 1);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, -5,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,25000000.0);
				this.rz -= 10 * 0,01745329.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.initTable.rot *= 0,33000001.0;
			this.cancelCount = 3;
			this.HitReset();
			this.flag1.roll = 10,00000000.0 * 0,01745329.0;
			local t_ = {};
			t_.rot <- this.initTable.rot;
			this.flag1.trail = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_ChargeTrail, t_).weakref();
			this.SetParent.call(this.flag1.trail, this, 0, 0);
			this.DrawActorPriority();
			this.subState = function ()
			{
				if (this.IsScreen(100))
				{
					if (this.flag1.trail)
					{
						this.flag1.trail.func[0].call(this.flag1.trail);
					}

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

				this.rz += this.flag1.roll;

				if (this.hitCount >= 1 || this.cancelCount <= 0 || this.owner.motion == 2020 && this.owner.keyTake == 0)
				{
					this.func[1].call(this);
					return;
				}

				this.HitCycleUpdate(0);

				if ((this.va.y > 0,00000000.0 && this.y + 27 >= ::camera.camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 27 <= ::camera.camera2d.top) && this.flag1.bound > 0)
				{
					this.PlaySE(1108);
					this.flag1.bound--;
					this.SetSpeed_XY(null, -this.va.y);

					if (this.flag1.trail)
					{
						this.flag1.trail.rz *= -1,00000000.0;
						this.flag1.trail.func[1].call(this.flag1.trail);
					}

					if (this.va.LengthXY() > 8,00000000.0)
					{
						this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
					}

					if (this.va.y > 0,00000000.0)
					{
						this.SetMotion(this.motion, 3);
					}
					else
					{
						this.SetMotion(this.motion, 2);
					}
				}
			};
			local t_ = {};
			t_.rot <- this.initTable.rot + 60 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeSub, t_);
			local t_ = {};
			t_.rot <- this.initTable.rot - 60 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeSub, t_);
			local t_ = {};
			t_.rot <- this.initTable.rot + 30 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeSub, t_);
			local t_ = {};
			t_.rot <- this.initTable.rot - 30 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeSub, t_);
			this.SetMotion(2028, 1);
			this.SetSpeed_Vec(7,00000000.0, this.initTable.rot, this.direction);
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion != 2020)
		{
			this.func[1].call(this);
			return;
		}

		local r_ = (3,14159203.0 * 2 - this.rz) * 0,20000000.0;

		if (r_ < 0,01745329.0)
		{
			this.rz += 0,01745329.0;
		}
		else
		{
			this.rz += r_;
		}

		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,20000000.0;

		if (this.sx > 1,00000000.0)
		{
			this.sx = this.sy = 1,00000000.0;
		}

		this.x = this.owner.point0_x;
		this.y = this.owner.point0_y;
	};
}

function Shot_ChargeSub( t )
{
	this.flag1 = {};
	this.flag1.rot <- t.rot;
	this.flag1.bound <- 2;
	this.flag1.roll <- 5,00000000.0 * 0,01745329.0;
	this.flag1.trail <- null;
	this.cancelCount = 3;
	local v_ = 7,00000000.0;

	if (t.rot == 0,00000000.0)
	{
		this.SetMotion(2028, 1);
	}
	else if (this.sin(t.rot) <= 0)
	{
		this.SetMotion(2028, 2);
	}
	else
	{
		this.SetMotion(2028, 3);
	}

	this.func = [
		function ()
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.flag1.trail = null;
			this.SetMotion(2029, 1);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, -5,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,25000000.0);
				this.rz -= 10 * 0,01745329.0;
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
		if (this.IsScreen(100))
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.ReleaseActor();
			return true;
		}
	};
	this.flag1.roll = 10,00000000.0 * 0,01745329.0;
	local t_ = {};
	t_.rot <- this.flag1.rot;
	this.flag1.trail = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_ChargeTrail, t_).weakref();
	this.SetParent.call(this.flag1.trail, this, 0, 0);
	this.DrawActorPriority();
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.rz += this.flag1.roll;

		if (this.hitCount >= 1 && this.keyTake <= 3 || this.hitCount >= 1 || this.cancelCount <= 0 || this.owner.motion == 2020 && this.owner.keyTake == 0)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(0);

		if ((this.va.y > 0,00000000.0 && this.y + 27 >= ::camera.camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 27 <= ::camera.camera2d.top) && this.flag1.bound > 0)
		{
			this.PlaySE(1108);
			this.flag1.bound--;
			this.SetSpeed_XY(null, -this.va.y);

			if (this.flag1.trail)
			{
				this.flag1.trail.rz *= -1,00000000.0;
				this.flag1.trail.func[1].call(this.flag1.trail);
			}

			if (this.va.LengthXY() > 8,00000000.0)
			{
				this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
			}

			if (this.va.y > 0,00000000.0)
			{
				this.SetMotion(this.motion, 3);
			}
			else
			{
				this.SetMotion(this.motion, 2);
			}
		}
	};
	this.SetSpeed_Vec(v_, this.flag1.rot, this.direction);
}

function Shot_ChargeTrail( t )
{
	this.rz = t.rot;
	this.SetMotion(2028, 4);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.sx = 0,50000000.0;
			this.sy = 1,00000000.0;
			this.alpha = 0,00000000.0;
			this.red = this.blue = this.green = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha += 0,20000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.subState = function ()
					{
						this.alpha = this.green = this.blue -= 0,02500000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.func[1].call(this);
						}
					};
				}
			};
		}
	];
	this.func[1].call(this);
	this.stateLabel = function ()
	{
		this.sx += (1,50000000.0 - this.sx) * 0,10000000.0;
		this.sy *= 0,99000001.0;
		this.subState();
	};
}

function Shot_ChargeCore( t )
{
	this.SetMotion(2029, 1);
	this.isVisible = false;
	this.rz = t.rot;
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 0) || this.owner.motion == 2025)
		{
			this.ReleaseActor();
			return true;
		}

		this.count++;

		if (this.count % 5 == 1)
		{
			this.flag1++;
			local t_ = {};
			t_.rot <- this.rz - this.flag1 * 15 * 0,01745329.0 + 45 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.FullChargeShot_Sub, t_);
			local t_ = {};
			t_.rot <- this.rz + this.flag1 * 15 * 0,01745329.0 - 45 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.FullChargeShot_Sub, t_);

			if (this.flag1 >= 9)
			{
				this.ReleaseActor();
			}
		}
	};
}

function FullChargeShot_Sub( t )
{
	this.SetMotion(2028, 0);
	this.flag1 = {};
	this.flag1.rot <- t.rot;
	this.flag1.bound <- 2;
	this.flag1.roll <- 5,00000000.0 * 0,01745329.0;
	this.cancelCount = 3;
	this.flag2 = 0;
	this.subState = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}
	};
	this.func = [
		function ()
		{
		},
		function ()
		{
			this.SetMotion(2029, 1);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, -5,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,25000000.0);
				this.rz -= 10 * 0,01745329.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.rz += this.flag1.roll;

		if (this.grazeCount > 0 || this.hitCount >= 1 && this.keyTake <= 3 || this.hitCount >= 1 || this.cancelCount <= 0 || this.owner.motion == 2020 && this.owner.keyTake == 0 || this.owner.motion == 2025)
		{
			this.func[1].call(this);
			return;
		}

		this.HitCycleUpdate(0);

		if ((this.va.y > 0,00000000.0 && this.y + 27 >= ::camera.camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 27 <= ::camera.camera2d.top) && this.flag1.bound > 0)
		{
			this.PlaySE(1108);
			this.flag1.bound--;
			this.SetSpeed_XY(null, -this.va.y);

			if (this.va.LengthXY() > 8,00000000.0)
			{
				this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
			}
		}
	};
	local v_ = 12,00000000.0;

	if (this.sin(this.flag1.rot) <= 0)
	{
		this.SetMotion(this.motion, 0);
	}
	else
	{
		this.SetMotion(this.motion, 0);
	}

	this.SetSpeed_Vec(6,00000000.0, this.flag1.rot, this.direction);
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.SetSpeed_Vec(12,50000000.0, t.rot, this.direction);
	this.keyAction = this.ReleaseActor;
	this.cancelCount = 3;
	this.atk_id = 536870912;
	this.func = [
		function ()
		{
			this.alpha = 1,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.callbackMask = 0;
			this.SetKeyFrame(1);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -0,75000000.0);
				this.sx = this.sy -= 0,05000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 10) || this.cancelCount <= 0 || this.grazeCount >= 10 || this.hitCount >= 5 || this.count == 60)
		{
			this.func[0].call(this);
			return true;
		}
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.Vec_Brake(0,33000001.0, 1,50000000.0);
		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,05000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.HitCycleUpdate(7);
		this.count++;

		if (this.count <= 50 && this.count % 6 == 5)
		{
			this.PlaySE(4672);
			this.SetShot(this.x + 60 - this.rand() % 121, this.y - this.rand() % 30, this.direction, this.Shot_ChangeStone, {});
		}
	};
}

function Shot_ChangeStone( t )
{
	this.SetMotion(3929, 1 + this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_XY(3,00000000.0 - this.rand() % 61 * 0,10000000.0, -12,50000000.0 - this.rand() % 20 * 0,10000000.0);
	this.flag1 = (10 + this.rand() % 7) * 0,01745329.0;

	if (this.rand() % 10 <= 4)
	{
		this.flag1 *= -1;
	}

	this.cancelCount = 1;
	this.atk_id = 536870912;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, this.flag1);
	this.func = function ()
	{
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 1) || this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0 || this.y > ::battle.scroll_bottom + 25)
		{
			this.func();
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
}

function Shot_ChangeFin( t )
{
	this.SetMotion(3939, 1);
	this.flag1 = {};
	this.flag1.trail <- null;
	local t_ = {};
	t_.rot <- t.rot;
	this.flag1.trail = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_ChangeFinTrail, t_).weakref();
	this.cancelCount = 3;
	this.SetSpeed_Vec(15,00000000.0, this.initTable.rot, this.direction);
	this.subState = function ()
	{
		if (this.IsScreen(100 * this.sx) || this.Damage_ConvertOP(this.x, this.y, 10))
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.ReleaseActor();
			return true;
		}
	};
	this.func = [
		function ()
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.flag1.trail = null;
			this.SetMotion(this.motion, 1);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, -5,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,25000000.0);
				this.rz -= 10 * 0,01745329.0;
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
		if (this.subState())
		{
			return;
		}

		if (this.hitCount >= 1 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.rz += 0,17453292.0;
		this.HitCycleUpdate(0);
		this.sx = this.sy += 0,02500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

function Shot_ChangeFinTrail( t )
{
	this.rz = t.rot;
	this.SetMotion(3939, 2);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.sx = 0,50000000.0;
			this.sy = 1,00000000.0;
			this.alpha = 0,00000000.0;
			this.red = this.blue = this.green = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha += 0,20000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.subState = function ()
					{
						this.alpha = this.green = this.blue -= 0,02500000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.func[1].call(this);
						}
					};
				}
			};
		}
	];
	this.func[1].call(this);
	this.stateLabel = function ()
	{
		this.sx += (1,50000000.0 - this.sx) * 0,10000000.0;
		this.sy *= 0,99000001.0;
		this.subState();
	};
}

function SPShot_A( t )
{
	this.SetMotion(3009, 0);
	this.SetSpeed_XY(18,00000000.0 * this.direction, 0,00000000.0);
	this.cancelCount = 3;
	this.atk_id = 1048576;
	this.func = [
		function ()
		{
			if (this.owner.bag == this)
			{
				this.owner.bag = null;
			}

			this.SetMotion(3009, 1);
			this.SetSpeed_XY(-0,25000000.0 * this.direction, -10,00000000.0);
			this.stateLabel = function ()
			{
				this.rz += 16,00000000.0 * 0,01745329.0;
				this.AddSpeed_XY(0,00000000.0, this.va.y < 1,00000000.0 ? 0,75000000.0 : 0,01000000.0);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(3009, 1);
			this.SetSpeed_XY(-0,25000000.0 * this.direction, -5,00000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 5 && this.owner.bag == this)
				{
					this.owner.SP_A_Dash(null);
					return;
				}

				this.rz += 16,00000000.0 * 0,01745329.0;
				this.AddSpeed_XY(0,00000000.0, this.va.y < 1,00000000.0 ? 0,75000000.0 : 0,01000000.0);
			};
		},
		function ()
		{
			this.SetMotion(3009, 1);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.rz += 16,00000000.0 * 0,01745329.0;
				this.AddSpeed_XY(0,00000000.0, this.va.y < 1,00000000.0 ? 0,75000000.0 : 0,01000000.0);
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
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 4))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;

		if (this.count == 120)
		{
			if (this.owner.bag == this)
			{
				this.owner.bag = null;
			}
		}

		if (this.hitCount > 0)
		{
			if (this.hitResult & 1)
			{
				if (this.owner.bag == this)
				{
					this.func[1].call(this);
					return;
				}
				else
				{
					this.func[0].call(this);
					return;
				}
			}
			else
			{
				this.func[0].call(this);
				return;
			}
		}

		this.count++;
	};
}

function SPShot_B_GemFire( t )
{
	this.SetMotion(3018, 10);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.alpha = 2,50000000.0;
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			this.sx += (3,00000000.0 - this.sx) * 0,20000000.0;
			this.sy *= 0,89999998.0;
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
}

function SPShot_B_Gem( t )
{
	this.SetMotion(3018, 2 + this.rand() % 4);
	this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_GemFire, {});
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,50000000.0 + this.rand() % 6 * 0,10000000.0;
	this.SetSpeed_XY(0,00000000.0, -5,00000000.0 - this.rand() % 10 * 0,10000000.0);
	this.flag1 = (6 - this.rand() % 15) * 0,01745329.0;
	this.cancelCount = 1;
	this.atk_id = 262144;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, this.flag1);
	this.func = function ()
	{
		this.SetMotion(3018, 1);
		this.sx = this.sy = 1,00000000.0;
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,89999998.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 1) || this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0 || this.y > ::battle.scroll_bottom + 25)
		{
			this.func();
			return;
		}

		this.count++;
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0 + 0,20000000.0);
	};
}

function SPShot_B_Bill( t )
{
	this.SetMotion(3018, 6 + this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_XY(0,00000000.0, -2,00000000.0 - this.rand() % 10 * 0,10000000.0);
	this.sx = this.sy = 0,80000001.0 + this.rand() % 7 * 0,10000000.0;
	this.flag1 = (8 + this.rand() % 12) * 0,01745329.0;

	if (this.rand() % 100 <= 50)
	{
		this.flag1 = -this.flag1;
	}

	this.alpha = 3,00000000.0;
	this.stateLabel = function ()
	{
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,20000000.0, null, 4,00000000.0);
		this.rz += this.flag1;
		this.flag1 *= 0,93000001.0;
	};
}

function SPShot_B( t )
{
	this.SetMotion(3019, 2);
	this.cancelCount = 3;
	this.atk_id = 2097152;
	this.func = [
		function ()
		{
			this.func[0] = function ()
			{
			};

			if (this.hitCount == 0)
			{
				this.PlaySE(4638);
				local y_ = 100;

				for( local i = 0; i < 12; i++ )
				{
					this.SetShot(this.x - 50 + this.rand() % 100, this.y - y_ - this.rand() % 50, this.direction, this.SPShot_B_Gem, {});
					y_ = y_ + 40;
				}
			}

			local y_ = 100;

			for( local i = 0; i < 18; i++ )
			{
				this.SetFreeObject(this.x - 75 + this.rand() % 150, this.y - y_ - this.rand() % 50, this.direction, this.SPShot_B_Bill, {});
				y_ = y_ + 40;
			}

			this.SetKeyFrame(2);
			this.stateLabel = function ()
			{
			};
		}
	];
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.keyFrame >= 2)
		{
			this.stateLabel = function ()
			{
			};
			return;
		}

		if (this.Damage_ConvertOP(this.x, this.y, 5) || this.cancelCount <= 0 || this.hitCount >= 4 || this.count >= 15)
		{
			this.func[0].call(this);
			return true;
		}

		if (this.hitCount <= 3)
		{
			this.HitCycleUpdate(3);
		}
	};
}

function SPShot_C( t )
{
	this.SetMotion(3029, 0);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.rz += this.flag1;
				this.AddSpeed_XY(0,00000000.0, 0,02500000.0);
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(3029, 1);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 1,00999999.0;
				this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 15))
		{
			this.ReleaseActor();
			return true;
		}

		this.count++;

		if (this.count >= 20)
		{
			this.PlaySE(4641);
			this.SetShot(this.x, this.y, this.direction, this.SPShot_C_Fire, {});
			this.func[0].call(this);
			return;
		}
	};
}

function SPShot_C_Fire( t )
{
	this.SetMotion(3029, 1);
	this.keyAction = this.ReleaseActor;
	this.cancelCount = 3;
	this.atk_id = 4194304;
}

function SPShot_D_Foot( t )
{
	this.SetMotion(3039, 0);
	this.keyAction = this.ReleaseActor;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetKeyFrame(1);
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,05000000.0;
				this.AddSpeed_XY(0,00000000.0, -0,75000000.0);

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function SPShot_E_Trail( t )
{
	this.SetMotion(3049, 3);
	this.DrawActorPriority(180);
	this.rz = t.rot;
	this.rx = 0,78539813.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,01000000.0;
		this.rz -= 0,03490658.0;
		this.alpha = this.green -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_E( t )
{
	this.SetMotion(3049, 1);
	this.SetSpeed_Vec(24,00000000.0, t.rot, this.direction);
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,34906584.0);
	this.rx = 0,78539813.0;
	this.cancelCount = 3;
	this.atk_id = 16777216;
	this.flag1 = 0;
	this.flag2 = this.y;
	this.flag3 = this.Vector3();
	this.flag3.x = this.va.x;
	this.flag3.y = this.va.y;
	this.SetSpeed_XY(this.flag3.x, this.flag3.y * 0,50000000.0);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.rz += 0,34906584.0;
				this.Vec_Brake(1,00000000.0, 0,50000000.0);
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
		if (this.Damage_ConvertOP(this.x, this.y, 10))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.owner.motion != 3040 && this.owner.motion != 3041)
		{
			this.func[0].call(this);
			return;
		}

		if (this.keyTake == 1 && this.y < this.flag2 && this.va.y < 0)
		{
			this.SetMotion(this.motion, 0);
		}

		this.flag3.RotateByRadian(this.initTable.rotSpeed * this.direction);
		this.SetSpeed_XY(this.flag3.x, this.flag3.y * 0,50000000.0);
		this.flag1 += this.initTable.rotSpeed;
		this.count++;

		if (this.hitCount <= 3)
		{
			this.HitCycleUpdate(5);
		}

		if (this.count % 4 == 1)
		{
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E_Trail, t_);
		}

		if (this.fabs(this.flag1) >= 6,28318548.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A( t )
{
	this.SetMotion(t.motion, 0);
	this.flag1 = {};
	this.flag2 = 20,00000000.0;
	this.flag1.range <- 20,00000000.0;
	this.flag1.rot <- t.rot;
	this.sx = this.sy = 0,00000000.0;
	this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
	this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);

	if (this.team == 1)
	{
		this.group = 256;
	}
	else
	{
		this.group = 512;
	}

	this.subState = function ()
	{
		if (this.owner.motion == 4000)
		{
			if (this.owner.keyTake == 2)
			{
				this.stateLabel = function ()
				{
					this.sx = this.sy += 0,10000000.0;
					this.alpha -= 0,10000000.0;

					if (this.alpha <= 0,00000000.0)
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

		this.sx += 0,02500000.0;

		if (this.sx > 2,00000000.0)
		{
			this.sx = 2,00000000.0;
		}

		this.sy = this.sx;
		this.flag1.range += this.flag2;
		this.flag2 -= 2,00000000.0;

		if (this.flag2 < 2,00000000.0)
		{
			this.flag2 = 2,00000000.0;
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

				this.sy = this.sx *= 0,94999999.0;
				this.flag1.range *= 0,80000001.0;
				this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
				this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);
			};
		}

		this.flag1.rot -= 0,07500000.0;
	};
}

function SpellShot_A_Bullet( t )
{
	this.SetMotion(t.motion, 1);
	this.sx = this.sy = 2,00000000.0;
	this.SetSpeed_Vec(20,00000000.0, t.rot, this.direction);
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
		this.count++;

		if (this.count >= 40)
		{
			this.TargetHoming(this.target, 180,00000000.0 * 0,01745329.0, this.direction);
			this.stateLabel = function ()
			{
				this.count++;
				this.TargetHoming(this.target, 2,00000000.0 * 0,01745329.0, this.direction);
				local t_ = {};
				t_.motion <- this.motion;
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_A_Trail, t_);
				this.AddSpeed_Vec(2,00000000.0, null, 30,00000000.0, this.direction);

				if (this.count >= 120)
				{
					this.ReleaseActor();
				}

				return;
			};
		}

		this.TargetHoming(this.target, 3,00000000.0 * 0,01745329.0, this.direction);
		local t_ = {};
		t_.motion <- this.motion;
		this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_A_Trail, t_);
	};
}

function SpellShot_A_Flash( t )
{
	this.SetMotion(t.motion, 2);
	this.flag1 = 1,50000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 1,10000002.0;
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A_Trail( t )
{
	this.SetMotion(t.motion, 4);
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,92000002.0;
		this.alpha -= 0,08000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A( t )
{
}

function SpellShot_B( t )
{
	this.SetMotion(4019, 1);
	this.DrawActorPriority(180);
	this.SetSpeed_XY(12,50000000.0 * this.direction, 1,50000000.0);
	this.cancelCount = 99;
	this.atk_id = 67108864;
	this.subState = function ()
	{
		this.sx = this.sy += 0,01500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.HitCycleUpdate(5);
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200 * this.sx))
		{
			this.PlaySE(4674);
			this.ReleaseActor();
			::camera.shake_radius = 15,00000000.0;
			return;
		}

		if (this.subState())
		{
			return;
		}
	};
}

function SpellC_DanceTable( t )
{
	this.SetMotion(4027, 0);
	this.DrawActorPriority(181);
	this.EnableTimeStop(false);
	this.SetSpeed_XY(0,00000000.0, -30,00000000.0);
	this.func = [
		function ()
		{
			this.SetMotion(4027, 1);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 1,00000000.0, 0,00000000.0, 30,00000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Warp(this.owner.x, this.y);

		if (this.y < this.owner.centerY)
		{
			this.Warp(this.x, this.owner.centerY);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.Warp(this.owner.x, this.y);
			};
		}
	};
}

function SpellShot_C_Spot( t )
{
	this.SetMotion(4029, 0);
	this.atk_id = 67108864;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.HitReset();
			this.SetMotion(4029, 0);
		}
	];
	this.sx = this.sy = 2,00000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.stateLabel = function ()
	{
		this.count++;
		this.rz = this.cos(this.count * 0,10471975.0) * 0,52359873.0;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	};
}

function SpellShot_C( t )
{
	this.SetMotion(4028, 0);
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.ReleaeActor();
		},
		function ()
		{
		}
	];
	this.keyAction = this.ReleaseActor;
}

function SpellShot_C_Steam( t )
{
	this.SetMotion(4028, 1);
	this.cancelCount = 10;
	this.atk_id = 67108864;
	this.keyAction = this.ReleaseActor;
}

function Climax_Paper( t )
{
	this.SetMotion(4903, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.SetSpeed_XY(10,00000000.0 * this.direction, -1,25000000.0);
	this.flag1 = 6,00000000.0 * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,44999999.0, 0,75000000.0 * this.direction);
		this.AddSpeed_XY(0,00000000.0, 0,05000000.0, null, 0,50000000.0);
		this.flag1 *= 0,94000000.0;
		this.rz += this.flag1;
	};
}

function Climax_Coin( t )
{
	this.SetMotion(4903, 1 + this.rand() % 3);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,75000000.0 + this.rand() % 50 * 0,01000000.0;
	this.SetSpeed_Vec(10,00000000.0 + this.rand() % 4, (-10 - this.rand() % 60) * 0,01745329.0, this.direction);
	this.stateLabel = function ()
	{
		if (this.owner.shion.motion == 5320 && this.owner.shion.keyTake == 1)
		{
			this.vec.x = this.owner.shion.point0_x - this.x;
			this.vec.y = this.owner.shion.point0_y - this.y;

			if (this.vec.Length() <= 25)
			{
				this.PlaySE(4650);
				this.SetMotion(4903, 8);
				this.keyAction = this.ReleaseActor;
				this.stateLabel = null;
				this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
				return;
			}
		}

		this.rz += 2,00000000.0 * 0,01745329.0;
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

		if (this.y >= ::battle.scroll_bottom + 50)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_CoinB( t )
{
	this.SetMotion(4903, 1 + this.rand() % 3);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,75000000.0 + this.rand() % 50 * 0,01000000.0;
	this.SetSpeed_Vec(5,00000000.0 + this.rand() % 10, (-45 - this.rand() % 90) * 0,01745329.0, this.direction);
	this.stateLabel = function ()
	{
		if (this.owner.shion.motion == 5321 && this.owner.shion.keyTake == 1)
		{
			this.vec.x = this.owner.shion.point0_x - this.x;
			this.vec.y = this.owner.shion.point0_y - this.y;

			if (this.vec.Length() <= 60)
			{
				this.PlaySE(4650);
				this.SetMotion(4903, 8);
				this.keyAction = this.ReleaseActor;
				this.stateLabel = null;
				this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
				return;
			}
		}

		this.rz += 2,00000000.0 * 0,01745329.0;
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

		if (this.y >= ::battle.scroll_bottom + 50)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_CoinC( t )
{
	this.SetMotion(4903, 4 + this.rand() % 3);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,75000000.0 + this.rand() % 50 * 0,01000000.0;
	this.SetSpeed_Vec(3,00000000.0 + this.rand() % 4, (60 - this.rand() % 120) * 0,01745329.0, this.direction);
	this.stateLabel = function ()
	{
		this.rz += 2,00000000.0 * 0,01745329.0;
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
		this.alpha -= 0,02000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_Binbou( t )
{
	this.SetMotion(4904, 1);
	this.DrawActorPriority(180);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4904, 3);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count % 7 == 1)
				{
					this.Set_Vibration(3,00000000.0);
					local i = 6;

					while (i > 0)
					{
						i--;
						this.SetFreeObject(this.point0_x + 25 - this.rand() % 51, this.point0_y - 50 + this.rand() % 101, this.direction, this.owner.Climax_CoinC, null);
					}

					this.SetEffect(this.x + 50 * this.direction, this.y, this.direction, ::effect.EF_HitSmashA, null);
					this.owner.target.DamageGrab_Common(301, 0, this.direction);
				}

				this.owner.target.Warp(this.x + 30 * this.direction, this.y);
			};
		}
	];
	this.owner.target.DamageGrab_Common(310, 0, this.direction);
	this.owner.target.Warp(this.x + 30 * this.direction, this.y);
	this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 12)
		{
			this.owner.target.DamageGrab_Common(301, 0, this.direction);
		}

		this.owner.target.Warp(this.x + 30 * this.direction, this.y);
		this.alpha += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.VX_Brake(1,00000000.0, 0,00000000.0);
	};
}

function Climax_CutBack( t )
{
	this.SetMotion(4905, 0);
	this.DrawScreenActorPriority(100);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 1,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,03300000.0;
	};
}

function Climax_CutPaper( t )
{
	this.SetMotion(4905, 3);
	this.DrawScreenActorPriority(110);
	this.flag1 = 0,00000000.0;
	this.flag2 = 0,69999999.0;
	this.sx = this.sy = 1,00000000.0;
	this.SetSpeed_XY(-0,30000001.0 * this.direction, 0,20000000.0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetSpeed_XY(180,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				local r_ = (-35 * 0,01745329.0 - this.rz) * 0,20000000.0;

				if (r_ > -0,05000000.0 * 0,01745329.0)
				{
					r_ = -0,05000000.0 * 0,01745329.0;
				}

				this.rz += r_;
				this.flag2 += 0,00025000.0;
				this.sx = this.sy += (this.flag2 - this.sx) * 0,20000000.0;
				this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);

				if (this.va.x < 0,25000000.0)
				{
					this.SetSpeed_XY(0,25000000.0, this.va.y);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.rz += 0,00500000.0 * 0,01745329.0;
		return;
		this.flag1 += 0,01660000.0;

		if (this.flag1 > 1,00000000.0)
		{
			this.flag1 = 1,00000000.0;
		}

		this.sx = this.sy = this.Math_Bezier(1,00000000.0, 3,00000000.0, 2,79999995.0, this.flag1);

		if (this.flag1 < 0,89999998.0)
		{
			this.rz = this.Math_Bezier(-90 * 0,01745329.0, 25,00000000.0 * 0,01745329.0, 8,00000000.0 * 0,01745329.0, this.flag1);
		}
		else
		{
			this.rz += 0,02500000.0 * 0,01745329.0;
		}

		this.va.x = this.Math_Bezier(40,00000000.0, 0,50000000.0, 0,75000000.0, this.flag1);
		this.ConvertTotalSpeed();
	};
}

function Climax_CutFace( t )
{
	this.SetMotion(4905, 2);
	this.DrawScreenActorPriority(109);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
		}
	];
	this.flag1 = 0,94999999.0;
	this.SetSpeed_XY(-40,00000000.0, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.rz += (-20 * 0,01745329.0 - this.rz) * 0,30000001.0;
		this.flag1 -= 0,00020000.0;
		this.sx = this.sy += (this.flag1 - this.sx) * 0,30000001.0;
		this.SetSpeed_XY(this.va.x * 0,69999999.0, this.va.y * 0,69999999.0);

		if (this.va.x > -0,10000000.0)
		{
			this.SetSpeed_XY(-0,10000000.0, this.va.y);
		}
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Shot_Final_main( t )
{
	this.flag1 = this.rand() % 4;
	this.SetMotion(4979, this.flag1);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
	this.direction = 1,00000000.0;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, this.flag1 + 4);
		this.stateLabel = function ()
		{
			this.Vec_Brake(1,00000000.0);
			this.sx = this.sy += 0,06000000.0;
			this.alpha -= 0,15000001.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitResult)
		{
			this.func();
			return true;
		}

		return false;
	};
	this.stateLabel = function ()
	{
		this.rz += 0,05235988.0;
		this.subState();
	};
	this.keyAction = this.func;
}

function Shot_Final_Spell( t )
{
	this.SetMotion(4019, 1);
	this.DrawActorPriority(180);
	this.SetSpeed_XY(12,50000000.0 * this.direction, 1,50000000.0);
	this.cancelCount = 99;
	this.subState = function ()
	{
		this.team.AddSP(-10);

		if (this.team.sp > 0)
		{
			this.HitCycleUpdate(10);
			this.sx = this.sy += 0,01500000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200 * this.sx))
		{
			this.ReleaseActor();
			return;
		}

		::camera.shake_radius = 5,00000000.0;

		if (this.subState())
		{
			return;
		}
	};
}

