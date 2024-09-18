function Debug_Seat( t )
{
	this.SetMotion(9999, 0);
	this.DrawActorPriority(180);
}

function SAN_Field( t )
{
	this.SetMotion(2508, 3);
	this.DrawBackActorPriority(200);
	this.keyAction = function ()
	{
		if (this.owner.san_mode)
		{
			this.SetFreeObject(640, 360, 1.00000000, this.SAN_Field, {});
		}

		this.ReleaseActor();
	};
}

function SAN_FieldBack( t )
{
	this.SetMotion(2508, 4);
	this.DrawBackActorPriority(199);
	this.stateLabel = function ()
	{
		this.alpha -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SAN_Aria( t )
{
	this.SetMotion(2508, t.type);
	this.sx = this.sy = 2.00000000;
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.ReleaseActor();
		}
	};
}

function SAN_AddFont( t )
{
	this.SetMotion(2508, 12);
	this.alpha = 0.00000000;
	this.flag1 = -75;
	this.subState = function ()
	{
		this.flag1 -= 0.25000000;
		this.x = this.owner.target.x;
		this.y = this.owner.target.y + this.flag1;
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.alpha += 0.05000000;

		if (this.alpha >= 1.00000000)
		{
			this.alpha = 1.00000000;
			this.stateLabel = function ()
			{
				this.subState();
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SAN_Gauge( t )
{
	this.SetMotion(2508, 0);
	this.DrawScreenActorPriority(5);
	this.EnableTimeStop(false);
	this.sx = this.sy = 2.00000000;
	this.func = [
		function ( a_ )
		{
			if (a_)
			{
				this.isVisible = true;
				this.flag1.isVisible = true;

				foreach( a in this.flag2 )
				{
					if (a)
					{
						a.isVisible = true;
					}
				}
			}
			else
			{
				this.isVisible = false;
				this.flag1.isVisible = false;

				foreach( a in this.flag2 )
				{
					if (a)
					{
						a.isVisible = false;
					}
				}
			}
		},
		function ( s_ )
		{
			if (s_)
			{
				this.flag1.SetMotion(2508, 5);
				this.flag1.anime.width = 95 * (this.owner.san / 10000.00000000);

				foreach( a in this.flag2 )
				{
					if (a)
					{
						a.SetMotion(2508, 1);
					}
				}
			}
			else
			{
				this.flag1.SetMotion(2508, 2);
				this.flag1.anime.width = 95 * (this.owner.san / 10000.00000000);

				foreach( a in this.flag2 )
				{
					if (a)
					{
						a.SetMotion(2508, 7);
					}
				}
			}
		},
		function ( val_ )
		{
			if (this.owner.motion == 4901 && this.owner.keyTake <= 1)
			{
				return;
			}

			if (val_ >= 1.00000000)
			{
				this.flag3++;

				if (this.flag3 % 45 == 10)
				{
					this.SetFreeObject(this.owner.target.x, this.owner.target.y - 75, 1.00000000, this.owner.SAN_AddFont, {});
				}

				if (this.owner.san < 0)
				{
					this.owner.san = 0;
				}

				this.owner.san += val_.tointeger() + 10;

				if (this.isVisible == false)
				{
					this.func[0].call(this, true);
				}

				if (this.owner.san > 10000)
				{
					this.SetFreeObject(0, 0, 1.00000000, this.SAN_FieldBack, {});
					this.SetFreeObject(640, 360, 1.00000000, this.SAN_Field, {});
					this.owner.san_mode = true;
					this.owner.san = 10000;
					this.func[1].call(this, true);
					this.PlaySE(868);
					return true;
				}
			}
			else
			{
				this.flag3 = 0;
			}

			return false;
		}
	];
	this.flag1 = this.SetFreeObjectDynamic(this.x + 48 * this.direction, this.y, -this.direction, function ( t )
	{
		this.SetMotion(2508, 2);
		this.EnableTimeStop(false);
		this.DrawScreenActorPriority(5);
		this.sx = this.sy = 2.00000000;
	}, {}, this.weakref()).weakref();
	this.flag2 = [
		this.SetFreeObject(this.x - 106 * this.direction, this.y + 16, this.direction, this.SAN_GaugeEyeB, {}, this.weakref()).weakref(),
		null
	];
	this.flag3 = 0;
	this.flag1.anime.width = 0;
	this.stateLabel = function ()
	{
		if (::battle.state != 8)
		{
			this.owner.san = 0;
		}

		if (this.owner.motion == 4901)
		{
			return;
		}

		if (this.owner.san_mode == false)
		{
			if (this.owner.target.IsDamage() <= 1 && this.owner.target.IsRecover() == 0)
			{
				this.owner.san -= 10;
			}

			if (this.owner.san <= 0)
			{
				this.owner.san = 0;

				if (this.owner.san_gauge && this.isVisible)
				{
					this.func[0].call(this, false);
				}
			}
		}
		else
		{
			this.owner.san -= 10;

			if (this.owner.san <= 0)
			{
				this.func[1].call(this, false);
				this.func[0].call(this, false);
				this.owner.san_mode = false;
				this.owner.san = 0;
			}
		}

		this.flag1.anime.width = 95 * (this.owner.san / 10000.00000000);
	};
	this.func[0].call(this, false);
}

function SAN_GaugeEye( t )
{
	this.SetMotion(2508, 7);
	this.DrawScreenActorPriority(6);
	this.EnableTimeStop(false);
	this.func = [
		function ()
		{
			this.SetMotion(2508, this.keyTake);
			this.sx = this.sy = 2.00000000;
			this.alpha = 1.70000005;
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.01000000;
		this.alpha -= 0.01000000;

		if (this.alpha <= -0.00000000)
		{
			this.func[0].call(this);
		}
	};
	this.func[0].call(this);
	this.isVisible = t.pare.isVisible;
}

function SAN_GaugeEyeB( t )
{
	this.SAN_GaugeEye(t);
	this.EnableTimeStop(false);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 85)
		{
			if (this.initTable.pare)
			{
				this.initTable.pare.flag2[1] = this.SetFreeObject(this.x, this.y, this.direction, this.SAN_GaugeEye, {}, this.weakref()).weakref();
			}
		}

		this.sx = this.sy += 0.01000000;
		this.alpha -= 0.01000000;

		if (this.alpha <= -0.00000000)
		{
			this.func[0].call(this);
		}
	};
	this.isVisible = false;
}

function Grab_Eye( t )
{
	this.SetMotion(1809, 0);
	this.func = function ()
	{
		this.ReleaseActor();
	};
	this.keyAction = this.ReleaseActor;
}

function Shot_NormalFire( t )
{
	this.SetMotion(2009, 2);
	this.rz = t.rot;
	this.keyAction = this.ReleaseActor;
}

function Shot_NormalHit( t )
{
	this.SetMotion(2009, 3);
	this.keyAction = this.ReleaseActor;
}

function Shot_NormalSelf( t )
{
	this.SetMotion(2009, 6);
	this.SetParent(t.pare, 0, 0);
	this.SetTeamCheck();
	this.stateLabel = function ()
	{
		if (this.hitResult != 0)
		{
			this.SetParent(null, 0, 0);

			if (this.initTable.pare && this.initTable.pare.func[1])
			{
				this.initTable.pare.func[1].call(this.initTable.pare);
			}

			this.ReleaseActor();
		}
	};
}

function Shot_Normal( t )
{
	this.SetMotion(2009, 0);
	this.rz = t.rot;
	this.SetSpeed_Vec(11.00000000, this.rz, this.direction);
	this.cancelCount = 1;
	this.atk_id = 16384;
	this.linkObject = [
		this.SetShot(this.x, this.y, this.direction, this.Shot_NormalSelf, {}, this.weakref()).weakref()
	];
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_NormalFire, t_);
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x / 2.00000000;
	this.flag1.y = this.va.y / 2.00000000;
	this.flag2 = true;
	this.flag3 = ::manbow.Actor2DProcGroup();
	local v_ = this.Vector3();
	v_.y = 1.00000000;
	v_.RotateByRadian(this.rz);

	for( local i = 0; i < 3; i++ )
	{
		local t_ = {};
		t_.rot <- this.rz;
		t_.vec <- this.Vector3();
		t_.vec.x = v_.x * i * 2 * this.direction;
		t_.vec.y = v_.y * i * 2;
		local a_ = this.SetShot(this.x, this.y, this.direction, this.Shot_Normal_Side, t_, this.weakref());
		this.flag3.Add(a_);
		local t_ = {};
		t_.rot <- this.rz;
		t_.vec <- this.Vector3();
		t_.vec.x = -v_.x * i * 2 * this.direction;
		t_.vec.y = -v_.y * i * 2;
		local a_ = this.SetShot(this.x, this.y, this.direction, this.Shot_Normal_Side, t_, this.weakref());
		this.flag3.Add(a_);
	}

	this.func = [
		function ()
		{
			this.stateLabel = null;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(this.motion, 3);
			this.keyAction = this.ReleaseActor;
			this.func[1] = function ()
			{
			};

			if (this.linkObject[0])
			{
				this.ReleaseActor.call(this.linkObject[0]);
			}
		},
		function ()
		{
			if (this.owner.kune && this.flag2)
			{
				this.flag2 = false;
				this.flag3.Foreach(function ()
				{
				});
				this.owner.kune.func[2].call(this.owner.kune, 0.00000000);
				local t_ = {};
				t_.vx <- this.owner.kune.va.x;
				this.SetFreeObject(this.x, this.y, this.direction, this.Shot_NormalHit, t_);
				this.rz += this.initTable.addRot;
				this.flag1.RotateByRadian(this.initTable.addRot * this.direction);

				for( local i = -1; i < 2; i++ )
				{
					if (i != 0)
					{
						local t_ = {};
						t_.rot <- this.rz + i * 6 * 0.01745329;
						this.SetShot(this.x + this.va.x, this.y + this.va.y, this.direction, this.Shot_NormalSub, t_);
					}
				}

				this.subState = function ()
				{
					this.count++;
					local r_ = this.cos(this.count * 0.17453292) * 0.50000000;
					this.SetSpeed_XY(this.flag1.x * r_ + this.flag1.x, this.flag1.y * r_ + this.flag1.y);
				};
			}
		},
		function ()
		{
			this.rz += this.initTable.addRot;
			this.flag1.RotateByRadian(this.initTable.addRot * this.direction);

			for( local i = -1; i < 2; i++ )
			{
				if (i != 0)
				{
					local t_ = {};
					t_.rot <- this.rz + i * 0.10471975;
					this.SetShot(this.x, this.y, this.direction, this.Shot_NormalSub, t_);
				}
			}

			this.subState = function ()
			{
				this.count++;
				local r_ = this.cos(this.count * 0.17453292) * 0.50000000;
				this.SetSpeed_XY(this.flag1.x * r_ + this.flag1.x, this.flag1.y * r_ + this.flag1.y);
			};
		}
	];
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP.call(this, this.x, this.y, 3))
		{
			this.func[1] = function ()
			{
			};
			this.ReleaseActor();
			return;
		}

		if (this.hitCount >= 1 || this.cancelCount <= 0 || this.grazeCount >= 1)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};

	if (t.san)
	{
		this.func[2].call(this);
	}
}

