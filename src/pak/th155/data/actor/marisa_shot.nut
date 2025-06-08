function BattleBeginObject_A( t )
{
	this.SetMotion(9011, 3);

	if (this.owner.demoObject == null)
	{
		this.owner.demoObject = [];
	}

	this.owner.demoObject.append(this.weakref());
	this.sx = this.sy = 0.75000000 + this.rand() % 15 * 0.10000000;
	this.rz = (360 - this.rand() % 720) * 0.01745329;
	this.red = this.rand() % 10 * 0.10000000;
	this.green = this.rand() % 10 * 0.10000000;
	this.blue = this.rand() % 10 * 0.10000000;
	this.stateLabel = function ()
	{
		this.rz *= 0.98000002;
		this.AddSpeed_XY(0.00000000, 0.10000000);
		this.count++;

		if (this.count >= 30)
		{
			this.alpha -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function BattleWinObject_A( t )
{
	this.SetMotion(9011, 3);

	if (this.owner.demoObject == null)
	{
		this.owner.demoObject = [];
	}

	this.owner.demoObject.append(this.weakref());
	this.sx = this.sy = 1.25000000 + this.rand() % 15 * 0.10000000;
	this.rz = (360 - this.rand() % 720) * 0.01745329;
	this.red = this.rand() % 10 * 0.10000000;
	this.green = this.rand() % 10 * 0.10000000;
	this.blue = this.rand() % 10 * 0.10000000;
	this.SetSpeed_XY(1.00000000 - this.rand() % 21 * 0.10000000, -4.00000000 - this.rand() % 15 * 0.10000000);
	this.stateLabel = function ()
	{
		this.rz *= 0.98000002;
		this.AddSpeed_XY(0.00000000, 0.10000000);
		this.count++;
		this.sx = this.sy *= 0.99000001;

		if (this.count >= 30)
		{
			this.alpha -= 0.01000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
	this.SetFreeObject(this.x - 25 + this.rand() % 50, this.y - 25 + this.rand() % 50, this.direction, function ( t_ )
	{
		this.owner.demoObject.append(this.weakref());
		this.SetMotion(9011, 3);
		this.sx = this.sy = 0.75000000 + this.rand() % 15 * 0.10000000;
		this.rz = (360 - this.rand() % 720) * 0.01745329;
		this.red = this.rand() % 10 * 0.10000000;
		this.green = this.rand() % 10 * 0.10000000;
		this.blue = this.rand() % 10 * 0.10000000;
		this.SetSpeed_XY(1.00000000 - this.rand() % 21 * 0.10000000, 1.00000000 - this.rand() % 21 * 0.10000000);
		this.stateLabel = function ()
		{
			this.rz *= 0.98000002;
			this.AddSpeed_XY(0.00000000, 0.01000000);
			this.count++;
			this.sx = this.sy *= 0.95999998;

			if (this.count >= 60)
			{
				this.alpha -= 0.01000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			}
		};
	}, {});
}

function Grab_Smash( t )
{
	this.SetMotion(1809, 1);
	this.keyAction = this.ReleaseActor;
}

function NormalShot( t )
{
	this.SetMotion(2009, 0);
	this.atk_id = 16384;
	this.cancelCount = 3;
	this.SetSpeed_Vec(5.00000000, t.rot, this.direction);
	this.flag1 = t.rot;
	this.rz = t.rot;
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShotFire, t_);
	this.flag2 = this.Vector3();
	this.flag2.x = 0.25000000;
	this.flag2.RotateByRadian(t.rot);
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.06981317);
	this.flag5 = this.SetTrail(2009, 6, 12, 75).weakref();

	for( local i = 2; i < 5; i++ )
	{
		local t_ = {};
		t_.rot <- i * 0.26179937;
		t_.master_rot <- this.flag1 * this.direction;
		this.SetShot(this.x, this.y, this.direction, this.owner.NormalShotMini, t_);
		local t_ = {};
		t_.rot <- -i * 0.26179937;
		t_.master_rot <- this.flag1 * this.direction;
		this.SetShot(this.x, this.y, this.direction, this.owner.NormalShotMini, t_);
	}

	this.func = [
		function ()
		{
			this.SetMotion(2009, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.flag5)
				{
					this.flag5.anime.radius0 *= 0.60000002;
				}

				this.sx = this.sy *= 0.80000001;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += (1.75000000 - this.sx) * 0.10000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.PlaySE(1251);
			this.func[0].call(this);
			return;
			local t_ = {};
			t_.rot <- this.flag1;
			t_.vec <- this.va.LengthXY();
			this.SetShot(this.x, this.y, this.direction, this.owner.NormalShot_Exp, t_);
			this.ReleaseActor();
			return;
		}
	};
}

function NormalShotMini( t )
{
	this.SetMotion(2009, 5);
	this.atk_id = 16384;
	this.cancelCount = 1;
	this.flag1 = t.rot;
	this.rz = t.rot;
	this.flag2 = this.Vector3();
	this.flag2.x = 5.00000000 * this.direction;
	this.flag2.RotateByRadian(t.rot);
	this.SetSpeed_XY(this.flag2.x, this.flag2.y);
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.08726646);
	this.stateLabel = function ()
	{
		this.flag2.x += 0.20000000 * this.direction;

		if (this.fabs(this.flag2.y) <= 0.10000000)
		{
			this.flag2.y = 0.00000000;
		}
		else
		{
			this.flag2.y -= this.flag2.y > 0 ? 0.10000000 : -0.10000000;
		}

		this.va.x = this.flag2.x;
		this.va.y = this.flag2.y;
		this.va.RotateByRadian(this.initTable.master_rot);
		this.ConvertTotalSpeed();

		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.ReleaseActor();
			return;
		}
	};
}

function NormalShotFire( t )
{
	this.SetMotion(2009, 4);
	this.rz = t.rot;
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
}

function NormalShot_Trail( t )
{
	this.SetMotion(2009, 3);
	this.rz = 0.01745329 * this.rand() % 360;
	this.sx = this.sy = 0.50000000 + this.rand() % 20 * 0.10000000;
	this.SetSpeed_Vec(this.rand() % 30 * 0.10000000 + t.vec, t.rot + (this.rand() % 30 - 15) * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.rz += 0.10000000;
		this.Vec_Brake(0.30000001);

		if (this.alpha > 0.02500000)
		{
			this.alpha -= 0.02500000;
			this.green -= 0.02500000;
			this.red -= 0.02500000;
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function NormalShot_Exp( t )
{
	this.SetMotion(2009, 1);
	this.atk_id = 16384;
	this.cancelCount = 9;
	this.SetFreeObject(this.x, this.y, this.direction, function ( t )
	{
		this.SetMotion(2009, 2);
		this.rz = this.rand() % 360 * 0.01745329;
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0.12500000;
			this.alpha = this.red = this.green -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	}, {});
	this.SetFreeObject(this.x, this.y, this.direction, function ( t )
	{
		this.SetMotion(2009, 3);
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0.02500000;
			this.alpha = this.red = this.green -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	}, {});
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 2)
		{
			this.sx = this.sy *= 0.98000002;
			this.callbackGroup = 0;
			this.red = this.green -= 0.10000000;

			if (this.red <= 0.00000000)
			{
				this.red = this.green = 0;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			}
		}
		else
		{
			this.sx = this.sy += 0.10000000;
		}
	};
}

function Shot_BottlePart( t )
{
	this.SetMotion(2008, 9);
	this.sx = this.sy = 1.00000000 + this.rand() % 11 * 0.10000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_XY(-1.00000000 * this.direction, 0.00000000);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.20000000);
		this.sx = this.sy *= 0.92000002;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Bottle( t )
{
	this.sx = this.sy = 0.50000000;
	this.SetMotion(2008, 7);
	this.atk_id = 32768;
	this.PlaySE(1314);
	this.func = [
		function ()
		{
			this.sx = this.sy = 1.00000000;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.subState = function ()
			{
				this.sx = this.sy += 0.01000000;
			};
			this.count = 0;
			this.HitReset();
			this.PlaySE(1315);
			this.rz = 1.00000000;

			if (this.initTable.h > 0.00000000)
			{
				this.SetMotion(2008, 2);
			}
			else
			{
				this.SetMotion(2008, 1);
			}

			this.stateLabel = function ()
			{
				this.subState();
				this.count++;

				if (this.count == 3)
				{
					this.flag1 = -27.00000000 * 0.01745329;
					this.stateLabel = function ()
					{
						this.subState();
						this.flag1 *= 0.94999999;
						this.rz += this.flag1;
						this.alpha -= 0.07500000;

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.func[0].call(this);

			for( local i = 0; i < 12; i++ )
			{
				local t_ = {};
				t_.rot <- i * 30 * 0.01745329;
				this.SetShot(this.x, this.y, this.direction, this.owner.Shot_Bottle_Star, t_);
			}
		}
	];
	this.SetSpeed_XY(t.v.x * this.direction, t.v.y);
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.ReleaseActor();
		}

		if (this.count % 3 == 1)
		{
			this.SetFreeObject(this.x + 15 - this.rand() % 31, this.y + 15 - this.rand() % 31, this.direction, this.owner.Shot_BottlePart, {});
		}

		this.count++;

		if (this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.count >= 20)
		{
			this.func[1].call(this);
			return;
		}

		this.rz -= 16.00000000 * 0.01745329;
		this.AddSpeed_XY(null, 0.44999999);
	};
}

function Shot_Bottle_Star( t )
{
	this.SetMotion(2008, 6);
	this.rz = this.rand() % 360 * 0.01745329;
	this.va.x = 13.50000000;
	this.va.RotateByRadian(t.rot);
	this.va.y -= 3.00000000;
	this.SetSpeed_XY(null, null);
	this.sx = this.sy += this.rand() % 25 * 0.01000000;
	this.flag1 = (5 - this.rand() % 11) * 0.01745329;
	this.cancelCount = 1;
	this.atk_id = 32768;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.20000000);
				this.sx = this.sy *= 0.89999998;
				this.rz += this.flag1;
				this.flag1 *= 0.98000002;
				this.alpha -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.Vec_Brake(0.75000000, 2.00000000))
		{
			this.subState = function ()
			{
				this.count++;

				if (this.count >= 5)
				{
					this.func[0].call(this);
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		this.AddSpeed_XY(0.00000000, 0.20000000);

		if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
		this.rz += this.flag1;
		this.flag1 *= 0.98000002;
	};
}

function Shot_Laser( t )
{
	this.SetMotion(2018, 0);
	this.sx = 0.00000000;
	this.flag1 = true;
	this.flag2 = 0.10000000;
	this.flag3 = 0.40000001;
	this.rz = t.rot;
	local t_ = {};
	t_.main <- this.weakref();
	t_.rot <- this.rz;
	this.flag5 = {};
	this.flag5.root <- this.SetShot(this.x, this.y, this.direction, this.Shot_LaserRoot, t_).weakref();
	this.flag5.root.hitOwner = this.weakref();
	this.flag5.head <- this.SetShot(this.x, this.y, this.direction, this.Shot_LaserHead, t_).weakref();
	this.cancelCount = 9;
	this.atk_id = 65536;
	this.func = function ()
	{
		this.SetParent(null, 0, 0);

		if (this.flag5.root)
		{
			this.flag5.root.func[0].call(this.flag5.root);
		}

		if (this.flag5.head)
		{
			this.flag5.head.func[0].call(this.flag5.head);
		}

		this.stateLabel = function ()
		{
			this.sy *= 0.80000001;
			this.alpha -= 0.05000000;
			this.green -= 0.05000000;
			this.red -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
		this.callbackGroup = 0;
		this.flag1 = false;
	};
	this.SetCollisionScaling(0.01000000, 1.00000000, 1.00000000);
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
	this.stateLabel = function ()
	{
		if ((this.owner.motion == 2010 || this.owner.motion == 2011) && (this.owner.keyTake == 1 || this.owner.keyTake == 2))
		{
			this.sx += this.flag3;
			this.count++;
			this.SetCollisionScaling(this.sx, 1.00000000, 1.00000000);

			if (this.flag5.head)
			{
				this.flag5.head.x = this.x + 128 * this.sx * this.direction;
				this.flag5.head.y = this.y;
			}

			if (this.cancelCount <= 0 || this.flag4 > 0 && this.count > this.flag4)
			{
				this.func();
				return;
			}

			if (this.hitResult)
			{
				this.HitCycleUpdate(6);
			}
		}
		else
		{
			this.func();
		}
	};
}

function Shot_LaserRoot( t )
{
	this.flag1 = t.main.weakref();
	this.rz = t.rot;
	this.SetMotion(2018, 2);
	this.atk_id = 65536;
	this.SetParent(t.main, 0, 0);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx *= 0.80000001;
				this.sy = this.sx;

				if (this.sx <= 0.01000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function Shot_LaserHead( t )
{
	this.flag1 = t.main.weakref();
	this.rz = t.rot;
	this.SetMotion(2018, 1);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx *= 0.80000001;
				this.sy = this.sx;

				if (this.sx <= 0.01000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function ChargeHighShot_Root( t )
{
	this.flag1 = t.main.weakref();
	this.rz = t.rot;
	this.SetMotion(2019, 2);
	this.stateLabel = this.HighShot_RootUpdate;
}

function ChargeHighShot_Head( t )
{
	this.flag1 = t.main.weakref();
	this.rz = t.rot;
	this.SetMotion(2019, 1);
	this.stateLabel = this.HighShot_HeadUpdate;
}

function HighShot_RootUpdate()
{
	if (this.flag1)
	{
		this.Warp(this.flag1.x, this.flag1.y);

		if (!this.flag1.flag1)
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx *= 0.80000001;
				this.sy = this.sx;

				if (this.sx <= 0.01000000)
				{
					this.ReleaseActor();
				}
			};
		}
	}
	else
	{
		this.ReleaseActor();
	}
}

function HighShot_HeadUpdate()
{
	if (this.flag1)
	{
		this.Warp(this.flag1.x + 128 * this.flag1.sx * this.direction, this.flag1.y);

		if (!this.flag1.flag1)
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx *= 0.80000001;
				this.sy = this.sx;

				if (this.sx <= 0.01000000)
				{
					this.ReleaseActor();
				}
			};
		}
	}
	else
	{
		this.ReleaseActor();
	}
}

function Shot_BarrageFire( t )
{
	this.SetMotion(2026, 1);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.05000000;
		this.alpha -= 0.20000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, 0);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.SetSpeed_XY(t.v.x, t.v.y);
	this.flag1 = this.Vector3();
	this.flag1.x = t.v.x * 0.02000000;
	this.flag1.y = t.v.y * 0.02000000;
	this.keyAction = this.ReleaseActor;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_BarrageFire, {});
	this.cancelCount = 1;
	this.atk_id = 262144;
	this.func = function ()
	{
		this.SetMotion(this.motion, 1);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0.92000002;
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		this.rz += 0.17453292;

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}
	};
}

function Shot_ChargeFull_Star( t )
{
	this.SetMotion(2029, 7);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(2029, 8);
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.10000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.sx = this.sy = 0.80000001 + this.rand() % 41 * 0.01000000;
	this.flag1 = this.Vector3();
	this.flag1.x = -t.vec.x;
	this.flag1.y = -t.vec.y;
	this.flag1.RotateByDegree(-50 + this.rand() % 101);
	this.SetSpeed_XY(this.flag1.x * 2.50000000, this.flag1.y * 2.50000000);
	this.flag1.Mul(0.10000000);
	this.SetTaskAddRotation(0.00000000, 0.00000000, 5.00000000 * 0.01745329);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(this.flag1.x, this.flag1.y);

		if (this.IsScreen(100) || this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_ChargeFull( t )
{
	this.SetSpeed_Vec(2.00000000, t.rot, this.direction);
	this.flag1 = this.rz = t.rot;
	this.flag2 = 0;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_ChargeFire, t_);
	this.flag3 = this.Vector3();
	this.flag3.x = 1.00000000;
	this.flag3.y = 0.00000000;
	this.flag3.RotateByRadian(this.rz);
	this.flag3.x *= this.direction;

	if (t.rot == 0.00000000)
	{
		this.SetMotion(2029, 0);
	}
	else if (t.rot > 0.00000000)
	{
		this.SetMotion(2029, 2);
	}
	else
	{
		this.SetMotion(2029, 1);
	}

	this.cancelCount = 3;
	this.subState = function ()
	{
		this.AddSpeed_Vec(0.05000000, this.flag1, 45.00000000, this.direction);

		if (this.count >= 60)
		{
			this.subState = function ()
			{
				if (this.count % 2 == 1)
				{
					local t_ = {};
					t_.vec <- this.Vector3();
					t_.vec.x = this.flag3.x;
					t_.vec.y = this.flag3.y;
					this.SetShot(this.x + 25 - this.rand() % 51, this.y + 25 - this.rand() % 51, this.direction, this.Shot_ChargeFull_Star, t_);
				}

				this.AddSpeed_Vec(0.50000000, this.flag1, 45.00000000, this.direction);
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.count >= 180 || this.IsScreen(250))
		{
			this.ReleaseActor();
			return;
		}

		this.subState();
		this.count++;
		this.sx = this.sy += (1.75000000 - this.sx) * 0.05000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.cancelCount <= 0 || this.hitCount > 6)
		{
			local t_ = {};
			t_.rot <- this.flag1;
			t_.vec <- this.va.LengthXY();
			this.PlaySE(1306);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeFullExp, t_);
			this.ReleaseActor();
			return;
		}

		this.HitCycleUpdate(1);
	};
}

function Shot_Charge( t )
{
	this.SetSpeed_Vec(3.00000000, t.rot, this.direction);
	this.flag1 = this.rz = t.rot;
	this.flag2 = 0;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_ChargeFire, t_);

	if (t.rot == 0.00000000)
	{
		this.SetMotion(2028, 0);
	}
	else if (t.rot > 0.00000000)
	{
		this.SetMotion(2028, 2);
	}
	else
	{
		this.SetMotion(2028, 1);
	}

	this.cancelCount = 3;
	this.atk_id = 131072;
	this.stateLabel = function ()
	{
		if (this.count >= 180 || this.IsScreen(250) || this.Damage_ConvertOP(this.x, this.y, 10, 2))
		{
			this.ReleaseActor();
			return;
		}

		this.count++;
		this.AddSpeed_Vec(1.00000000, this.flag1, 45.00000000, this.direction);

		if (this.cancelCount <= 0 || this.hitCount > 0)
		{
			local t_ = {};
			t_.rot <- this.flag1;
			t_.vec <- this.va.LengthXY();
			this.PlaySE(1306);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeExp, t_);
			this.ReleaseActor();
			return;
		}

		this.HitCycleUpdate(10);
	};
}