function Shot_Normal_Side( t )
{
	this.SetMotion(2009, 7);
	this.rz = t.rot;
	this.SetSpeed_Vec(11.00000000, this.rz, this.direction);
	this.AddSpeed_XY(t.vec.x, t.vec.y);
	this.cancelCount = 1;
	this.atk_id = 16384;
	this.linkObject = [
		this.SetShot(this.x, this.y, this.direction, this.Shot_NormalSelf, {}, this.weakref()).weakref()
	];
	this.hitOwner = t.pare;
	this.func = [
		function ()
		{
			this.stateLabel = null;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(this.motion, 3);
			this.keyAction = this.ReleaseActor;
			this.func[1] = function ()
			{
			};

			if (this.linkObject[0])
			{
				this.ReleaseActor.call(this.linkObject[0]);
			}
		},
		function ()
		{
			if (this.hitOwner && this.hitOwner.flag2)
			{
				this.hitOwner.func[1].call(this.hitOwner);
			}
		},
		function ()
		{
			this.rz += this.initTable.addRot;
			this.flag1.RotateByRadian(this.initTable.addRot * this.direction);

			for( local i = -1; i < 2; i++ )
			{
				if (i != 0)
				{
					local t_ = {};
					t_.rot <- this.rz + i * 0.10471975;
					this.SetShot(this.x, this.y, this.direction, this.Shot_NormalSub, t_);
				}
			}

			this.subState = function ()
			{
				this.count++;
				local r_ = this.cos(this.count * 0.17453292) * 0.50000000;
				this.SetSpeed_XY(this.flag1.x * r_ + this.flag1.x, this.flag1.y * r_ + this.flag1.y);
			};
		},
		function ()
		{
			if (this.linkObject[0])
			{
				this.linkObject[0].ReleaseActor();
				this.linkObject[0] = null;
			}
		}
	];
	this.subState = function ()
	{
		this.count++;

		if (this.count == 15)
		{
			this.SetSpeed_Vec(11.00000000, this.rz, this.direction);
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.team.current.IsDamage() >= 1)
		{
			this.func[1] = function ()
			{
			};
			this.ReleaseActor();
			return;
		}

		if (!this.hitOwner || this.hitOwner.hitCount >= 1 || this.hitOwner.cancelCount <= 0 || this.hitOwner.grazeCount >= 1)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Shot_NormalSub( t )
{
	this.SetMotion(2009, 4);
	this.rz = t.rot;
	this.SetSpeed_Vec(15.00000000, this.rz, this.direction);
	this.cancelCount = 1;
	this.atk_id = 16384;
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x / 2.00000000;
	this.flag1.y = this.va.y / 2.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = null;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(this.motion, 3);
			this.keyAction = this.ReleaseActor;
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP.call(this, this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount >= 1 || this.cancelCount <= 0 || this.grazeCount >= 1)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;
		local r_ = this.cos(this.count * 0.17453292) * 0.50000000;
		this.SetSpeed_XY(this.flag1.x * r_ + this.flag1.x, this.flag1.y * r_ + this.flag1.y);
	};
}

function Shot_FrontFire( t )
{
	this.SetMotion(2019, 2);
	this.sy = 0.25000000;
	this.sx = this.sy * 0.33000001;
	this.rz = t.rot;
	this.stateLabel = function ()
	{
		this.alpha -= 0.10000000;
		this.sy += 0.15000001;
		this.sx = this.sy * 0.33000001;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_FrontWave( t )
{
	this.SetMotion(2019, 1);
	this.SetParent(t.pare, 0, 0);
	this.sy = 0.25000000;
	this.sx = this.sy * 0.33000001;
	this.rz = t.rot;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.anime.top -= 6.00000000;
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.anime.top -= 6.00000000;
	};
}

function Shot_FrontSelf( t )
{
	this.SetMotion(2019, 5);
	this.SetParent(t.pare, 0, 0);
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetTeamCheck();
	this.stateLabel = function ()
	{
		if (this.hitResult != 0)
		{
			this.SetParent(null, 0, 0);

			if (this.owner.kune)
			{
				this.owner.kune.func[6].call(this.owner.kune, 6.00000000 * this.direction);
			}

			this.ReleaseActor();
		}
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 0);
	this.rz = t.rot;
	this.SetSpeed_Vec(15.00000000, this.rz, this.direction);
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.atk_id = 65536;
	this.cancelCount = 2;
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_FrontFire, t_);
	this.linkObject = [
		this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Shot_FrontWave, t_, this).weakref(),
		null
	];
	local t_ = {};
	t_.rot <- this.rz;
	this.linkObject[1] = this.SetShot(this.x, this.y, this.direction, this.Shot_FrontSelf, t_, this.weakref()).weakref();
	this.func = function ()
	{
		this.SetMotion(2019, 2);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.linkObject[0].func();
		this.stateLabel = function ()
		{
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.sy = 0.25000000;
	this.sx = this.sy * 0.33000001;
	this.SetCollisionScaling(this.sy, this.sy, 1.00000000);
	this.linkObject[0].sy = this.sy;
	this.linkObject[0].sx = this.sx * 0.33000001;
	this.linkObject[1].sy = this.sy;
	this.linkObject[1].sx = this.sx;
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP.call(this, this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.hitResult & 32)
		{
			if (this.hitResult & 1 && this.owner.san_mode == false)
			{
				this.owner.san += 300;

				if (this.owner.san > 9988)
				{
					this.owner.san = 9988;
				}

				if (this.owner.san_gauge)
				{
					this.owner.san_gauge.func[2].call(this.owner.san_gauge, 1.00000000);
				}
			}

			this.func();
			return true;
		}

		this.count++;

		if (this.initTable.san)
		{
			this.sy += 0.04000000;

			if (this.sy > 2.75000000)
			{
				this.sy = 2.75000000;
			}
		}
		else
		{
			this.sy += 0.03250000;

			if (this.sy > 2.00000000)
			{
				this.sy = 2.00000000;
			}
		}

		this.sx = this.sy * 0.33000001;
		this.SetCollisionScaling(this.sy, this.sy, 1.00000000);
		this.linkObject[0].sy = this.sy;
		this.linkObject[0].sx = this.sy * 0.33000001;

		if (this.linkObject[1])
		{
			this.linkObject[1].SetCollisionScaling(this.sy, this.sy, 1.00000000);
		}

		this.Vec_Brake(0.50000000, 10.00000000);
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
	this.SetSpeed_Vec(17.50000000, this.rz, this.direction);
	this.atk_id = 262144;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, 3);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.stateLabel = function ()
		{
		};
		this.keyAction = this.ReleaseActor;
	};
	this.subState = function ()
	{
		if (this.Vec_Brake(0.40000001, 3.00000000))
		{
			this.subState = function ()
			{
			};
		}
	};
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

		this.subState();
	};
}

function Shot_Charge_FireFlash( t )
{
	this.rz = t.rot;
	this.SetMotion(2029, 6);
	this.cancelCount = 3;
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP.call(this, this.x, this.y, 0))
		{
			this.ReleaseActor();
			return;
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2029, 3);
	this.SetSpeed_Vec(30.00000000, t.rot, this.direction);
	this.rz = t.rot;
	this.flag1 = 20.00000000;
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.stateLabel = function ()
	{
		this.SetCollisionScaling(1.00000000, this.anime.radius1 * 0.05000000, 1.00000000);
		this.anime.radius1 += this.va.x * 0.50000000;
		this.anime.radius0 += this.va.x * 0.50000000;
	};
}

function Shot_ChargeSelf( t )
{
	this.SetMotion(2029, 7);
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetParent(t.pare, 0, 0);
	this.SetTeamCheck();
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		if (this.hitResult != 0)
		{
			if (this.owner.kune)
			{
				this.owner.kune.func[2].call(this.owner.kune, 15.00000000 * this.direction);

				if (this.initTable.core)
				{
					this.initTable.core.flag5 = true;
				}
			}

			this.ReleaseActor();
		}
	};
}

function Shot_ChargeBullet( t )
{
	this.SetMotion(2029, 4);
	this.SetSpeed_Vec(30.00000000 + this.rand() % 11, t.rot, this.direction);
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.Warp(this.x + this.va.x * 4, this.y + this.va.y * 4);
	local t_ = {};
	t_.rot <- this.rz;
	t_.core <- t.core;
	this.linkObject = [
		this.SetShot(this.x, this.y, this.direction, this.Shot_ChargeSelf, t_, this.weakref()).weakref()
	];
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP.call(this, this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0)
		{
			this.keyAction();
			this.SetMotion(this.motion, 5);
			return;
		}

		this.SetSpeed_XY(this.va.x * 0.98000002, this.va.y * 0.98000002);
		this.sx = this.sy *= 0.98000002;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.sx <= 0.02500000)
		{
			this.ReleaseActor();
		}
	};
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			this.SetSpeed_XY(this.va.x * 0.69999999, this.va.y * 0.69999999);
			this.sx = this.sy *= 0.69999999;
			this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

			if (this.linkObject[0])
			{
				this.linkObject[0].SetCollisionScaling(this.sx, this.sy, 1.00000000);
			}

			if (this.sx <= 0.02500000)
			{
				this.ReleaseActor();
			}
		};
	};
}

function Shot_ChargeExpCore( t )
{
	this.flag3 = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag3[3].x = 0;
	this.flag3[0].y = 50;
	this.flag3[2].x = 75;
	this.flag3[1].y = -75;
	this.flag3[1].x = 125;
	this.flag3[2].y = 100;
	this.flag3[0].x = 200;
	this.flag3[3].y = -20;
	this.flag4 = 3;
	this.flag5 = t.san;

	if (t.rot != 0)
	{
		foreach( a in this.flag3 )
		{
			a.RotateByRadian(t.rot);
		}
	}

	this.SetSpeed_Vec(26, t.rot, this.direction);
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP.call(this, this.x, this.y, 0))
		{
			this.ReleaseActor();
			return;
		}

		this.count++;

		if (this.va.x > 0.00000000 && this.x > ::battle.corner_right - 75 || this.va.x < 0.00000000 && this.x < ::battle.corner_left + 75)
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
		}

		if (this.count >= 8 && this.count % 2 == 0)
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);

			if (this.flag4 < 0)
			{
				this.ReleaseActor();
			}
			else
			{
				local t_ = {};
				t_.se <- 0;
				t_.scale <- 1.00000000;
				t_.kune <- this.flag5;

				if (this.flag5)
				{
					t_.scale = 1.75000000;
				}

				if (this.flag4 == 3)
				{
					t_.se = 3887;
				}

				this.SetShot(this.x + this.flag3[this.flag4].x * this.direction, this.y + this.flag3[this.flag4].y, this.direction, this.Shot_ChargeExp, t_, {});
				this.flag4--;
			}
		}
	};
}

function Shot_FullChargeExpCore( t )
{
	this.flag3 = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag3[11].x = 0;
	this.flag3[11].y = 50;
	this.flag3[11].z = 1.00000000;
	this.flag3[10].x = 75;
	this.flag3[10].y = -75;
	this.flag3[10].z = 1.00000000;
	this.flag3[9].x = 125;
	this.flag3[9].y = 100;
	this.flag3[9].z = 1.00000000;
	this.flag3[8].x = 200;
	this.flag3[8].y = -20;
	this.flag3[8].z = 1.00000000;
	this.flag3[7].x = 300;
	this.flag3[7].y = -100;
	this.flag3[7].z = 1.20000005;
	this.flag3[6].x = 360;
	this.flag3[6].y = -150;
	this.flag3[6].z = 1.39999998;
	this.flag3[5].x = 410;
	this.flag3[5].y = 125;
	this.flag3[5].z = 1.50000000;
	this.flag3[4].x = 550;
	this.flag3[4].y = -150;
	this.flag3[4].z = 1.60000002;
	this.flag3[3].x = 650;
	this.flag3[3].y = 175;
	this.flag3[3].z = 1.79999995;
	this.flag3[2].x = 850;
	this.flag3[2].y = 25;
	this.flag3[2].z = 2.00000000;
	this.flag3[1].x = 960;
	this.flag3[1].y = 250;
	this.flag3[1].z = 2.00000000;
	this.flag3[0].x = 1020;
	this.flag3[0].y = -200;
	this.flag3[0].z = 2.00000000;
	this.flag4 = 11;
	this.flag5 = false;

	if (t.rot != 0)
	{
		foreach( a in this.flag3 )
		{
			a.RotateByRadian(t.rot);
		}
	}

	this.SetSpeed_Vec(13, t.rot, this.direction);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.va.x > 0.00000000 && this.x > ::battle.corner_right - 75 || this.va.x < 0.00000000 && this.x < ::battle.corner_left + 75)
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
		}

		if (this.count >= 16 && this.count % 2 == 0)
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);

			if (this.flag4 < 0)
			{
				this.ReleaseActor();
			}
			else
			{
				local t_ = {};
				t_.se <- 0;
				t_.scale <- this.flag3[this.flag4].z;
				t_.kune <- this.flag5;

				if (this.flag4 == 11)
				{
					t_.se = 3889;
				}

				this.SetShot(this.x + this.flag3[this.flag4].x * this.direction, this.y + this.flag3[this.flag4].y, this.direction, this.Shot_FullChargeExp, t_, {});
				this.flag4--;
			}
		}
	};
}

function Shot_ChargeExp( t )
{
	this.SetMotion(2029, 0);
	this.DrawActorPriority(189);
	this.rz = this.rand() % 360 * 0.01745329;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.94999999;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.initTable.se)
			{
				this.PlaySE(this.initTable.se);
			}

			this.SetSpeed_XY(10.00000000 * this.direction, 0.00000000);
			this.sx = this.sy = 0.10000000;
			this.SetCollisionScaling(this.initTable.scale, this.initTable.scale, 1.00000000);
			this.cancelCount = 3;
			this.SetMotion(2029, 1);
			this.stateLabel = function ()
			{
				if (this.Damage_ConvertOP.call(this, this.x, this.y, 4))
				{
					this.SetMotion(2029, 2);
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.stateLabel = function ()
					{
						this.sx = this.sy *= 0.80000001;
						this.alpha -= 0.10000000;

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}

				this.VX_Brake(0.85000002, 0.50000000 * this.direction);
				this.sx = this.sy += (this.initTable.scale - this.sx) * 0.33000001;
			};
		}
	];
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.func[1].call(this);
}

function Shot_FullChargeExp( t )
{
	this.SetMotion(2029, 8);
	this.DrawActorPriority(189);
	this.atk_id = 131072;
	this.rz = this.rand() % 360 * 0.01745329;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.94999999;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.initTable.se)
			{
				this.PlaySE(this.initTable.se);
			}

			this.sx = this.sy = 0.10000000;
			this.SetCollisionScaling(this.initTable.scale, this.initTable.scale, 1.00000000);
			this.cancelCount = 3;
			this.SetMotion(2029, 8);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (this.initTable.scale - this.sx) * 0.33000001;
			};
		}
	];
	this.keyAction = function ()
	{
		if (this.initTable.kune)
		{
			for( local i = 0; i < 360; i = i + 30 )
			{
				local t_ = {};
				t_.rot <- this.rz + i * 0.01745329;
				this.SetShot(this.x, this.y, this.direction, this.Shot_FullCharge_BulletB, t_);
			}
		}
		else
		{
			for( local i = 0; i < 360; i = i + 45 )
			{
				local t_ = {};
				t_.rot <- this.rz + i * 0.01745329;
				this.SetShot(this.x, this.y, this.direction, this.Shot_FullCharge_BulletB, t_);
			}
		}

		this.stateLabel = function ()
		{
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.func[1].call(this);
}

function Shot_FullCharge_BulletB( t )
{
	this.SetMotion(2029, 10);
	this.SetSpeed_Vec(3.00000000, t.rot, this.direction);
	this.atk_id = 131072;
	this.rz = t.rot;
	this.sx = this.sy = 0.10000000;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.cancelCount = 1;
	this.stateLabel = function ()
	{
		if (this.IsScreen(100.00000000))
		{
			this.ReleaseActor();
			return;
		}

		this.count++;

		if (this.grazeCount > 0 || this.cancelCount <= 0 || this.hitCount > 0 || this.count >= 90)
		{
			this.keyAction();
			this.SetMotion(this.motion, 11);
			return;
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.05000000;
	};
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0.89999998;
			this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

			if (this.sx <= 0.02500000)
			{
				this.ReleaseActor();
			}
		};
	};
}

function Shot_ChangeWave( t )
{
	this.SetMotion(3929, 1);
	this.SetParent(t.pare, 0, 0);
	this.sy = 0.25000000;
	this.sx = this.sy * 0.33000001;
	this.rz = t.rot;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.anime.top -= 3.00000000;
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.anime.top -= 3.00000000;
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.rz = t.rot;
	this.SetSpeed_Vec(t.v, this.rz, this.direction);
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.atk_id = 536870912;
	this.cancelCount = 1;
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_FrontFire, t_);
	this.linkObject = [
		this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Shot_ChangeWave, t_, this.weakref()).weakref(),
		null
	];
	local t_ = {};
	t_.rot <- this.rz;
	this.linkObject[1] = this.SetShot(this.x, this.y, this.direction, this.Shot_FrontSelf, t_, this.weakref()).weakref();
	this.func = function ()
	{
		this.SetMotion(3929, 2);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.linkObject[0].func();
		this.stateLabel = function ()
		{
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.sy = 0.25000000;
	this.sx = this.sy * 0.50000000;
	this.linkObject[0].sy = this.sy;
	this.linkObject[0].sx = this.sx * 0.50000000;
	this.linkObject[1].sy = this.sy;
	this.linkObject[1].sx = this.sx;
	this.SetCollisionScaling(this.sy, this.sy, 1.00000000);
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP.call(this, this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.hitResult & 32)
		{
			this.func();
			return true;
		}

		if (this.initTable.san)
		{
			this.sy += 0.04000000;

			if (this.sy > 2.75000000)
			{
				this.sy = 2.75000000;
			}
		}
		else
		{
			this.sy += 0.02500000;

			if (this.sy > 1.50000000)
			{
				this.sy = 1.50000000;
			}
		}

		this.sx = this.sy * 0.50000000;
		this.SetCollisionScaling(this.sy, this.sy, 1.00000000);
		this.linkObject[0].sy = this.sy;
		this.linkObject[0].sx = this.sy * 0.50000000;

		if (this.linkObject[1])
		{
			this.linkObject[1].SetCollisionScaling(this.sy, this.sy, 1.00000000);
		}
	};
}

function Shot_Change_Trail( t )
{
	this.SetMotion(3929, 0);
	this.rz = t.rot;
	this.sy = t.scale;
	this.sx = this.sy;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.cancelCount = 1;
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_FrontFire, t_);
	this.linkObject = [
		this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Shot_ChangeWave, t_, this.weakref()).weakref(),
		null
	];
	this.func = function ()
	{
		this.SetMotion(3929, 2);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.linkObject[0].func();
		this.stateLabel = function ()
		{
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.SetCollisionScaling(this.sy, this.sy, 1.00000000);
	this.linkObject[0].sy = this.sy;
	this.linkObject[0].sx = this.sx;
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP.call(this, this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.hitResult & 32 || this.count >= 60)
		{
			this.func();
			return true;
		}

		this.count++;
		this.SetCollisionScaling(this.sy, this.sy, 1.00000000);
	};
}