function Shot_ChargeFire( t )
{
	this.SetMotion(2028, 4);
	this.rz = t.rot;
	this.keyAction = this.ReleaseActor;
}

function Shot_ChargeTrail( t )
{
	this.SetMotion(2028, 3);
	this.rz = 0.01745329 * this.rand() % 360;
	this.sx = this.sy = 0.20000000 + this.rand() % 20 * 0.10000000;
	this.SetSpeed_Vec(this.rand() % 30 * 0.10000000 + t.vec, t.rot + (this.rand() % 30 - 15) * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.rz += 0.10000000;
		this.Vec_Brake(0.30000001);

		if (this.alpha > 0.05000000)
		{
			this.alpha -= 0.05000000;
			this.green -= 0.05000000;
			this.red -= 0.05000000;
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function Shot_ChargeFullExp( t )
{
	this.cancelCount = 10;
	this.SetMotion(2029, 5);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
	};
}

function Shot_ChargeExp( t )
{
	this.cancelCount = 10;
	this.atk_id = 131072;
	this.SetMotion(2028, 5);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.SetTrail(this.motion, 2, 11, 30);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.SetSpeed_Vec(14.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.atk_id = 536870912;
	this.func = function ()
	{
		this.SetMotion(this.motion, 1);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.stateLabel = function ()
		{
			this.linkObject[0].anime.radius0 *= 0.50000000;
			this.sx = this.sy *= 0.92000002;
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.flag1 = this.va.y * 0.02500000;
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		this.rz += 0.17453292;

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}

		this.AddSpeed_XY(null, -this.flag1);
	};
}

function Shot_ChangeFin_Core( t )
{
	this.SetMotion(3939, 6);
	this.rz = t.rot;

	for( local i = -10; i <= 10; i = i + 10 )
	{
		local t_ = {};
		t_.rot <- i * 0.01745329 + this.rz;
		this.SetShot(this.x, this.y, this.direction, this.Shot_ChangeFin, t_, this.weakref());
		this.flag1++;
	}

	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Shot_ChangeFin( t )
{
	this.SetMotion(3939, 0);
	this.cancelCount = 3;
	this.atk_id = 536870912;
	this.SetSpeed_Vec(8.00000000, this.initTable.rot, this.direction);
	this.rz = t.rot;
	this.SetCollisionRotation(0, 0, this.rz);
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x;
	this.flag1.y = this.va.y;
	this.flag1.Normalize();
	this.subState = function ()
	{
		if (this.IsScreen(100 * this.sx) || this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.func[0].call(this);
			return true;
		}
	};
	this.func = [
		function ()
		{
			if (this.initTable.pare)
			{
				this.initTable.pare.flag1--;

				if (this.initTable.pare.flag1 <= 0)
				{
					this.initTable.pare.func[0].call(this.initTable.pare);
				}
			}

			this.ReleaseActor();
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

		this.HitCycleUpdate(0);
		this.AddSpeed_XY(this.flag1.x, this.flag1.y);
	};
}

function Shot_OkultA( t )
{
	this.SetMotion(2509, 1);
	this.PlaySE(1262);
	this.flag1 = 0;
	this.flag2 = null;
	this.SetSpeed_XY(15.00000000 * this.direction, -3.00000000);
	this.cancelCount = 3;
	this.atk_id = 524288;
	this.flag4 = 2;
	this.func = [
		function ()
		{
			this.PlaySE(1258);
			this.SetMotion(2509, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetEffect(this.x, this.y, this.direction, this.EF_HitSmashA, {});
			this.HitReset();
			this.hitCount = 0;
			this.stateLabel = function ()
			{
				if (this.owner.motion == 2500 && this.owner.keyTake == 0)
				{
					this.func[1].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.callbackGroup = 0;

			if (this.owner.okltItem == this)
			{
				this.owner.okltItem = null;
			}

			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.stateLabel = function ()
			{
				this.AddSpeed_XY(this.va.x * this.direction <= 3.00000000 ? 1.50000000 * this.direction : 0.00000000, 0.00000000);
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(50.00000000))
		{
			this.ReleaseActor();

			if (this.owner.okltItem == this)
			{
				this.owner.okltItem = null;
			}

			return;
		}

		if (this.cancelCount <= 0 || this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
		{
			this.callbackGroup = 0;

			if (this.owner.okltItem == this)
			{
				this.owner.okltItem = null;
			}

			this.SetSpeed_XY(-3.00000000 * this.direction, -6.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.rz -= 2.00000000 * 0.01745329;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			return;
		}

		this.VX_Brake(0.05000000);
		this.AddSpeed_XY(0.00000000, 0.30000001);
		this.count++;

		if (this.count >= 30 || this.hitResult & 13 && this.count >= 12)
		{
			this.func[0].call(this);
			return;
		}
	};
	this.keyAction = [
		null,
		null,
		function ()
		{
			this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultA_Shadow, {}).weakref();
			this.DrawActorPriority();
			this.SetParent.call(this.flag2, this, 0, 0);
			this.count = 0;
			this.PlaySE(1259);
			this.stateLabel = function ()
			{
				if (this.team.current.IsDamage())
				{
					this.func[1].call(this);
					return;
				}

				if (this.IsScreen(100.00000000) || this.cancelCount <= 0 || this.owner.motion == 2500 && this.owner.keyTake == 0)
				{
					this.func[1].call(this);
					return;
				}

				this.count++;

				if (this.hitCount <= this.flag4 && this.count % 30 == 0)
				{
					this.HitReset();
					this.PlaySE(1259);
				}

				this.AddSpeed_XY(this.va.x * this.direction <= 3.00000000 ? 1.50000000 * this.direction : 0.00000000, 0.00000000);
			};
		}
	];
}

function Shot_OkultA_Shadow( t )
{
	this.SetMotion(2509, 4);
	this.alpha = 0.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0.05000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}
	};
}

function Shot_OkultB( t )
{
	this.SetMotion(2509, 5);
	this.PlaySE(1262);
	this.cancelCount = 3;
	this.atk_id = 524288;
	this.func = [
		function ()
		{
			if (this.owner.okltItem == this)
			{
				this.owner.okltItem = null;
			}

			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(2509, 6);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.HitReset();
			this.PlaySE(1263);
			this.stateLabel = function ()
			{
				if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
				{
					this.func[0].call(this);
					return;
				}

				this.AddSpeed_XY(0.00000000, 1.25000000);

				if (this.y >= ::battle.scroll_bottom + 125)
				{
					this.PlaySE(1264);

					if (this.owner.okltItem == this)
					{
						this.owner.okltItem = null;
					}

					::camera.Shake(5.00000000);
					this.ReleaseActor();
					return;
				}
			};
		}
	];
	this.SetSpeed_XY(10.00000000 * this.direction, -15.00000000);
	this.stateLabel = function ()
	{
		if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0.00000000, this.va.y < -0.75000000 ? 0.75000000 : 0.00000000);
		this.VX_Brake(0.30000001);
		this.count++;

		if (this.count >= 35)
		{
			this.func[1].call(this);
			return;
		}
	};
}

function Shot_OkultC( t )
{
	this.SetMotion(2509, 29);
	this.flag1 = this.y + 50;
	this.flag2 = 5;
	this.func = [
		function ()
		{
			if (this.owner.okltItem == this)
			{
				this.owner.okltItem = null;
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(2509, 29);
			this.PlaySE(1266);
			this.SetSpeed_XY(5.00000000 * this.direction, -6.00000000);
			this.count = 0;
			this.flag2--;
			this.stateLabel = function ()
			{
				if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
				{
					this.func[0].call(this);
					return;
				}

				this.AddSpeed_XY(0.00000000, 0.50000000);

				if (this.y >= this.flag1)
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.stateLabel = function ()
					{
						if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
						{
							this.func[0].call(this);
							return;
						}

						this.count++;

						if (this.count >= 25)
						{
							if (this.flag2 <= 0)
							{
								this.func[0].call(this);
							}
							else
							{
								this.direction = -this.direction;
								this.func[1].call(this);
							}
						}
					};
				}
			};
		}
	];
	this.func[1].call(this);
}

function Shot_OkultD( t )
{
	this.SetMotion(2509, 8);
	this.PlaySE(1262);
	this.life = 1;
	this.SetSpeed_XY(15.00000000 * this.direction, -10.00000000);
	this.rz = 360 * 0.01745329;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag4 = 72;
	this.func = [
		function ()
		{
			this.SetMotion(2509, 8);
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.callbackGroup = 0;

			if (this.owner.okltItem == this)
			{
				this.owner.okltItem = null;
			}

			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.rz += (-160 * 0.01745329 - this.rz) * 0.05000000;
				this.AddSpeed_XY(0.00000000, 0.25000000);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
				{
					this.func[0].call(this);
					return;
				}

				this.rz += -this.rz * 0.07500000;

				if (this.Vec_Brake(1.00000000))
				{
					this.SetMotion(2509, 9);
					local pos_ = this.Vector3();
					this.GetPoint(0, pos_);
					local t_ = this.SetFreeObject(pos_.x, pos_.y, this.direction, this.Shot_OkultD_FlashA, {});
					this.SetParent.call(t_, this, t_.x - this.x, t_.y - this.y);
					this.flag1.Add(t_);
					this.GetPoint(1, pos_);
					local t_ = this.SetFreeObject(pos_.x, pos_.y, this.direction, this.Shot_OkultD_FlashA, {});
					this.SetParent.call(t_, this, t_.x - this.x, t_.y - this.y);
					this.flag1.Add(t_);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
						{
							this.func[0].call(this);
							return;
						}

						this.count++;

						if (this.count == 25)
						{
							this.PlaySE(1268);
							local pos_ = this.Vector3();
							this.GetPoint(0, pos_);
							local t_ = {};
							t_.rot <- 30 * 0.01745329;
							local a_ = this.SetShotDynamic(pos_.x, pos_.y, this.direction, this.Shot_OkultD_Beam, t_);
							a_.SetParent(this, a_.x - this.x, a_.y - this.y);
							this.flag1.Add(a_);
							this.GetPoint(1, pos_);
							local t_ = {};
							t_.rot <- 20 * 0.01745329;
							local a_ = this.SetShotDynamic(pos_.x, pos_.y, this.direction, this.Shot_OkultD_Beam, t_);
							a_.SetParent(this, a_.x - this.x, a_.y - this.y);
							this.flag1.Add(a_);
						}

						if (this.count >= this.flag4)
						{
							this.func[0].call(this);
							return;
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		this.rz += -this.rz * 0.07500000;
		this.VX_Brake(0.50000000);
		this.AddSpeed_XY(0.00000000, 0.80000001);
		this.count++;

		if (this.count == 20)
		{
			this.func[1].call(this);
		}
	};
}

function Shot_OkultD_FlashA( t )
{
	this.SetMotion(2509, 10);
	this.sx = this.sy = 0.10000000;
	this.flag1 = -45.00000000 * 0.01745329;
	this.stateLabel = function ()
	{
		this.count++;
		this.rz += this.flag1;
		this.flag1 *= 0.89999998;

		if (this.count <= 15)
		{
			this.sx += (1.00000000 - this.sx) * 0.20000000;
			this.sy += (1.00000000 - this.sy) * 0.20000000;
		}
		else
		{
			this.sx += (2.00000000 - this.sx) * 0.10000000;
			this.sy += (0.10000000 - this.sy) * 0.10000000;
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Shot_OkultD_Beam( t )
{
	this.SetMotion(2509, 14);
	this.atk_id = 524288;
	this.rz = t.rot - 90 * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.sx = 0.01000000;
	local t_ = {};
	t_.rot <- t.rot;
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultD_BeamFlash, t_);
	a_.SetParent(this, 0, 0);
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultD_BeamFlashB, {}).weakref();
	this.SetParent.call(this.flag1, this, 0, 0);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 64;
	this.anime.height = 1600;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sx *= 0.69999999;
				this.alpha = this.blue -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.anime.top -= 25.00000000;
		this.sx += (0.25000000 - this.sx) * 0.10000000;
		this.HitCycleUpdate(15);
	};
}

function Shot_OkultD_BeamFlash( t )
{
	this.SetMotion(2509, 12);
	this.rz = t.rot;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx *= 0.89999998;
				this.sy *= 0.89999998;
				this.alpha = this.blue -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			this.sx *= 1.04999995;
			this.sy *= 0.98000002;
			this.alpha = this.blue -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
}

function Shot_OkultD_BeamFlashB( t )
{
	this.SetMotion(2509, 11);
	this.sx = this.sy = 0.10000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx *= 0.89999998;
				this.sy *= 0.89999998;
				this.alpha = this.blue -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.00000000 - this.sx) * 0.20000000;
	};
}

function Shot_OkultE( t )
{
	this.SetMotion(2509, 16);
	this.PlaySE(1262);
	this.life = 1000;
	this.atk_id = 524288;
	this.SetSpeed_XY(5.00000000 * this.direction, -7.00000000);
	this.subState = function ()
	{
		if (this.life <= 0)
		{
			this.func[0].call(this);
			return true;
		}
	};
	this.func = [
		function ()
		{
			this.PlaySE(1267);

			if (this.owner.okltItem == this)
			{
				this.owner.okltItem = null;
			}

			for( local i = 19; i < 26; i++ )
			{
				local t_ = {};
				t_.take <- i;
				this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultE_Break, t_);
			}

			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0.00000000, 0.50000000);
		this.count++;

		if (this.count >= 30)
		{
			this.SetMotion(2509, 17);
			this.flag1 = 30;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
				{
					this.func[0].call(this);
					return;
				}

				this.count++;
				this.flag1--;

				if (this.flag1 <= 0)
				{
					this.flag1 = 15 + this.rand() % 60;
					this.SetMotion(2509, 17);
				}

				if (this.count >= 300)
				{
					this.func[0].call(this);
					return true;
				}
			};
		}
	};
}

function Shot_OkultE_Break( t )
{
	this.SetMotion(2509, t.take);
	this.flag1 = (-45 + this.rand() % 90) * 0.01745329;
	this.SetSpeed_XY(-2.00000000 + this.rand() % 5, -1.00000000 - this.rand() % 5);
	this.stateLabel = function ()
	{
		this.rz += (this.flag1 - this.rz) * 0.02500000;
		this.AddSpeed_XY(0.00000000, 0.50000000);
		this.alpha -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_OkultF( t )
{
	this.SetMotion(2509, 15);
	this.PlaySE(1262);
	this.atk_id = 524288;
	this.flag4 = 2;
	this.flag5 = 6;
	this.func = [
		function ()
		{
			if (this.owner.okltItem == this)
			{
				this.owner.okltItem = null;
			}

			this.SetMotion(2509, 15);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
				this.AddSpeed_XY(0.00000000, 0.75000000);
				this.rz += (-3.14159203 - this.rz) * 0.07500000;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(2509, 16);
			this.count = 0;
			this.PlaySE(1270);
			this.stateLabel = function ()
			{
				if (this.IsScreen(150))
				{
					if (this.owner.okltItem == this)
					{
						this.owner.okltItem = null;
					}

					this.ReleaseActor();
					return;
				}

				if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
				{
					this.func[0].call(this);
					return;
				}

				if (this.va.y > 0.00000000)
				{
					this.VY_Brake(0.30000001);
				}

				this.AddSpeed_XY(this.va.x * this.direction <= 12.50000000 ? 0.50000000 * this.direction : 0.05000000, -0.25000000);

				if (this.hitCount <= this.flag4)
				{
					this.HitCycleUpdate(this.flag5);
				}
			};
		}
	];
	this.SetSpeed_XY(6.00000000 * this.direction, -6.00000000);
	this.stateLabel = function ()
	{
		if (this.owner.motion == 2500 && this.owner.keyTake == 0 || this.team.current.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0.00000000, 0.50000000);
		this.VX_Brake(0.10000000);

		if (this.va.x > 0.00000000 && this.x > 1280 || this.va.x < 0.00000000 && this.x < 0)
		{
			this.SetSpeed_XY(0.00000000, null);
		}

		this.count++;

		if (this.count >= 30)
		{
			this.func[1].call(this);
		}
	};
}

function SPShot_A( t )
{
	this.SetMotion(6000, 0);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
}

function SPShot_B_Blade( t )
{
	if (t.rf)
	{
		this.SetMotion(6010, 2);
	}
	else
	{
		this.SetMotion(6010, 0);
	}

	this.flag1 = this.y;
	this.sy = 0.00000000;
	this.stateLabel = function ()
	{
		local a_ = this.owner;

		if ((a_.motion >= 3010 && a_.motion <= 3015) && a_.keyTake == 2)
		{
			this.sy = (this.flag1 - this.y) / 90.00000000;
			this.Warp(this.owner.point0_x, this.owner.point0_y);
		}
		else
		{
			this.SetMotion(6010, this.keyTake + 1);
			this.stateLabel = function ()
			{
				this.sx *= 0.85000002;

				if (this.sx <= 0.05000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_C( t )
{
	this.SetSpeed_Vec(3.00000000, t.rot, this.direction);
	this.flag1 = this.rz = t.rot;
	this.flag2 = 0;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_C_Fire, t_);

	if (t.rot == 0.00000000)
	{
		this.SetMotion(6020, 0);
	}
	else if (t.rot > 0.00000000)
	{
		this.SetMotion(6020, 2);
	}
	else
	{
		this.SetMotion(6020, 1);
	}

	this.cancelCount = 3;
	this.atk_id = 4194304;
	this.stateLabel = function ()
	{
		this.AddSpeed_Vec(1.00000000, this.flag1, 45.00000000, this.direction);

		if (this.cancelCount <= 0 || this.hitCount > 0)
		{
			local t_ = {};
			t_.rot <- this.flag1;
			t_.vec <- this.va.LengthXY();
			this.PlaySE(1306);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C_Exp, t_);
			this.ReleaseActor();
			return;
		}

		this.HitCycleUpdate(10);
		this.count++;

		if (this.count >= 180)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_C_Fire( t )
{
	this.SetMotion(6020, 4);
	this.rz = t.rot;
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
}

function SPShot_C_Trail( t )
{
	this.SetMotion(6020, 3);
	this.rz = 0.01745329 * this.rand() % 360;
	this.sx = this.sy = 0.20000000 + this.rand() % 20 * 0.10000000;
	this.SetSpeed_Vec(this.rand() % 30 * 0.10000000 + t.vec, t.rot + (this.rand() % 30 - 15) * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.rz += 0.10000000;
		this.Vec_Brake(0.30000001);

		if (this.alpha > 0.05000000)
		{
			this.alpha -= 0.05000000;
			this.green -= 0.05000000;
			this.red -= 0.05000000;
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_C_Exp( t )
{
	this.cancelCount = 10;
	this.atk_id = 4194304;
	this.SetMotion(6021, 0);

	for( local i = 0; i < 20; i++ )
	{
		local t_ = {};
		t_.rot <- (i * 18 + this.rand() % 45) * 0.01745329;
		t_.vec <- 6.00000000 + this.rand() % 12;
		this.SetShot(this.x, this.y, this.direction, this.SPShot_C_Trail, t_);
	}

	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.02500000;
	};
}

function SPShot_C2( t )
{
	this.SetSpeed_Vec(3.00000000, t.rot, this.direction);
	this.flag1 = this.rz = t.rot;
	this.flag2 = 0;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_C_Fire, t_);

	if (t.rot == 0.00000000)
	{
		this.SetMotion(6022, 0);
	}
	else if (t.rot > 0.00000000)
	{
		this.SetMotion(6022, 2);
	}
	else
	{
		this.SetMotion(6022, 1);
	}

	this.cancelCount = 9;
	this.atk_id = 4194304;
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount >= 4)
		{
			local t_ = {};
			t_.rot <- this.flag1;
			t_.vec <- this.va.LengthXY();
			this.PlaySE(1306);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C2_Exp, t_);
			this.ReleaseActor();
			return;
		}

		this.HitCycleUpdate(6);

		if (this.hitResult)
		{
			this.SetSpeed_Vec(2.50000000, this.flag1, this.direction);
		}
		else
		{
			this.AddSpeed_Vec(1.00000000, this.flag1, 45.00000000, this.direction);
		}

		if (this.count % 2)
		{
			local t_ = {};
			t_.rot <- this.flag1 + 3.14159203;
			t_.vec <- this.va.LengthXY() * 0.50000000;
			this.SetShot(this.x, this.y, this.direction, this.SPShot_C_Trail, t_);
		}

		this.count++;

		if (this.count >= 180)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_C2_Exp( t )
{
	this.cancelCount = 10;
	this.atk_id = 4194304;
	this.SetMotion(6023, 0);

	for( local i = 0; i < 20; i++ )
	{
		local t_ = {};
		t_.rot <- (i * 18 + this.rand() % 45) * 0.01745329;
		t_.vec <- 6.00000000 + this.rand() % 12;
		this.SetShot(this.x, this.y, this.direction, this.SPShot_C_Trail, t_);
	}

	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.02500000;
	};
}

function SPShot_D( t )
{
	this.SetMotion(6030, 5);
	this.SetSpeed_XY(0.00000000, -45.00000000);
	this.cancelCount = 1;
	this.atk_id = 8388608;
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 2, 1))
		{
			this.ReleaseActor();
			return;
		}

		this.rz += 0.30000001;
		this.count++;

		if (this.count % 4 == 0)
		{
			local t_ = {};
			t_.rot <- 3.14159203 * 0.50000000;
			t_.vec <- this.va.LengthXY() * 0.50000000;
			this.SetShot(this.x, this.y, this.direction, this.SPShot_D_Trail, t_);
		}

		if (this.count >= this.initTable.count)
		{
			for( local i = 0; i < 2; i++ )
			{
				local t_ = {};
				t_.rot <- 90 * 0.01745329 + this.initTable.rot * (1 - i * 2);
				this.SetShot(this.x, this.initTable.posY, this.direction, this.SPShot_D_Fall, t_);
			}

			this.PlaySE(1310);
			this.ReleaseActor();
		}
	};
}

function SPShot_D2( t )
{
	this.SetMotion(6031, 0);
	this.SetSpeed_XY(0.00000000, -45.00000000);
	this.cancelCount = 1;
	this.atk_id = 8388608;
	this.stateLabel = function ()
	{
		this.rz += 0.30000001;
		this.count++;

		if (this.count % 4 == 0)
		{
			local t_ = {};
			t_.rot <- 3.14159203 * 0.50000000;
			t_.vec <- this.va.LengthXY() * 0.50000000;
			this.SetShot(this.x, this.y, this.direction, this.SPShot_D_Trail, t_);
		}

		if (this.count >= 15)
		{
			for( local i = 0; i < 3; i++ )
			{
				this.SetShot(this.x, -960, this.direction, this.SPShot_D2_Fall, {});
			}

			this.PlaySE(1310);
			this.ReleaseActor();
		}
	};
}

function SPShot_D_Flash( t )
{
	this.SetMotion(6030, 4);
	this.sx = this.sy = 1.00000000 + this.rand() % 20 * 0.10000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.92000002;

		if (this.alpha > 0.10000000)
		{
			this.alpha -= 0.10000000;
			this.green -= 0.10000000;
			this.red -= 0.10000000;
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_D_Fall( t )
{
	this.SetMotion(6030, 1);
	this.rz = t.rot;
	this.SetSpeed_Vec(37.50000000, this.rz, this.direction);
	this.cancelCount = 1;
	this.atk_id = 8388608;
	this.stateLabel = function ()
	{
		if (this.y >= 960 || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return;
		}

		this.count++;

		if (this.hitResult)
		{
			this.rz = 90 * 0.01745329;
			this.SetMotion(6030, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = null;
			this.keyAction = function ()
			{
				this.ReleaseActor();
			};
			return;
		}

		if (this.count % 6 == 0)
		{
			local t_ = {};
			t_.rot <- this.rz;
			t_.vec <- this.va.LengthXY() * 0.50000000;
			this.SetShot(this.x, this.y, this.direction, this.SPShot_D_Trail, t_);
		}
	};
}

function SPShot_D2_Fall( t )
{
	this.SetMotion(6031, 1);
	local R_ = (100 - this.rand() % 20) * 0.01745329;
	this.SetSpeed_Vec(30.00000000 + this.rand() % 15, R_, this.direction);
	this.rz = R_;
	this.cancelCount = 1;
	this.atk_id = 8388608;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.hitResult)
		{
			this.rz = 90 * 0.01745329;
			this.SetMotion(6031, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = null;
			this.keyAction = function ()
			{
				this.ReleaseActor();
			};
			return;
		}

		if (this.count % 6 == 0)
		{
			local t_ = {};
			t_.rot <- this.rz;
			t_.vec <- this.va.LengthXY() * 0.50000000;
			this.SetShot(this.x, this.y, this.direction, this.SPShot_D_Trail, t_);
		}

		if (this.y >= 960)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_D_Trail( t )
{
	this.SetMotion(6030, 3);
	this.rz = 0.01745329 * this.rand() % 360;
	this.sx = this.sy = 0.50000000 + this.rand() % 20 * 0.10000000;
	this.SetSpeed_Vec(this.rand() % 30 * 0.10000000 + t.vec, t.rot + (this.rand() % 30 - 15) * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.rz += 0.10000000;
		this.Vec_Brake(0.30000001);

		if (this.alpha > 0.05000000)
		{
			this.alpha -= 0.05000000;
			this.green -= 0.05000000;
			this.red -= 0.05000000;
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_E( t )
{
	this.SetMotion(6040, t.take);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.flag1 = 0.50000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += this.flag1;
		this.flag1 *= 0.92000002;
	};
}

function SPShot_E_Star( t )
{
	this.SetMotion(6040, 3);
	this.SetSpeed_Vec(t.v, t.rot);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 1.00000000 + this.rand() % 150 * 0.01000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.93000001;
		this.AddSpeed_XY(0.00000000, 0.10000000);

		if (this.sx <= 0.01000000)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_F( t )
{
	this.SetMotion(6050, 0);

	if (t.rf)
	{
		this.SetMotion(6050, 5);
	}

	this.PlaySE(1314);
	this.atk_id = 33554432;
	this.func = function ()
	{
		this.PlaySE(1315);
		this.SetShot(this.x, this.y, this.direction, this.SPShot_F_Exp, {});

		if (this.initTable.rf)
		{
			for( local i = 0; i < 12; i++ )
			{
				local t_ = {};
				t_.rot <- i * 30 * 0.01745329;
				this.SetShot(this.x, this.y, this.direction, this.SPShot_F_Star, t_);
			}
		}

		this.ReleaseActor();
	};
	this.SetSpeed_XY(t.vx * this.direction, t.vy);
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 7))
		{
			this.ReleaseActor();
			return;
		}

		if (this.va.y > 0.00000000 && this.y > ::battle.corner_bottom)
		{
			this.SetSpeed_XY(null, this.va.y * -0.75000000);
		}

		if (this.va.x > 0.00000000 && this.x > ::battle.corner_right || this.va.x < 0.00000000 && this.x < ::battle.corner_left)
		{
			this.SetSpeed_XY(this.va.x * -0.25000000, null);
		}

		this.AddSpeed_XY(null, 0.44999999);
		this.rz += 13.00000000 * 0.01745329;
		this.count++;

		if (this.count >= 45)
		{
			this.func();
			return;
		}
	};
}

function SPShot_F_Exp( t )
{
	this.cancelCount = 9;
	this.atk_id = 33554432;
	this.SetMotion(6050, 1);
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.Damage_ConvertOP(this.x, this.y, 7))
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_F_Star( t )
{
	this.SetMotion(6050, 2);
	this.flag1 = 12.50000000;
	this.flag2 = t.rot;
	this.flag3 = -6.00000000;
	this.SetSpeed_Vec(12.50000000, t.rot, this.direction);
	this.cancelCount = 3;
	this.atk_id = 33554432;
	this.func = function ()
	{
		this.SetMotion(this.motion, 3);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0.92000002;
			this.rz += 10.00000000 * 0.01745329;
			this.flag1 -= 0.50000000;

			if (this.flag1 < 2.00000000)
			{
				this.flag1 = 2.00000000;
			}

			this.SetSpeed_Vec(this.flag1, this.flag2, this.direction);
			this.AddSpeed_XY(0.00000000, this.flag3);
			this.flag3 += 0.25000000;
			this.alpha -= 0.08000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 5)
		{
			this.func();
			return;
		}

		this.HitCycleUpdate(1);
		this.count++;

		if (this.count >= 90)
		{
			this.func();
			return;
		}

		this.rz += 10.00000000 * 0.01745329;
		this.flag1 -= 0.50000000;

		if (this.flag1 < 2.00000000)
		{
			this.flag1 = 2.00000000;
		}

		this.SetSpeed_Vec(this.flag1, this.flag2, this.direction);
		this.AddSpeed_XY(0.00000000, this.flag3);
		this.flag3 += 0.25000000;
	};
}

function SPShot_G( t )
{
	this.SetMotion(6060, 3);
	this.sx = 0.00000000;
	this.sy = 0.00000000;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
	{
		this.SetMotion(6060, 4);
		this.func = [
			function ()
			{
				this.alpha = 0.00000000;
				this.sx = this.sy = 0.50000000;
				this.stateLabel = function ()
				{
					this.sx = this.sy += 0.20000000;
					this.alpha += 0.20000000;

					if (this.alpha >= 1.00000000)
					{
						this.stateLabel = function ()
						{
							this.sx = this.sy += 0.20000000;
							this.alpha -= 0.10000000;

							if (this.alpha <= 0.00000000)
							{
								this.func[0].call(this);
							}
						};
					}
				};
			},
			function ()
			{
				this.alpha = 0.00000000;
				this.sx = this.sy = 0.50000000;
				this.stateLabel = function ()
				{
					this.sx = this.sy += 0.25000000;
					this.alpha += 0.20000000;

					if (this.alpha >= 1.00000000)
					{
						this.stateLabel = function ()
						{
							this.sx = this.sy += 0.25000000;
							this.alpha -= 0.10000000;

							if (this.alpha <= 0.00000000)
							{
								this.func[1].call(this);
							}
						};
					}
				};
			}
		];
		this.func[0].call(this);
	}, {}).weakref();
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.ReleaseActor();
				this.flag1 = null;
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			this.stateLabel = function ()
			{
				if (this.owner.motion != 3060)
				{
					this.func[0].call(this);
					return;
				}

				this.rz -= 10.00000000 * 0.01745329;
				this.sx = this.sy += (2.50000000 - this.sx) * 0.10000000;
				this.Warp(this.x + (this.owner.point0_x - this.x) * 0.50000000, this.y + (this.owner.point0_y - this.y) * 0.50000000);

				if (this.flag1)
				{
					this.Warp.call(this.flag1, this.x, this.y);
				}
			};
		}
	];

	if (t.type)
	{
		this.stateLabel = function ()
		{
			if (this.team.current.IsDamage() || this.initTable.num <= 0)
			{
				this.func[0].call(this);
				return;
			}

			this.count++;

			if (this.count % 4 == 0 && this.initTable.num > 0)
			{
				this.initTable.num--;
				local t_ = {};
				t_.rot <- this.initTable.rot;
				this.SetShot(this.x + 50 * this.cos(t_.rot) * this.direction, this.y + 50 * this.sin(t_.rot), this.direction, this.SPShot_G_Shot, t_);
			}

			this.sx = this.sy += (1.00000000 - this.sx) * 0.20000000;
		};
	}
	else
	{
		this.stateLabel = function ()
		{
			if (this.owner.motion != 3060 || this.initTable.num <= 0)
			{
				this.func[0].call(this);
				return;
			}

			this.count++;

			if (this.count % 4 == 0 && this.initTable.num > 0)
			{
				this.initTable.num--;
				local t_ = {};
				t_.rot <- this.initTable.rot;
				this.SetShot(this.x + 50 * this.cos(t_.rot) * this.direction, this.y + 50 * this.sin(t_.rot), this.direction, this.SPShot_G_Shot, t_);
			}

			this.sx = this.sy += (1.00000000 - this.sx) * 0.20000000;
			this.Warp(this.x + (this.owner.point0_x - this.x) * 0.50000000, this.y + (this.owner.point0_y - this.y) * 0.50000000);

			if (this.flag1)
			{
				this.Warp.call(this.flag1, this.x, this.y);
			}
		};
	}
}

function SPShot_G_Shot( t )
{
	this.SetMotion(6060, 1);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(40.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.SetTrail(6060, 2, 5, 10);
	this.PlaySE(1373);
	this.SetCollisionRotation(0.00000000, 0.00000000, t.rot);
	this.sx = this.sy = 2.00000000;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0.89999998;
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}

		return false;
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.25000000;
		this.count++;
		local r_ = this.rand() % 250;

		if (this.count % 4 == 2)
		{
			this.SetFreeObject(this.x - r_ * this.direction * this.cos(this.initTable.rot), this.y - r_ * this.sin(this.initTable.rot), this.direction, function ( t_ )
			{
				this.SetMotion(6060, 0);
				this.rz = this.rand() % 360 * 0.01745329;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0.00000000, 0.25000000);
					this.sx = this.sy *= 0.89999998;

					if (this.sx <= 0.01000000)
					{
						this.ReleaseActor();
					}
				};
			}, {});
		}

		this.AddSpeed_Vec(3.50000000, null, 75, this.direction);

		if (this.IsScreen(200))
		{
			this.ReleaseActor();
		}
	};
}

function SpellA_Shot( t )
{
	this.SetMotion(4009, 0);
	this.cancelCount = 99;
	this.atk_id = 67108864;
	this.atkRate_Pat = t.rate;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		local a_ = this.owner;
		this.count++;
		this.sy += 0.00100000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (a_.motion == 4000 && a_.keyTake == 2)
		{
			this.HitCycleUpdate(4);
		}
		else
		{
			this.stateLabel = function ()
			{
			};
			this.SetParent(null, 0, 0);
			this.SetKeyFrame(2);
			this.callbackGroup = 0;
			this.flag1 = false;
		}
	};
}

function SpellA_Root( t )
{
	this.flag1 = t.name;
	this.SetMotion(4009, 2);
	this.stateLabel = function ()
	{
		if (this.flag1 in ::actor)
		{
			this.x = ::actor[this.flag1].x;
			this.y = ::actor[this.flag1].y;
			this.sx = this.sy = ::actor[this.flag1].sy * 1.25000000;

			if (!::actor[this.flag1].flag1)
			{
				this.stateLabel = function ()
				{
					this.sx *= 0.80000001;
					this.sy = this.sx;

					if (this.sx <= 0.01000000)
					{
						this.ReleaseActor();
					}
				};
			}
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SpellA_Head( t )
{
	this.flag1 = t.name;
	this.SetMotion(4009, 1);
	this.stateLabel = function ()
	{
		if (this.flag1 in ::actor)
		{
			this.x = ::actor[this.flag1].x + 128 * ::actor[this.flag1].sx * this.direction;
			this.y = ::actor[this.flag1].y;
			this.sx = this.sy = ::actor[this.flag1].sy;

			if (!::actor[this.flag1].flag1)
			{
				this.stateLabel = function ()
				{
					this.sx *= 0.80000001;
					this.sy = this.sx;

					if (this.sx <= 0.01000000)
					{
						this.ReleaseActor();
					}
				};
			}
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SpellB_Shot( t )
{
	this.SetMotion(4019, 0);
	this.sy = 0.25000000;
	this.stateLabel = function ()
	{
		if (this.owner.motion == 4010)
		{
			if (this.owner.keyTake == 3)
			{
				if (this.owner.x < 1280 && this.direction == 1.00000000 || this.owner.x > 0 && this.direction == -1.00000000)
				{
					this.Warp(this.owner.x, this.owner.y + 50.00000000);
				}
				else
				{
					this.stateLabel = function ()
					{
						this.Warp(640 + 640 * this.direction, this.y);
						this.sy += (2.00000000 - this.sy) * 0.15000001;
						this.alpha = this.red = this.green -= 0.01250000;

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			}
			else
			{
				this.ReleaseActor();
			}
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SpellC_Shot( t )
{
	this.SetMotion(7040, 0);
	this.cancelCount = 6;
	this.atk_id = 67108864;
	this.SetSpeed_XY(20.00000000 * this.direction, 0.00000000);
	this.flag1 = 0;
	this.sx = this.sy = 1.50000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.hitCount >= 6 || this.cancelCount <= 0 || this.count >= 60)
		{
			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(this.va.x * 0.92000002, 0.00000000);

				if (this.alpha > 0.05000000)
				{
					this.alpha -= 0.05000000;
					this.green -= 0.05000000;
					this.red -= 0.05000000;
				}
				else
				{
					this.ReleaseActor();
				}
			};
			return;
		}

		this.SetSpeed_XY(this.va.x * 0.92000002, 0.00000000);

		if (this.hitResult)
		{
			this.SetSpeed_XY(this.va.x * 0.69999999, 0.00000000);
			this.flag1++;

			if (this.flag1 >= 4)
			{
				this.HitReset();
				this.flag1 = 0;
			}
		}

		if (this.abs(this.va.x) <= 2.00000000)
		{
			this.SetSpeed_XY(2.00000000 * this.direction, 0.00000000);
		}
	};
}

function SpellC_ShotCore( t )
{
	this.SetMotion(4029, 6);
	this.flag1 = [];
	this.flag2 = this.Vector3();
	this.flag2.x = 1.00000000;
	this.flag3 = 20.00000000;
	this.atkRate_Pat = t.rate;
	this.cancelCount = 30;
	this.atk_id = 67108864;

	for( local i = 0; i < 6; i++ )
	{
		local t_ = {};
		t_.take <- i;
		t_.rate <- this.atkRate_Pat;
		local a_ = this.SetShot(this.x, this.y, this.direction, this.owner.SpellC_ShotOrb, t_).weakref();
		this.flag1.append(a_);
	}

	foreach( a in this.flag1 )
	{
		if (a)
		{
			a.hitOwner = this.weakref();
		}
	}

	this.func = [
		function ()
		{
			this.team.spell_enable_end = true;

			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			if (this.owner.bitCore == this)
			{
				this.owner.bitCore = null;
			}

			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.x += (this.team.current.x - this.x) * 0.25000000;
		this.y += (this.team.current.y - this.y) * 0.25000000;

		for( local i = 0; i < 6; i++ )
		{
			if (this.flag1[i])
			{
				this.flag1[i].x = this.x + this.flag2.x * this.flag3;
				this.flag1[i].y = this.y + this.flag2.y * this.flag3 * 0.33000001;

				if (this.flag1[i].drawPriority == 200)
				{
					if (this.flag2.y < 0.00000000)
					{
						this.flag1[i].DrawActorPriority(180);
					}
				}
				else if (this.flag2.y > 0.00000000)
				{
					this.flag1[i].DrawActorPriority(200);
				}
			}

			this.flag2.RotateByDegree(60.00000000);
		}

		this.flag2.RotateByDegree(6.00000000);
		this.flag3 += (120 - this.flag3) * 0.10000000;

		if (this.count == 25)
		{
			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.func[1].call(a);
				}
			}
		}

		this.HitCycleUpdate(20);

		if (this.count == 420 || this.hitCount >= 6 || this.cancelCount <= 0 || this.team.current.IsDamage())
		{
			this.func[0].call(this);
			return;
		}
	};
}

function SpellC_ShotOrb( t )
{
	this.SetMotion(4029, t.take);
	this.callbackGroup = 0;
	this.sx = this.sy = 0.10000000;
	this.cancelCount = 30;
	this.atk_id = 67108864;
	this.atkRate_Pat = t.rate;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.sx = this.sy -= 0.10000000;

				if (this.sy <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetTeamShot();
			this.sx = this.sy = 1.00000000;
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.05000000;

		if (this.sx >= 1.00000000)
		{
			this.sx = this.sy = 1.00000000;
		}
	};
}

function Climax_CutA( t )
{
	this.DrawScreenActorPriority(100);
	this.SetMotion(7900, 5);
	this.PlaySE(1368);
	this.stateLabel = function ()
	{
	};
	this.keyAction = function ()
	{
		this.owner.func.call(this.owner);
		this.ReleaseActor();
	};
}

function Climax_CutB( t )
{
	this.DrawScreenActorPriority(100);
	this.SetMotion(7900, 6);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.25000000 - this.sx) * 0.00250000;
		this.SetSpeed_XY(0.03000000 * this.sx, -0.25000000 * this.sy);

		if (!(this.owner.motion == 4902 && this.owner.keyTake == 0))
		{
			this.ReleaseActor();
		}
	};
}

function Climax_CutB_Exp( t )
{
	this.DrawScreenActorPriority(90);
	this.SetMotion(7900, 7);
	this.sx = this.sy = 0.75000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.50000000 - this.sx) * 0.01000000;

		if (!(this.owner.motion == 4902 && this.owner.keyTake == 0))
		{
			this.ReleaseActor();
		}
	};
}

function Climax_CutB_Back( t )
{
	this.DrawScreenActorPriority(80);
	this.SetMotion(7900, 8);
	this.stateLabel = function ()
	{
		if (!(this.owner.motion == 4902 && this.owner.keyTake == 0))
		{
			this.ReleaseActor();
		}
	};
}

function Climax_Back( t )
{
	this.DrawActorPriority(501);
	this.SetMotion(4908, 0);
	this.sx = this.sy = 0.50000000;
	this.Warp(640 + 640 * this.direction, 180);
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_BackB, {}).weakref();
	this.flag2 = this.Vector3();
	this.SetParent.call(this.flag1, this, 0, 0);
	this.target = this.owner.target.weakref();
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.PlaySE(1280);
			::camera.Shake(1.00000000);
			this.SetMotion(4908, 1);
			this.flag1.SetMotion(4908, 7);
			local t_ = {};
			t_.motion <- 303;
			t_.keyTake <- 1;
			this.flag3 = this.owner.target.SetFreeObject(this.x - 360, this.y + 180, -1.00000000, this.DummyPlayer, t_).weakref();
			this.stateLabel = function ()
			{
				this.flag3.x += 40;

				if (this.flag3.x > this.x + 280)
				{
					this.PlaySE(1274);
					this.SetMotion(4908, 2);
					this.flag1.SetMotion(4908, 8);
					this.flag3.y = this.point0_y;
					this.flag3.x = this.point0_x;
					this.flag3.SetMotion(301, 2);
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.SetMotion(4908, 3);
			this.flag1.SetMotion(4908, 9);
			this.flag3.SetMotion(302, 1);
			this.flag3.x = this.point0_x;
			this.flag3.y = this.point0_y;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 3)
				{
					this.flag3.SetMotion(303, 1);
					this.flag3.x = this.x + 330 * this.direction;
					this.flag3.y = this.y + 158;
				}

				if (this.count == 6)
				{
					this.flag3.SetMotion(304, 1);
					this.flag3.x = this.x + 407 * this.direction;
					this.flag3.y = this.y + 182;
				}

				if (this.count == 8)
				{
					this.flag3.SetMotion(304, 1);
					this.flag3.x = this.x + 477 * this.direction;
					this.flag3.y = this.y + 230;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.SetSpeed_XY((640 - 240 * this.direction - this.x) * 0.15000001, 0.00000000);
		this.count++;

		if (this.count >= 30)
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
			};
		}
	};
	this.keyAction = [
		null,
		function ()
		{
		},
		null,
		function ()
		{
			this.PlaySE(1275);
			this.ReleaseActor.call(this.flag3);
			::camera.Shake(6.00000000);
			this.stateLabel = function ()
			{
			};
		}
	];
}

function Climax_BackB( t )
{
	this.DrawActorPriority(499);
	this.SetMotion(4908, 6);
	this.sx = this.sy = 0.50000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_CutInA( t )
{
	this.DrawActorPriority(510);
	this.SetMotion(4909, 9);
	this.sx = this.sy = 3.00000000;
	::camera.Shake(20.00000000);
	this.red = this.green = this.blue = 0.00000000;
	this.x = 640 + 190;
	this.y = 360 - 60;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.red = this.green = this.blue += 0.20000000;

		if (this.red > 1.00000000)
		{
			this.red = this.green = this.blue = 1.00000000;
		}

		if (this.count >= 30)
		{
			this.sx = this.sy -= 0.20000000;

			if (this.sx <= 0.50000000)
			{
				local t_ = {};
				t_.count <- 120;
				t_.priority <- 520;
				this.SetEffect(640, 360, 1.00000000, this.EF_SpeedLine, t_);
				this.PlaySE(1277);
				this.sx = this.sy = 0.50000000;
				::camera.Shake(2.00000000);
				this.stateLabel = null;
			}
		}
		else if (this.sx > 2.00000000)
		{
			this.sx = this.sy -= 0.20000000;
		}

		this.x = 640 + (this.sx - 0.50000000) * 190;
		this.y = 360 + (this.sy - 0.50000000) * -60;
	};
}

function Climax_Flash( t )
{
	this.SetMotion(7900, 1);
	this.sx = this.sy = 0.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.05000000;

		if (this.sx > 1.00000000)
		{
			this.sx = this.sy = 1.00000000;
		}

		this.count++;
		this.Warp(this.owner.point1_x, this.owner.point1_y);

		if (this.count >= 30)
		{
			this.stateLabel = function ()
			{
				if (this.owner.motion != 4901)
				{
					this.ReleaseActor();
					return;
				}

				this.Warp(this.owner.point1_x, this.owner.point1_y);
			};
			this.SetMotion(7900, 2);
		}
	};
}