function DeadUsu( t )
{
	this.SetMotion(2509, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);
		this.alpha = this.red = this.blue = this.green -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Occult_PlayerName( t )
{
	if (this.owner.team == 1)
	{
		this.SetMotion(2509, 22);
	}
	else
	{
		this.SetMotion(2509, 23);
	}

	this.DrawActorPriority(201);
	this.SetParent(t.pare, 0, -25);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Occult_Shot( t )
{
	if (t.type == 0)
	{
		this.SetMotion(2509, 0);
	}
	else
	{
		this.SetMotion(2510, 0);
	}

	this.target = this.owner.target.weakref();
	this.life = 1000;
	this.atk_id = 524288;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.pos <- this.Vector3();
	this.flag5.level <- 3;
	this.flag5.range <- 1.00000000;
	this.flag5.rangeBase <- 103 * 5;
	this.flag5.player <- null;
	this.func = [
		function ()
		{
			this.life = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.flag3 = null;
			this.SetMotion(this.motion, 11);
			this.stateLabel = null;

			if (this.owner.kune == this)
			{
				this.owner.kune = null;
			}
		},
		function ( san_ )
		{
			if (san_)
			{
				this.func[11].call(this);
				return;
			}

			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 2);
		},
		function ( vx_ )
		{
			this.SetMotion(this.motion, 4);
			this.count = 0;
			this.life -= 100;
			this.PlaySE(3878);
			this.SetSpeed_XY(vx_, this.va.y);

			if (this.va.x > 0 && this.x > ::battle.corner_right - 80 || this.va.x < 0 && this.x < ::battle.corner_left + 80)
			{
				this.SetSpeed_XY(0.00000000, this.va.y);
			}

			this.subState = function ()
			{
				this.count++;

				if (this.count == 30)
				{
					if (this.life <= 0)
					{
						this.func[0].call(this);
						return;
					}
					else
					{
						this.func[7].call(this);
					}
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 6);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.count = 0;
			this.HitReset();
			this.life -= 1000;
			this.flag1 = null;
			this.flag2 = null;

			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.subState = function ()
			{
				this.count++;

				if (this.count == 35)
				{
					this.PlaySE(3880);
					this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_D_KuneShadow, {}, this.weakref()).weakref();
					this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D_Kune, {}, this.weakref()).weakref();
					this.SetMotion(this.motion, 7);
					this.count = 0;
					this.subState = function ()
					{
						this.count++;

						if (this.count >= 40)
						{
							if (this.flag1)
							{
								this.flag1.func[0].call(this.flag1);
							}

							if (this.life <= 0)
							{
								this.func[0].call(this);
								return;
							}
							else
							{
								this.func[7].call(this);
							}
						}
					};
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 8);
			this.count = 0;
			this.life = 0;

			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.PlaySE(3879);
			this.subState = function ()
			{
				this.count++;

				if (this.count % 64 == 32)
				{
					this.life -= 200;
					this.PlaySE(3883);
					this.SetShot(this.x, this.y - 75, this.direction, this.SPShot_C_Poison, {}, this);
				}

				if (this.life <= -1000 && this.count % 64 == 63)
				{
					this.SetMotion(this.motion, 7);
					this.count = 0;
					this.func[0].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 9);
			this.count = 0;
			this.flag1 = this.Vector3();
			this.life -= 1000;
			this.SetSpeed_XY(0.00000000, 0.00000000);

			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.subState = function ()
			{
				this.count++;

				if (this.count >= 45)
				{
					if (this.life <= 0)
					{
						this.func[0].call(this);
					}
					else
					{
						this.func[7].call(this);
					}
				}
			};
		},
		function ( x_ )
		{
			this.SetSpeed_XY(x_, this.va.y);

			if (this.va.x > 0 && this.x > ::battle.corner_right - 80 || this.va.x < 0 && this.x < ::battle.corner_left + 80)
			{
				this.SetSpeed_XY(0.00000000, this.va.y);
			}
		},
		function ()
		{
			this.SetMotion(this.motion, 5);
			this.count = 0;
			this.subState = function ()
			{
			};
		},
		function ()
		{
			this.life = 0;
			this.SetMotion(this.motion, 14);

			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.count = 0;
			this.flag3 = null;
			this.flag3 = ::manbow.Aura();
			this.flag3.Init(this, 90, 45, 1);
			this.flag3.ConnectRenderSlot(::graphics.slot.actor, this.drawPriority);
			this.DrawActorPriority(this.drawPriority);
			this.flag3.blue = 0.20000000;
			this.flag3.green = 0.00000000;
			this.flag3.scale = 1.50000000;
			this.subState = function ()
			{
				if (this.flag3)
				{
					this.flag3.Update();
				}

				this.flag5.pos.x = this.owner.target.x - this.x;
				this.flag5.pos.y = this.owner.target.y - this.y;
				local x_ = this.flag5.pos.Length();

				if (::battle.state == 8 && !this.owner.IsDamage())
				{
					if (this.flag5.pos.x * this.owner.target.direction > 0)
					{
						this.owner.san -= 20;

						if (this.owner.san < 0)
						{
							this.owner.san = 0;
						}
					}
					else
					{
						this.owner.san -= 10;

						if (this.owner.san < 0)
						{
							this.owner.san = 0;
						}
					}
				}

				if (this.owner.san_mode == false)
				{
					this.func[0].call(this);
					return;
				}
			};
		},
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.SetMotion(this.motion, 6);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.count = 0;
			this.HitReset();
			this.life -= 1000;
			this.flag1 = null;
			this.flag2 = null;
			this.subState = function ()
			{
				this.count++;

				if (this.count == 20)
				{
					this.PlaySE(3881);
					this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_D_KuneShadow, {}, this.weakref()).weakref();
					this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_C_Kune, {}, this.weakref()).weakref();
					this.SetMotion(this.motion, 7);
					this.count = 0;
					this.subState = function ()
					{
						this.count++;

						if (this.count >= 60)
						{
							if (this.flag1)
							{
								this.flag1.func[0].call(this.flag1);
							}

							if (this.life <= 0)
							{
								this.func[0].call(this);
								return;
							}
							else
							{
								this.func[7].call(this);
							}
						}
					};
				}
			};
		},
		function ()
		{
			if (this.life <= 0)
			{
				return;
			}

			this.SetMotion(this.motion, 16);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.count = 0;
			this.HitReset();
			this.flag5.range = 4.00000000;

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.subState = function ()
			{
				this.count++;
				this.subState = function ()
				{
					this.count++;

					if (this.count >= 90)
					{
						if (this.flag1)
						{
							this.flag1.func[0].call(this.flag1);
						}

						if (this.life <= 0)
						{
							this.func[0].call(this);
							return;
						}
						else
						{
							this.flag5.range = 1.00000000;
							this.func[7].call(this);
						}
					}
				};
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 18);
		}
	];
	this.keyAction = [
		null,
		null,
		function ()
		{
			this.SetTeamCheckTarget();
			this.stateLabel = function ()
			{
				if (::battle.state & (128 | 32))
				{
					this.func[0].call(this);
					return;
				}

				this.subState();
				this.VX_Brake(0.50000000);

				if (this.owner.IsDamage())
				{
					return;
				}
				else if (this.flag4 == null && this.owner.san_mode == false)
				{
					local t_ = {};
					t_.type <- this.flag5.level + 8;
					this.flag4 = this.SetFreeObject(this.x, this.y, this.direction, this.SAN_Aria, t_).weakref();
					this.flag4.SetParent(this, 0, 0);
				}

				if (this.va.x > 0 && this.x > ::battle.corner_right - 80 || this.va.x < 0 && this.x < ::battle.corner_left + 80)
				{
					this.SetSpeed_XY(0.00000000, this.va.y);
				}

				if (this.owner.san_mode == false)
				{
					if (this.owner.target.IsDamage() <= 1 && this.owner.target.IsRecover() == 0)
					{
						this.flag5.pos.x = this.owner.target.x - this.x;
						this.flag5.pos.y = this.owner.target.y - this.y;
						local x_ = this.flag5.pos.Length();

						if (this.flag5.pos.x * this.owner.target.direction < 0 && x_ < this.flag5.rangeBase * this.flag5.range && ::battle.state == 8)
						{
							if (this.keyTake == 3 || this.keyTake == 17)
							{
								local s_ = 50 * (1.00000000 - x_ / (this.flag5.rangeBase * this.flag5.range)) * this.flag5.range;

								if (s_ >= 1.00000000)
								{
									if (this.owner.san_gauge && this.owner.san_gauge.func[2].call(this.owner.san_gauge, s_))
									{
										this.func[8].call(this);
										return;
									}
								}
							}
						}
					}
				}
				else if (this.owner.san <= 0)
				{
					this.func[0].call(this);
					return;
				}
			};

			if (this.owner.san_mode)
			{
				this.func[8].call(this);
				return;
			}
		},
		null,
		null,
		function ()
		{
			if (this.owner.san_mode)
			{
				this.func[8].call(this);
				return;
			}
			else
			{
				this.SetMotion(this.motion, 3);
				this.SetTeamCheckTarget();
				this.stateLabel = function ()
				{
					if (::battle.state & (128 | 32))
					{
						this.func[0].call(this);
						return;
					}

					this.subState();
					this.VX_Brake(0.50000000);

					if (this.va.x > 0 && this.x > ::battle.corner_right - 80 || this.va.x < 0 && this.x < ::battle.corner_left + 80)
					{
						this.SetSpeed_XY(0.00000000, this.va.y);
					}

					if (this.owner.san_mode == false)
					{
						this.flag5.pos.x = this.owner.target.x - this.x;
						this.flag5.pos.y = this.owner.target.y - this.y;
						local x_ = this.flag5.pos.Length();

						if (this.flag5.pos.x * this.owner.target.direction < 0 && x_ < this.flag5.rangeBase * this.flag5.range && ::battle.state == 8)
						{
							if (this.keyTake == 3 || this.keyTake == 17)
							{
								local s_ = 50 * (1.00000000 - x_ / (this.flag5.rangeBase * this.flag5.range)) * this.flag5.range;

								if (s_ >= 1.00000000)
								{
									if (this.owner.san_gauge && this.owner.san_gauge.func[2].call(this.owner.san_gauge, s_))
									{
										this.func[8].call(this);
										return;
									}
								}
							}
						}
					}
					else if (this.owner.san <= 0)
					{
						this.func[0].call(this);
						return;
					}
				};
			}
		},
		null,
		function ()
		{
			this.SetMotion(this.motion, 5);
		},
		null,
		null,
		function ()
		{
			this.SetMotion(this.motion, 5);
		},
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.SetFreeObject(this.x, this.y, this.direction, this.DeadUsu, {});
			this.PlaySE(3877);
			this.SetSpeed_XY(0.00000000, -8.00000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VY_Brake(0.69999999);
			};
		},
		function ()
		{
			this.ReleaseActor();
		},
		null,
		null,
		null,
		null,
		null,
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.count = 0;
			this.PlaySE(3881);
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_D_KuneShadow, {}, this.weakref()).weakref();
			this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Occult_ShotSanMax, {}, this.weakref()).weakref();
			this.subState = function ()
			{
				this.count++;

				if (this.count >= 30)
				{
					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.func[7].call(this);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
		this.VX_Brake(0.50000000);

		if (this.va.x > 0 && this.x > ::battle.corner_right - 80 || this.va.x < 0 && this.x < ::battle.corner_left + 80)
		{
			this.SetSpeed_XY(0.00000000, this.va.y);
		}
	};
	this.subState = function ()
	{
	};
}

function Occult_ShotSanMax( t )
{
	this.SetMotion(2509, 20);
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
	this.cancelCount = 3;
	this.atk_id = 524288;
	this.keyAction = this.ReleaseActor;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function SPShot_A_Self( t )
{
	this.SetMotion(3009, 5);
	this.SetParent(t.pare, 0, 0);
	this.SetTeamCheck();
	this.stateLabel = function ()
	{
		if (this.hitResult != 0)
		{
			this.SetParent(null, 0, 0);

			if (this.initTable.pare && this.initTable.pare.func[1])
			{
				this.initTable.pare.func[1].call(this.initTable.pare);
			}

			this.ReleaseActor();
		}
	};
}

function SPShot_A_Fire( t )
{
	this.SetMotion(3009, 6);
	this.keyAction = this.ReleaseActor;
}

function SPShot_A_Buff( t )
{
	this.SetMotion(3009, 2);
	this.keyAction = this.ReleaseActor;
}

function SPShot_A( t )
{
	this.SetMotion(3009, 0);
	this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_A_Fire, {}, null);
	this.atk_id = 1048576;
	this.flag1 = 0;
	this.SetSpeed_Vec(20.00000000, t.rot, this.direction);
	this.AddSpeed_XY(5.00000000 * this.direction, 0.00000000);
	this.flag1 = t.rot2;

	if (this.va.y > 0)
	{
		this.flag1 *= -1.00000000;
	}

	this.cancelCount = 3;
	this.sx = this.sy = 2.00000000;
	this.FitBoxfromSprite();
	this.func = [
		function ()
		{
			this.SetMotion(3009, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.keyAction = this.ReleaseActor;

			if (this.linkObject[1])
			{
				this.ReleaseActor.call(this.linkObject[1]);
			}

			this.stateLabel = function ()
			{
				this.linkObject[0].anime.radius0 *= 0.50000000;
			};
		},
		function ()
		{
			if (this.owner.kune)
			{
				this.SetMotion(3009, 4);
				this.SetTrail(this.motion, 3, 10, 30);
				this.owner.kune.func[2].call(this.owner.kune, 5.00000000 * this.direction);
				this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_A_Buff, {});
				this.func[1] = null;
				this.va.SetLength(35.00000000);
				this.ConvertTotalSpeed();
				this.func[0] = function ()
				{
					this.SetMotion(3009, 2);
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.keyAction = this.ReleaseActor;
					this.stateLabel = function ()
					{
						this.linkObject[0].anime.radius0 *= 0.50000000;
						this.linkObject[2].anime.radius0 *= 0.50000000;
					};
				};
				this.subState = function ()
				{
					this.TargetHoming(this.owner.target, 0.01745329 * 3.00000000, this.direction);
				};
			}
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP.call(this, this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.sx > 1.00000000)
		{
			this.sx = this.sy -= 0.05000000;
			this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		}

		this.subState();

		if (this.grazeCount > 0 || this.cancelCount <= 0 || this.hitResult & 31)
		{
			this.func[0].call(this);
			return;
		}
	};

	if (t.san)
	{
		this.SetMotion(3009, 4);
		this.SetTrail(this.motion, 3, 10, 30);
		this.va.SetLength(35.00000000);
		this.ConvertTotalSpeed();
		this.func[0] = function ()
		{
			this.SetMotion(3009, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = function ()
			{
				this.linkObject[0].anime.radius0 *= 0.50000000;
			};
		};
		this.subState = function ()
		{
			this.TargetHoming(this.owner.target, 0.01745329 * 3.00000000, this.direction);
		};
		return;
	}

	this.SetTrail(this.motion, 3, 15, 10);
	this.linkObject.append(this.SetShot(this.x, this.y, this.direction, this.SPShot_A_Self, {}, this.weakref()).weakref());
	this.subState = function ()
	{
		this.va.RotateByRadian(this.flag1 * this.direction);
		this.ConvertTotalSpeed();

		if (this.fabs(this.va.y) >= 15.00000000)
		{
			this.SetSpeed_XY(20.00000000 * this.direction, 0.00000000);
			this.flag1 *= -1.00000000;
		}
	};
}

function SPShot_B_Udon( t )
{
	this.SetMotion(3018, 0);
	this.DrawActorPriority(t.priority);
	this.flag1 = 2;
	this.flag2 = 0;
	this.flag3 = true;
	this.flag4 = this.owner.san_mode;
	this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);

	if (this.x < ::battle.corner_left + 50 && this.direction == 1.00000000 || this.x > ::battle.corner_right - 50 && this.direction == -1.00000000)
	{
		this.Warp(640 - 590 * this.direction, this.y);
	}

	this.cancelCount = 1;
	this.atk_id = 2097152;
	this.func = [
		function ()
		{
			if (this.owner.skillB_SE)
			{
				this.PlaySE(3846);
				this.owner.skillB_SE = false;
			}

			this.keyAction = this.ReleaseActor;
			this.SetMotion(3018, 2);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(-2.50000000 * this.direction, 0.00000000);
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				this.VX_Brake(1.00000000, -0.50000000 * this.direction);

				if (this.x < ::battle.corner_left + 50 && this.direction == 1.00000000 || this.x > ::battle.corner_right - 50 && this.direction == -1.00000000)
				{
					this.Warp(640 - 590 * this.direction, this.y);
				}

				this.count++;

				if (this.count >= 5 && this.count % 4 == 1)
				{
					if (this.flag2 <= 2)
					{
						this.PlaySE(3844);
						local t_ = {};
						t_.rot <- this.rz;
						t_.san <- this.flag4;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B_Bullet, t_);
					}

					this.flag2++;

					if (this.flag2 >= 6)
					{
						this.func[0].call(this);
					}
				}
			};
		}
	];
	this.subState = function ()
	{
		this.VX_Brake(1.00000000, -0.50000000 * this.direction);

		if (this.x < ::battle.corner_left + 50 && this.direction == 1.00000000 || this.x > ::battle.corner_right - 50 && this.direction == -1.00000000)
		{
			this.Warp(640 - 590 * this.direction, this.y);
		}
	};
	this.stateLabel = function ()
	{
		if (this.owner.IsAttack() && this.owner.motion != 3011 || this.team.current.IsDamage() || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function SPShot_B_Bullet_Back( t )
{
	this.SetMotion(3019, 6);
	this.sx = this.sy = 0.10000000;
	this.SetParent(t.pare, 0, 0);
	this.DrawActorPriority(200);
	this.func = function ()
	{
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
		this.rz += 3.00000000 * 0.01745329;
		this.sx = this.sy += (1.00000000 - this.sx) * 0.07500000;
	};
}

function SPShot_B_Bullet_Self( t )
{
	this.SetMotion(3019, 7);
	this.SetParent(t.pare, 0, 0);
	this.SetTeamCheck();
	this.stateLabel = function ()
	{
		if (this.hitResult != 0)
		{
			this.SetParent(null, 0, 0);

			if (this.initTable.pare && this.initTable.pare.func[1])
			{
				this.initTable.pare.func[1].call(this.initTable.pare);
			}

			this.stateLabel = null;
			this.ReleaseActor();
		}
	};
}

function SPShot_B_BulletBuff( t )
{
	this.SetMotion(3019, 3);
	this.keyAction = this.ReleaseActor;
}

function SPShot_B_Bullet( t )
{
	this.SetMotion(3019, 0);
	this.rz = t.rot;
	this.SetSpeed_Vec(15.00000000, this.rz, this.direction);
	this.cancelCount = 1;
	this.linkObject = [
		null
	];
	this.atk_id = 2097152;
	this.linkObject = [
		null,
		null
	];
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_NormalFire, t_);
	this.flag1 = null;
	this.flag2 = this.Vector3();
	this.flag2.x = 1.00000000;
	this.flag2.RotateByRadian(t.rot);
	this.func = [
		function ()
		{
			this.func[1] = function ()
			{
			};
			this.func[0] = function ()
			{
			};

			if (this.linkObject[0])
			{
				this.ReleaseActor.call(this.linkObject[0]);
			}

			if (this.linkObject[1])
			{
				this.ReleaseActor.call(this.linkObject[1]);
			}

			this.linkObject = [];
			this.stateLabel = null;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(this.motion, 3);
			this.keyAction = this.ReleaseActor;
		},
		function ()
		{
			if (this.owner.kune)
			{
				this.owner.kune.func[2].call(this.owner.kune, 5.00000000 * this.direction);
				this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_BulletBuff, {});
				this.func[2].call(this);
			}
		},
		function ()
		{
			this.SetMotion(this.motion, 4);
			this.linkObject[1] = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_Bullet_Back, {}, this).weakref();
			this.DrawActorPriority(200);
			this.count = 0;
			this.subState = function ()
			{
				if (this.hitCount >= 1 || this.cancelCount <= 0 || this.grazeCount >= 1 || this.IsScreen(50))
				{
					this.func[0].call(this);
					return;
				}

				this.count++;
				local r_ = 0.17453292 * this.cos(this.count * 0.10471975) * this.direction;
				this.va.RotateByRadian(r_);
				this.rz += r_ * this.direction;
				this.ConvertTotalSpeed();
			};
		}
	];

	if (t.san)
	{
		this.func[2].call(this);
	}
	else
	{
		this.flag1 = null;
		this.linkObject[0] = this.SetShot(this.x, this.y, this.direction, this.SPShot_B_Bullet_Self, {}, this.weakref()).weakref();
		this.subState = function ()
		{
			if (this.hitCount >= 1 || this.cancelCount <= 0 || this.grazeCount >= 1 || this.count >= 40)
			{
				this.func[0].call(this);
				return;
			}
		};
	}

	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP.call(this, this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		this.count++;
		this.subState();
	};
}

function SPShot_C_Bullet( t )
{
	this.SetMotion(3026, 0);
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_NormalFire, t_);
	this.rz = t.rot;
	this.SetSpeed_Vec(100, this.rz, this.direction);
	this.SetTrail(this.motion, 6, 30, 8);

	if (this.owner.box)
	{
		this.flag1 = this.owner.box.weakref();
	}
	else
	{
		this.flag1 = null;
	}

	this.flag2 = this.Vector3();
	this.func = [
		function ()
		{
			this.SetMotion(3026, 3);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = function ()
			{
				this.linkObject[0].anime.radius0 *= 0.50000000;
			};
		}
	];
	this.subState = function ()
	{
		this.TargetHoming(this.target, 0.01745329 * 3.00000000, this.direction);
		this.va.RotateByRadian(this.flag1);
		this.ConvertTotalSpeed();

		if (this.fabs(this.va.y) >= 15.00000000)
		{
			this.SetSpeed_XY(20.00000000 * this.direction, 0.00000000);
			this.flag1 *= -1.00000000;
		}
	};
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP.call(this, this.x, this.y, 4))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.flag1 == null)
		{
			this.func[0].call(this);
		}

		if (this.flag1 && this.flag1 == this.owner.box)
		{
			this.TargetHoming(this.flag1, 3.14159203, this.direction);
			this.rz = this.atan2(this.va.y, this.va.x * this.direction);
			this.flag2.x = this.flag1.x - this.x;
			this.flag2.y = this.flag1.y - this.y;

			if (this.flag2.Length() <= 80)
			{
				this.owner.box.func[1].call(this.owner.box);
				this.func[0].call(this);
				return;
			}
		}
		else
		{
			this.func[0].call(this);
		}
	};
}

function SPShot_C( t )
{
	this.SetMotion(3029, t.type);
	this.cancelCount = 3;
	this.atk_id = 4194304;
	this.flag2 = true;
	this.SetSpeed_XY(t.v.x * this.direction, t.v.y);
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
			this.hitStopTime = 0;

			if (this.owner.box == this)
			{
				this.owner.box = null;
			}

			this.HitReset();
			this.SetTeamShot();
			this.cancelCount = 3;
			this.PlaySE(3849);
			local t_ = {};
			t_.v <- this.Vector3();
			t_.v.x = this.va.x;
			t_.v.y = this.va.y;
			local a_ = this.SetShot(this.x, this.y, this.direction, this.SPShot_C_Splash, t_);
			a_.hitOwner = this;

			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.DrawActorPriority();

			if (this.owner.san_mode)
			{
				this.SetMotion(3027, 7);
				this.count = 0;
				this.stateLabel = function ()
				{
					this.count++;

					if (this.hitResult & 1)
					{
						this.owner.target.DebuffSet_Poison(240);
						this.stateLabel = null;
					}

					if (this.count >= 10 && this.count % 10 == 0)
					{
						this.HitReset();
					}
				};
			}
			else
			{
				this.SetMotion(3027, 0);
				this.stateLabel = function ()
				{
					if (this.hitResult & 1)
					{
						this.owner.target.DebuffSet_Poison(240);
						this.stateLabel = null;
					}
				};
			}

			this.keyAction = this.ReleaseActor;
			this.func[1] = this.func[2] = function ()
			{
			};
		},
		function ()
		{
			if (this.owner.box == this)
			{
				this.owner.box = null;
			}

			this.HitReset();
			this.SetTeamShot();
			this.cancelCount = 3;
			this.PlaySE(3849);

			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.DrawActorPriority();
			this.SetMotion(3027, 0);
			this.stateLabel = function ()
			{
				if (this.hitResult & 1)
				{
					this.owner.target.DebuffSet_Poison(240);
					this.stateLabel = null;
				}
			};
			this.keyAction = this.ReleaseActor;
			this.func[1] = this.func[2] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 50 || this.Damage_ConvertOP.call(this, this.x, this.y, 10))
		{
			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.ReleaseActor();
			return;
		}

		this.rz -= 10.50000000 * 0.01745329;
		this.VX_Brake(0.30000001, 6.00000000 * this.direction);
		this.AddSpeed_XY(0.00000000, 0.64999998);

		if (this.cancelCount <= 0)
		{
			if (this.func[2])
			{
				this.func[2].call(this);
				return;
			}
		}

		if (this.keyTake == 0 || this.keyTake == 2)
		{
			if (this.va.x > 0 && this.x > ::battle.corner_right + 20 || this.va.x < 0 && this.x < ::battle.corner_left - 20)
			{
				this.SetSpeed_XY(-this.va.x * 0.50000000, this.va.y);
				this.count = 0;
				this.stateLabel = function ()
				{
					if (this.y > ::battle.scroll_bottom + 50 || this.Damage_ConvertOP.call(this, this.x, this.y, 10))
					{
						if (this.flag1)
						{
							this.flag1.ReleaseActor();
						}

						this.ReleaseActor();
						return;
					}

					this.count++;

					if (this.count == 15)
					{
						this.callbackGroup = 0;
					}

					this.VX_Brake(0.30000001);
					this.AddSpeed_XY(0.00000000, 0.64999998);
					this.rz -= 10.50000000 * 0.01745329;
				};
			}

			if (this.flag2 && this.hitCount > 0)
			{
				this.flag2 = false;
				this.SetSpeed_XY(this.va.x * 0.50000000, null);
			}

			if (this.va.y > 5.00000000)
			{
				this.SetMotion(this.motion, 1);
				this.stateLabel = function ()
				{
					if (this.y > ::battle.scroll_bottom + 50 || this.Damage_ConvertOP.call(this, this.x, this.y, 10))
					{
						if (this.flag1)
						{
							this.flag1.ReleaseActor();
						}

						this.ReleaseActor();
						return;
					}

					this.VX_Brake(0.30000001, 6.00000000 * this.direction);
					this.AddSpeed_XY(0.00000000, 0.64999998);

					if (this.va.x > 0 && this.x > ::battle.corner_right + 20 || this.va.x < 0 && this.x < ::battle.corner_left - 20)
					{
						this.SetSpeed_XY(-this.va.x * 0.50000000, this.va.y);
						this.count = 0;
						this.callbackGroup = 0;
						this.stateLabel = function ()
						{
							if (this.y > ::battle.scroll_bottom + 50 || this.Damage_ConvertOP.call(this, this.x, this.y, 10))
							{
								if (this.flag1)
								{
									this.flag1.ReleaseActor();
								}

								this.ReleaseActor();
								return;
							}

							this.VX_Brake(0.30000001);
							this.AddSpeed_XY(0.00000000, 0.64999998);
							this.rz -= 10.50000000 * 0.01745329;
						};
					}

					this.rz -= 10.50000000 * 0.01745329;
				};
			}
		}
	};
}

function SPShot_C_Box( t )
{
	this.SetMotion(3028, 0);
	this.SetParent(t.pare, 0, 0);
	this.cancelCount = 1;

	if (this.team == 1)
	{
		this.callbackGroup = 8 | 65536;
	}
	else
	{
		this.callbackGroup = 128 | 131072;
	}

	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0)
		{
			if (this.initTable.pare && this.initTable.pare.func[1])
			{
				this.initTable.pare.func[1].call(this.initTable.pare);
			}

			this.ReleaseActor();
		}
	};
}

function SPShot_C_Poison( t )
{
	this.SetMotion(3027, 5);
	this.keyAction = this.ReleaseActor;
	this.flag1 = true;
	this.stateLabel = function ()
	{
		if (this.flag1 && this.hitResult & 1)
		{
			this.owner.target.DebuffSet_Poison(240);
			this.flag1 = false;
		}
	};
}

function SPShot_C_SplashSelf( t )
{
	this.SetMotion(3027, 4);
	this.SetParent(t.pare, 0, 0);
	this.SetTeamCheck();
	this.stateLabel = function ()
	{
		if (this.hitResult != 0)
		{
			if (this.owner.kune)
			{
				this.owner.kune.func[4].call(this.owner.kune);
			}

			this.ReleaseActor();
		}
	};
}

function SPShot_C_Splash( t )
{
	this.SetMotion(3027, 1);
	this.option = this.SetShot(this.x, this.y, this.direction, this.SPShot_C_SplashSelf, {}, this).weakref();
	this.SetSpeed_XY(t.v.x * 0.25000000, -5.50000000);
	this.rz = -6 * 0.01745329 * this.va.x * this.direction;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.flag1 = true;
	this.stateLabel = function ()
	{
		if (this.y > ::camera.bottom + 50 || this.Damage_ConvertOP.call(this, this.x, this.y, 10))
		{
			if (this.option)
			{
				this.ReleaseActor.call(this.option);
			}

			this.option = null;
			this.ReleaseActor();
			return;
		}

		if (this.flag1 && this.hitResult & 1)
		{
			this.owner.target.DebuffSet_Poison(240);
			this.flag1 = false;
		}

		this.VX_Brake(0.05000000);
		local s_ = (5.00000000 - this.sx) * 0.05000000;

		if (s_ < 0.02500000)
		{
			s_ = 0.02500000;
		}

		this.sx += s_;
		this.sy += 0.30000001;
		this.rz *= 0.85000002;
		this.FitBoxfromSprite();

		if (this.option)
		{
			this.option.sx = this.sx;
			this.option.sy = this.sy;
			this.option.rz = this.rz;
			this.option.FitBoxfromSprite();
		}

		this.AddSpeed_XY(0.00000000, 0.75000000);
	};
}

function SPShot_C2( t )
{
	this.SetMotion(3009, 0);
	this.rz = t.rot;
	this.SetSpeed_Vec(20.00000000, this.rz, this.direction);
	this.cancelCount = 3;

	if (this.team == 1)
	{
		this.callbackMask = 8 | 2 | 131072 | 8192 | 4 | 262144 | 16384;
	}
	else
	{
		this.callbackMask = 128 | 1 | 65536 | 4096 | 4 | 262144 | 16384;
	}

	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount > 0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_D_KuneShadow( t )
{
	if (this.owner.team == 2)
	{
		this.SetMotion(3039, 9);
	}
	else
	{
		this.SetMotion(3039, 7);
	}

	this.SetParent(t.pare, 0, 0);
	this.keyAction = this.ReleaseActor;
	this.func = [
		function ()
		{
			this.SetKeyFrame(1);
		}
	];
}

function SPShot_D_Kune( t )
{
	this.SetMotion(3039, 6);
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
	this.sx = this.sy = 0.50000000;
	this.cancelCount = 3;
	this.atk_id = 8388608;
	this.keyAction = this.ReleaseActor;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount <= 3)
		{
			this.HitCycleUpdate(5);
		}
	};
}

function SPShot_D_Self( t )
{
	this.SetMotion(3039, 3);
	this.SetParent(t.pare, 0, 0);
	this.rz = t.rot;
	this.sx = this.sy = 1.50000000;
	this.FitBoxfromSprite();
	this.keyAction = this.ReleaseActor;
	this.SetTeamCheck();
	this.stateLabel = function ()
	{
		if (this.hitResult != 0)
		{
			this.SetParent(null, 0, 0);

			if (this.owner.kune)
			{
				this.owner.kune.func[3].call(this.owner.kune);
			}

			this.ReleaseActor();
		}
	};
}

function SPShot_D( t )
{
	this.SetMotion(3039, 2);
	this.rz = 45 * 0.01745329;
	this.sx = this.sy = 2.00000000;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.FitBoxfromSprite();
	this.cancelCount = 3;
	this.atk_id = 8388608;
	local t_ = {};
	t_.rot <- this.rz;
	this.option = this.SetShot(this.x, this.y, this.direction, this.SPShot_D_Self, t_, this).weakref();
	this.flag1 = true;
	this.keyAction = this.ReleaseActor;
	this.func = function ()
	{
		if (this.option)
		{
			this.ReleaseActor.call(this.option);
		}

		this.option = null;
		this.SetParent(null, 0, 0);
		this.SetKeyFrame(2);
		this.stateLabel = function ()
		{
			this.sy *= 0.50000000;
		};
	};
	this.stateLabel = function ()
	{
		this.sx += 0.05000000;

		if (this.option)
		{
			this.option.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		}

		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.hitCount <= 3)
		{
			this.HitCycleUpdate(6);
		}

		if (this.flag1 && this.hitResult & 1 && this.owner.san_mode == false)
		{
			this.flag1 = false;
			this.owner.san += 1500;

			if (this.owner.san > 9988)
			{
				this.owner.san = 9988;
			}

			if (this.owner.san_gauge)
			{
				this.owner.san_gauge.func[2].call(this.owner.san_gauge, 1.00000000);
			}
		}

		if (this.cancelCount <= 0 || this.hitCount >= 4 || this.Damage_ConvertOP.call(this, this.x, this.y, 10) || this.owner.motion != 3030)
		{
			this.func();
			return;
		}
	};
}

function SPShot_D_San( t )
{
	this.SetMotion(3039, 8);
	this.rz = 45 * 0.01745329;
	this.sx = this.sy = 2.00000000;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.FitBoxfromSprite();
	this.cancelCount = 3;
	this.atk_id = 8388608;
	this.keyAction = this.ReleaseActor;
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.SetKeyFrame(2);
		this.stateLabel = function ()
		{
			this.sy *= 0.50000000;
		};
	};
	this.stateLabel = function ()
	{
		if (this.hitCount <= 3)
		{
			this.HitCycleUpdate(6);
		}

		this.sx += 0.10000000;
		this.sy += 0.02500000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.cancelCount <= 0 || this.hitCount >= 4 || this.Damage_ConvertOP.call(this, this.x, this.y, 10) || this.owner.motion != 3030)
		{
			this.func();
			return;
		}
	};
}

function SPShot_E_Vision( t )
{
	this.SetMotion(3049, 6);
	this.alpha = 0.00000000;
	this.sx = this.sy = 4.00000000;
	this.SetParent(t.pare, 0, 0);
	this.DrawActorPriority(180);
	this.subState = function ()
	{
		this.alpha += 0.01000000;

		if (this.alpha >= 0.75000000)
		{
			this.alpha = 0.75000000;
			this.subState = function ()
			{
				this.alpha -= 0.02000000;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.sx = this.sy += 0.01000000;
		this.flag1 += (0.02500000 - this.flag1) * 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_E( t )
{
	this.SetMotion(3049, 0);
	this.SetParent(this.owner, this.owner.x - this.x, this.owner.y - this.y);
	this.rz = t.rot;
	this.atk_id = 16777216;
	this.SetSpeed_Vec(30.00000000, this.rz, this.direction);
	this.func = function ( hit_ )
	{
		this.HitTargetReset();

		if (hit_)
		{
			this.SetMotion(3049, 7);
			this.stateLabel = function ()
			{
				this.AddSpeed_Vec(-10.00000000, this.rz, 30.00000000, this.direction);
			};
		}
		else
		{
			this.SetMotion(3049, 2);
			this.SetTeamCheck();
			this.stateLabel = function ()
			{
				this.AddSpeed_Vec(-10.00000000, this.rz, 30.00000000, this.direction);

				if (this.hitResult != 0)
				{
					if (this.owner.kune)
					{
						this.owner.kune.func[6].call(this.owner.kune, this.owner.kune.x > this.owner.x ? -15.00000000 : 15.00000000);
					}

					this.stateLabel = function ()
					{
						this.AddSpeed_Vec(-10.00000000, this.rz, 30.00000000, this.direction);
					};
				}
			};
		}

		this.keyAction = null;
	};
	this.stateLabel = function ()
	{
		local t_ = {};
		t_.rot <- this.rz;
		this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E2, t_);
	};
	this.keyAction = function ()
	{
		this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
		this.stateLabel = function ()
		{
			this.Vec_Brake(1.50000000, 0.50000000);
		};
	};
}

function SPShot_E2( t )
{
	this.SetMotion(3049, 1);
	this.rz = t.rot;
	this.alpha = 0.50000000;
	this.stateLabel = function ()
	{
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_E_Pulse( t )
{
	this.SetParent(this.owner, 0, 0);
	this.SetMotion(3049, 4);
	this.flag1 = false;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0.85000002;
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.keyAction = function ()
	{
		this.sx = this.sy = 1.00000000;
		this.stateLabel = function ()
		{
			this.sx = this.sy += (6.00000000 - this.sx) * 0.33000001;
		};
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.50000000;
	};
}

function SpellShot_A_Fire( t )
{
	this.SetMotion(4009, 3);
	this.atkRate_Pat = t.rate;
	this.rz = t.rot;
	this.cancelCount = 3;
	this.atk_id = 67108864;
	this.keyAction = this.ReleaseActor;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
}

function SpellShot_ASelf( t )
{
	this.SetMotion(4009, 4);
	this.SetParent(t.pare, 0, 0);
	this.SetTeamCheck();
	this.stateLabel = function ()
	{
		if (this.hitResult != 0)
		{
			this.SetParent(null, 0, 0);

			if (this.initTable.pare && this.initTable.pare.func[1])
			{
				this.initTable.pare.func[1].call(this.initTable.pare);
			}

			this.ReleaseActor();
		}
	};
}

function SpellShot_A( t )
{
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
			this.stateLabel = null;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(2009, 3);
			this.keyAction = this.ReleaseActor;

			if (this.linkObject[0])
			{
				this.ReleaseActor.call(this.linkObject[0]);
			}
		},
		function ()
		{
			if (this.owner.kune)
			{
				this.owner.kune.func[2].call(this.owner.kune, 0.00000000);
				this.func[2].call(this);
			}
		},
		function ()
		{
			this.flag1 = 6;
			this.SetMotion(4009, 5);
			this.stateLabel = function ()
			{
				if (this.IsScreen(200))
				{
					this.ReleaseActor();
					return true;
				}

				if (this.flag1 > 0)
				{
					if (this.va.y < 0.00000000 && this.y < -20 || this.va.y > 0 && this.y > 740)
					{
						this.PlaySE(3863);
						this.flag1--;
						this.rz = -this.rz;
						this.SetSpeed_XY(this.va.x, -this.va.y);
						this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);

						if (this.linkObject[0])
						{
							this.linkObject[0].rz = this.rz;
							this.linkObject[0].SetCollisionRotation(0.00000000, 0.00000000, this.rz);
						}
					}

					if (this.va.x > 0.00000000 && this.x > 1300 || this.va.x < 0 && this.x < -20)
					{
						this.PlaySE(3863);
						this.flag1--;
						this.direction = -this.direction;
						this.SetSpeed_XY(-this.va.x, this.va.y);

						if (this.linkObject[0])
						{
							this.linkObject[0].direction = this.direction;
						}
					}
				}

				this.sx += (3.00000000 - this.sx) * 0.15000001;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

				if (this.grazeCount > 0 || this.cancelCount <= 0 || this.hitResult & 31)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	];
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetSpeed_Vec(45.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.atk_id = 67108864;
	this.linkObject = [
		null
	];
	this.atkRate_Pat = t.rate;

	if (this.owner.san_mode)
	{
		this.func[2].call(this);
		this.FitBoxfromSprite();
		local t_ = {};
		t_.rot <- this.rz;
		t_.rate <- this.atkRate_Pat;
		this.SetShot(this.x, this.y, this.direction, this.SpellShot_A_Fire, t_, {});
	}
	else
	{
		this.SetMotion(4009, 0);
		this.FitBoxfromSprite();
		this.flag1 = t.bound;
		local t_ = {};
		t_.rot <- this.rz;
		t_.rate <- this.atkRate_Pat;
		this.SetShot(this.x, this.y, this.direction, this.SpellShot_A_Fire, t_, {});
		this.linkObject.append(this.SetShot(this.x, this.y, this.direction, this.SpellShot_ASelf, {}, this.weakref()).weakref());
		this.stateLabel = function ()
		{
			if (this.IsScreen(200))
			{
				this.ReleaseActor();
				return true;
			}

			if (this.flag1 > 0)
			{
				if (this.va.y < 0.00000000 && this.y < -20 || this.va.y > 0 && this.y > 740)
				{
					this.PlaySE(3863);
					this.flag1--;
					this.rz = -this.rz;
					this.SetSpeed_XY(this.va.x, -this.va.y);
					this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);

					if (this.linkObject[0])
					{
						this.linkObject[0].rz = this.rz;
						this.linkObject[0].SetCollisionRotation(0.00000000, 0.00000000, this.rz);
					}
				}

				if (this.va.x > 0.00000000 && this.x > 1300 || this.va.x < 0 && this.x < -20)
				{
					this.PlaySE(3863);
					this.flag1--;
					this.direction = -this.direction;
					this.SetSpeed_XY(-this.va.x, this.va.y);

					if (this.linkObject[0])
					{
						this.linkObject[0].direction = this.direction;
					}
				}
			}

			this.sx += (3.00000000 - this.sx) * 0.15000001;
			this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

			if (this.grazeCount > 0 || this.cancelCount <= 0 || this.hitResult & 31)
			{
				this.func[0].call(this);
				return;
			}
		};
	}
}

function SpellShot_B( t )
{
	this.SetMotion(4019, 0);
	this.sx = this.sy = 0.25000000;
	this.cancelCount = 3;
	this.atk_id = 67108864;
	this.SetSpeed_XY(10.00000000 * this.direction, 0.00000000);
	this.atkRate_Pat = t.rate;
	this.SetShot(this.x, this.y, this.direction, this.SpellShot_B_Self, {});
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			this.alpha -= 0.25000000;
			this.sx = this.sy += 0.20000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.20000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	};
}

function SpellShot_B_Self( t )
{
	this.SetMotion(4019, 2);
	this.SetTeamCheck();
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.20000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.hitResult != 0)
		{
			if (this.owner.kune)
			{
				this.owner.kune.func[10].call(this.owner.kune);
			}

			this.ReleaseActor();
		}
	};
}

function SpellShot_C( t )
{
	this.SetMotion(4029, 0);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.sy = 0.05000000;
	this.rz = 35 * 0.01745329;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.flag1 = this.SetShot(this.x + (720 - this.y) * this.tan(90 * 0.01745329 - this.rz) * this.direction, ::battle.corner_bottom, this.direction, this.SpellShot_C_Ref, {}).weakref();
	this.func = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sy *= 0.80000001;
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(6);
		this.sy += (1.00000000 - this.sy) * 0.20000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.flag1)
		{
			this.flag1.Warp(this.x + (720 - this.y) * this.tan(90 * 0.01745329 - this.rz) * this.direction, 720);
			this.flag1.rz = -this.rz;
		}
	};
}

function SpellShot_C_Ref( t )
{
	this.SetMotion(4029, 1);
	this.sy = 0.05000000;
	this.rz = -35 * 0.01745329;
	this.FitBoxfromSprite();
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sy *= 0.80000001;
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(6);
		this.sy += (1.00000000 - this.sy) * 0.20000000;
		this.FitBoxfromSprite();
	};
}

function SpellShot_C_SonicCore( t )
{
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.flag1 = this.Vector3();
	this.flag1.x = this.cos(35 * 0.01745329);
	this.flag1.y = this.sin(35 * 0.01745329);
	this.flag2 = ::manbow.Actor2DProcGroup();
	local t_ = {};
	t_.rot <- this.rz;
	this.flag3 = this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_Root, t_, this).weakref();
	this.rz = 35 * 0.01745329;
	this.flag4 = 0;
	this.func = [
		function ()
		{
			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}

			this.flag2.Foreach(function ( a_ = this )
			{
				this.func[2].call(this, a_);
			});
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.flag3)
		{
			this.flag3.rz = this.rz;
		}

		if (this.flag4 < 20 && this.count % 4 == 1)
		{
			this.flag4++;
			local t_ = {};
			t_.rot <- this.rz;
			t_.rate <- this.atkRate_Pat;
			this.flag2.Add(this.SetShot(this.x, this.y, this.direction, this.SpellShot_C_Sonic, t_, this.weakref()));
		}
	};
}

function SpellShot_C_Root( t )
{
	this.SetMotion(4028, 4);
	this.rz = t.rot;
	this.SetParent(t.pare, 0, 0);
	this.keyAction = this.ReleaseActor;
	this.func = [
		function ()
		{
			this.SetKeyFrame(2);
		}
	];
}

function SpellShot_C_Kune( t )
{
	this.SetMotion(4028, 3);
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
	this.cancelCount = 3;
	this.atk_id = 67108864;
	this.keyAction = this.ReleaseActor;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Shot_SpellC_Self( t )
{
	this.SetMotion(4028, 2);
	this.SetParent(t.pare, 0, 0);
	this.SetTeamCheck();
	this.stateLabel = function ()
	{
		if (this.hitResult != 0)
		{
			this.SetParent(null, 0, 0);

			if (this.owner.kune)
			{
				this.owner.kune.func[9].call(this.owner.kune);
			}

			this.ReleaseActor();
		}
	};
}

function SpellShot_C_Sonic( t )
{
	this.SetMotion(4028, 0);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.sx = this.sy = 0.10000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.rz = t.rot;
	this.flag1 = this.Vector3();
	this.flag2 = 0.00000000;
	this.flag3 = this.Vector3();
	this.flag4 = 0.00000000;
	this.flag5 = 0.10000000;
	this.linkObject = [
		this.SetShot(this.x, this.y, this.direction, this.Shot_SpellC_Self, {}, this.weakref()).weakref()
	];
	this.func = [
		function ()
		{
			this.callbackGroup = 0;

			if (this.linkObject[0])
			{
				this.ReleaseActor.call(this.linkObject[0]);
				this.linkObject[0] = null;
			}

			this.stateLabel = function ()
			{
				this.subState();
				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4028, 0);
		},
		function ( a_ )
		{
			this.flag1.x = a_.x;
			this.flag1.y = a_.y;
			this.flag3.x = a_.flag1.x;
			this.flag3.y = a_.flag1.y;
			this.flag4 = a_.rz;
			this.stateLabel = function ()
			{
				this.count += 25.00000000 * 0.01745329;
				this.HitCycleUpdate(-1);
				this.flag5 += 0.15000001;
				this.sx = this.sy = this.flag5 * (1.00000000 + 0.25000000 * this.sin(this.count));

				if (this.flag5 > 1.00000000)
				{
					this.flag5 = 1.00000000;
				}

				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
				this.flag2 += 40.00000000;
				local y_ = this.flag1.y + this.flag3.y * this.flag2;

				if (y_ >= 820)
				{
					if (this.keyTake == 0)
					{
						this.SetMotion(this.motion, 1);
						this.HitTargetReset();
					}

					y_ = -y_ + 820 + 820;
					this.rz = -this.flag4;
				}
				else
				{
					this.rz = this.flag4;
				}

				this.Warp(this.flag1.x + this.flag3.x * this.flag2 * this.owner.direction, y_);

				if (this.y <= -256)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.hitResult & 1 && this.owner.san_mode == false)
		{
			this.owner.san += 300;

			if (this.owner.san > 9988)
			{
				this.owner.san = 9988;
			}

			this.owner.san_gauge && this.owner.san_gauge.func[2].call(this.owner.san_gauge, 1.00000000);
			this.subState = null;
		}
	};
	this.stateLabel = function ()
	{
		if (this.subState)
		{
			this.subState();
		}

		this.count += 25.00000000 * 0.01745329;
		this.HitCycleUpdate(-1);
		this.flag5 += 0.15000001;
		this.sx = this.sy = this.flag5 * (1.00000000 + 0.25000000 * this.sin(this.count));

		if (this.flag5 > 1.00000000)
		{
			this.flag5 = 1.00000000;
		}

		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.linkObject[0])
		{
			this.linkObject[0].SetCollisionScaling(this.sx, this.sy, 1.00000000);
		}

		this.flag2 += 40.00000000;
		local y_ = this.initTable.pare.y + this.initTable.pare.flag1.y * this.flag2;

		if (y_ >= 820)
		{
			if (this.keyTake == 0)
			{
				this.SetMotion(this.motion, 1);
			}

			y_ = -y_ + 820 + 820;
			this.rz = -this.initTable.pare.rz;
		}
		else
		{
			this.rz = this.initTable.pare.rz;
		}

		this.Warp(this.initTable.pare.x + this.initTable.pare.flag1.x * this.flag2 * this.owner.direction, y_);

		if (this.y <= -256)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_Shot( t )
{
	this.DrawActorPriority(210);
	this.SetMotion(4909, 6);
	this.rz = -20 * 0.01745329;
	this.SetSpeed_Vec(60, -110 * 0.01745329, this.direction);
	this.atk_id = 134217728;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.flag1 = 1.00000000;
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.flag1 += 0.00500000;
				this.sx *= this.flag1;
				this.count++;

				if (this.count >= 4)
				{
					this.Vec_Brake(8.00000000, 0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitResult & 1)
		{
		}

		this.count++;

		if (this.count >= 4)
		{
			this.callbackGroup = 0;
			this.Vec_Brake(8.00000000, 0.50000000);
		}

		if (this.count >= 15)
		{
			this.SetMotion(4909, 7);
			this.sx *= 0.89999998;

			if (this.sx <= 0.01000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_ShotB( t )
{
	this.DrawActorPriority(210);
	this.SetMotion(4908, 2);
	this.atk_id = 134217728;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.02500000;
		this.count++;

		if (this.hitResult & 1)
		{
			this.owner.flag1 = true;
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.02500000;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0)
				{
					this.ReleaseActor();
				}
			};
		}
		else
		{
			this.HitCycleUpdate(2);
		}

		if (this.count >= 10)
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.02500000;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Climax_ShotC( t )
{
	this.SetMotion(4908, 0);

	if (this.rand() % 100 <= 50)
	{
		this.DrawActorPriority(110);
	}
	else
	{
		this.DrawActorPriority(210);
	}

	this.rz = t.rot + 90 * 0.01745329;
	this.sx = this.sy = 0.00000000;
	this.flag2 = 0.50000000 + this.rand() % 10 * 0.10000000;
	this.SetSpeed_Vec(1.00000000 * this.flag2, t.rot, this.direction);
	this.flag1 = 0.02500000 + this.rand() % 25 * 0.00100000;
	this.stateLabel = function ()
	{
		this.sx += 0.50000000;
		this.sy += (this.flag2 - this.sy) * 0.25000000;
		this.count++;

		if (this.count == 6)
		{
			this.stateLabel = function ()
			{
				this.sx += 0.00500000;
				this.sy *= 0.99980003;
				this.alpha -= 0.00100000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_Back( t )
{
	this.DrawActorPriority(490);
	this.SetMotion(4909, 1);
	this.alpha = 0.00000000;
	this.rz = (45 - this.rand() % 90) * 0.01745329;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion != 4903)
		{
			this.ReleaseActor();
			return;
		}

		this.rz += 0.50000000 * 0.01745329;
		this.count++;
		this.alpha += 0.02500000;
		this.sx = this.sy += 0.00500000;

		if (this.count == 40)
		{
			this.SetFreeObject(640, 360, this.direction, this.Climax_Back, {});
		}

		if (this.count == 80)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_BackB( t )
{
	this.SetMotion(4909, 5);
	this.flag4 = this.Vector3();
	this.flag4.x = -320;
	this.flag4.RotateByRadian(-30 * 0.01745329);
	this.flag5 = this.Vector3();
	this.flag5.x = 45;
	this.flag5.RotateByRadian(-30 * 0.01745329);
	this.anime.stencil = t.mask;
	this.anime.is_equal = true;
	this.DrawActorPriority(510);
	this.func = [
		function ()
		{
			this.ReleaseActor.call(this.flag3);
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Climax_FaceA( t )
{
	this.SetMotion(4909, 3);
	this.flag1 = -30 * 0.01745329;
	this.anime.is_equal = true;
	this.flag4 = this.Vector3();
	this.flag4.x = -320;
	this.flag4.RotateByRadian(-30 * 0.01745329);
	this.flag5 = this.Vector3();
	this.flag5.x = 45;
	this.flag5.RotateByRadian(-30 * 0.01745329);
	this.flag3 = this.SetFreeObjectStencil(this.x + this.flag4.x * this.direction, this.y + this.flag4.y, this.direction, this.Climax_FaceMaskA, {}).weakref();
	local t_ = {};
	t_.mask <- this.flag3.weakref();
	this.flag2 = this.SetFreeObjectStencil(0, 0, 1.00000000, this.Climax_BackB, t_).weakref();
	this.DrawActorPriority(510);
	this.anime.stencil = this.flag3;
	this.sx = this.sy = 0.80000001;
	this.stateLabel = function ()
	{
		local s_ = (2.50000000 - this.sx) * 0.05000000;

		if (s_ < 0.00500000)
		{
			s_ = 0.00500000;
		}

		this.sx = this.sy += s_;
		this.count++;

		if (this.flag3)
		{
			if (this.count <= 40)
			{
				this.flag3.x += this.flag5.x * this.direction;
				this.flag3.y += this.flag5.y;
			}
		}
	};
	this.func = [
		function ()
		{
			if (this.flag3)
			{
				this.ReleaseActor.call(this.flag3);
			}

			if (this.flag2)
			{
				this.ReleaseActor.call(this.flag2);
			}

			this.ReleaseActor();
		}
	];
}

function Climax_FaceMaskA( t )
{
	this.SetMotion(4909, 4);
	this.rz = -30 * 0.01745329;
	this.DrawActorPriority(510);
	this.anime.is_write = true;
	this.SetParent.call(this.SetFreeObject(this.x, this.y, this.direction, this.Climax_MaskSlash, {}), this, 0, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_MaskSlash( t )
{
	this.SetMotion(4909, 2);
	this.rz = -30 * 0.01745329;
	this.DrawActorPriority(520);
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.99000001;
		this.count++;

		if (this.count >= 15)
		{
			this.alpha = this.blue -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_Slash( t )
{
	this.SetMotion(4909, 9);
	this.rz = 70 * 0.01745329;
	this.sx = 12.00000000;
	this.SetSpeed_Vec(20.00000000, -20 * 0.01745329, this.direction);
	this.DrawActorPriority(520);
	this.stateLabel = function ()
	{
		this.sx *= 0.85000002;
		this.sy += 0.01500000;

		if (this.sx <= 0.01000000)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_LineA( t )
{
	this.SetMotion(4909, 8);
	this.DrawActorPriority(t.priority);
	this.rz = t.rot;
	this.sx = this.sy = t.scale;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4909, 9);
			this.sx = 0.10000000;
			this.stateLabel = function ()
			{
				this.sx += (this.initTable.scale * 0.50000000 - this.sx) * 0.15000001;
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx *= 0.94999999;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.owner.flag1.Add(this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Climax_LineA2, this.initTable));
		}
	];
}

function Climax_LineA2( t )
{
	this.SetMotion(4909, 10);
	this.anime.left = 160;
	this.anime.top = 0;
	this.anime.width = 32;
	this.anime.height = 512;
	this.rz = t.rot;
	this.sx = this.sy = 0.10000000;
	this.sy = t.scale;
	this.DrawActorPriority(t.priority);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.anime.top -= 15.00000000;
		this.sx += (this.initTable.scale * 0.50000000 - this.sx) * 0.15000001;
	};
}

function Climax_LineB( t )
{
	this.SetMotion(4909, 8);
	this.DrawActorPriority(520);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_LineFlash( t )
{
	this.SetMotion(4909, 11);
	this.sx = this.sy = 0.00000000;
	this.DrawActorPriority(499);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 4 == 0)
		{
			this.rz = this.rand() % 360 * 0.01745329;
		}

		this.sx = this.sy += (3.00000000 - this.sx) * 0.10000000;
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_LineSpark( t )
{
	this.SetMotion(4909, 12);
	this.DrawActorPriority(510);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.radius0 = 0;
	this.anime.radius1 = 24;
	this.anime.vertex_alpha1 = 0.00000000;
	this.anime.vertex_green1 = 0.10000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.anime.top += 6.00000000;
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
		this.anime.radius1 += (512 - this.anime.radius1) * 0.05000000;
		this.anime.top -= 25.00000000;
	};
}

