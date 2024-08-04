function Boss_Shot_MS1_Core( t )
{
	this.SetMotion(4929, 6);
	this.SetParent(this.owner, 0, 0);
	this.owner.shot_actor.Add(this);
	this.flag5 = [];
	this.flag4 = this.Vector3();
	this.flag4.x = 1,00000000.0;
	this.flag4.RotateByRadian(t.rot);
	this.flag3 = 0;
	this.flag2 = 0;
	this.flag1 = 0,01745329.0;

	if (this.owner.com_difficulty == 4)
	{
		this.flag1 = 0,10471975.0;
	}

	for( local i = 0; i < t.range; i++ )
	{
		local t_ = {};
		t_.type <- t.type;
		this.flag5.append(this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_MS1, t_, this.weakref()).weakref());
	}

	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.flag2 += 0,00500000.0 * 0,01745329.0;

				if (this.flag2 > this.flag1)
				{
					this.flag2 = this.flag1;
				}

				this.flag4.RotateByRadian(this.flag2);
				this.HitCycleUpdate(60);
				this.cancelCount = 99;

				foreach( val, a in this.flag5 )
				{
					if (a)
					{
						a.Warp(this.x + this.flag4.x * this.flag3 * (val + 1), this.y + this.flag4.y * this.flag3 * (val + 1));
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(60);
		this.cancelCount = 99;
		this.flag3 += (100 - this.flag3) * 0,07500000.0;

		foreach( val, a in this.flag5 )
		{
			if (a)
			{
				a.Warp(this.x + this.flag4.x * this.flag3 * (val + 1), this.y + this.flag4.y * this.flag3 * (val + 1));
			}
		}
	};
}

function Boss_Shot_MS1( t )
{
	this.SetMotion(4929, t.type);
	this.owner.shot_actor.Add(this);
	this.hitOwner = t.pare.weakref();
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
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
}

function Boss_Shot_DS1_Core( t )
{
	this.SetMotion(4929, 6);
	this.SetParent(this.owner, 0, 0);
	this.owner.shot_actor.Add(this);
	this.hitResult = 128;
	this.flag5 = [];
	this.flag4 = this.Vector3();
	this.flag4.x = 1,00000000.0;
	this.flag4.RotateByRadian(t.rot);
	this.flag3 = 0;
	this.flag2 = this.Vector3();
	this.flag1 = 0;

	for( local i = 0; i < t.range; i++ )
	{
		local t_ = {};
		t_.type <- t.type;

		if (i <= 1)
		{
			this.flag5.append(this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_DS1_Dummy, t_, this.weakref()).weakref());
		}
		else
		{
			this.flag5.append(this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_DS1, t_, this.weakref()).weakref());
		}
	}

	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.flag2.x = this.flag5[0].x - this.x;
			this.flag2.y = this.flag5[0].y - this.y;
			local root_ = this;

			foreach( a in this.flag5 )
			{
				if (a)
				{
					a.flag2.x = a.x - root_.x;
					a.flag2.y = a.y - root_.y;
					root_ = a;
				}
			}

			this.stateLabel = function ()
			{
				local root_ = this;

				foreach( val, a in this.flag5 )
				{
					a.SetSpeed_XY(root_.x + root_.flag2.x - a.x, root_.y + root_.flag2.y - a.y);
					root_ = a;
				}

				for( local i = this.flag5.len() - 1; i >= 0; i-- )
				{
					if (i == 0)
					{
						this.flag5[i].flag2.x = this.flag2.x;
						this.flag5[i].flag2.y = this.flag2.y;
					}
					else
					{
						this.flag5[i].flag2.x = this.flag5[i - 1].flag2.x;
						this.flag5[i].flag2.y = this.flag5[i - 1].flag2.y;
					}
				}

				this.flag1 += 0,02500000.0 * 0,01745329.0;

				if (this.flag1 > 0,03490658.0)
				{
					this.flag1 = 0,03490658.0;
				}

				this.flag2.RotateByRadian(this.flag1);
				this.HitCycleUpdate(60);
				this.cancelCount = 99;
			};
		},
		function ()
		{
			::camera.Shake(10,00000000.0);
			this.PlaySE(2987);

			foreach( a in this.flag5 )
			{
				a.func[1].call(a);
			}

			this.func[0].call(this);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				local root_ = this;

				foreach( val, a in this.flag5 )
				{
					a.SetSpeed_XY(root_.x + root_.flag2.x - a.x, root_.y + root_.flag2.y - a.y);
					root_ = a;
				}

				for( local i = this.flag5.len() - 1; i >= 0; i-- )
				{
					if (i == 0)
					{
						this.flag5[i].flag2.x = this.flag2.x;
						this.flag5[i].flag2.y = this.flag2.y;
					}
					else
					{
						this.flag5[i].flag2.x = this.flag5[i - 1].flag2.x;
						this.flag5[i].flag2.y = this.flag5[i - 1].flag2.y;
					}
				}

				this.flag1 += 0,05000000.0 * 0,01745329.0;

				if (this.flag1 > 0,08726646.0)
				{
					this.flag1 = 0,08726646.0;
				}

				this.flag2.RotateByRadian(this.flag1);
				this.HitCycleUpdate(60);
				this.cancelCount = 99;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(60);
		this.cancelCount = 99;
		this.flag3 += (66 - this.flag3) * 0,07500000.0;

		foreach( val, a in this.flag5 )
		{
			if (a)
			{
				a.Warp(this.x + this.flag4.x * this.flag3 * (val + 1), this.y + this.flag4.y * this.flag3 * (val + 1));
			}
		}
	};
}

function Boss_Shot_DS1( t )
{
	this.SetMotion(4929, t.type);
	this.owner.shot_actor.Add(this);
	this.flag1 = 0;
	this.flag2 = this.Vector3();
	this.hitOwner = t.pare.weakref();
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.hitOwner = this.weakref();
			this.cancelCount = 3;
			this.hitResult = 128;
			this.SetSpeed_XY(this.va.x * 0,66000003.0, this.va.y * 0,33000001.0);
			this.flag1 = (1 + this.rand() % 3) * 0,01745329.0;

			if (this.rand() % 100 <= 49)
			{
				this.flag1 *= -1;
			}

			this.stateLabel = function ()
			{
				if (this.IsScreen(400))
				{
					this.ReleaseActor();
					return;
				}

				this.rz += this.flag1;
				this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
				this.HitCycleUpdate(2);

				if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 5)
				{
					this.func[0].call(this);
				}
			};
		}
	];
}

function Boss_Shot_DS1_Dummy( t )
{
	this.SetMotion(4929, 6);
	this.owner.shot_actor.Add(this);
	this.flag1 = 0;
	this.flag2 = this.Vector3();
	this.hitOwner = t.pare.weakref();
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Boss_Shot_SL1( t )
{
	this.SetMotion(4919, this.rand() % 3);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.flag1 = 0,00000000.0;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.flag2 = (6 - this.rand() % 13) * 0,01745329.0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.rz += this.flag2;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		},
		function ()
		{
			this.subState = function ()
			{
				this.flag1 += 0,75000000.0;
				this.va.x = (this.owner.flag5.pos.x - this.x) * 0,20000000.0;
				this.va.y = (this.owner.flag5.pos.y - this.y) * 0,20000000.0;
				local r_ = this.va.Length();

				if (r_ > this.flag1)
				{
					this.va.SetLength(this.flag1);
				}

				this.ConvertTotalSpeed();
			};
		},
		function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_Vec(10,00000000.0 + this.rand() % 8, this.rand() % 360 * 0,01745329.0, this.direction);
			this.flag2 = (6 - this.rand() % 13) * 0,01745329.0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.rz += this.flag2;
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
		this.SetSpeed_XY(this.va.x * 0,92000002.0, this.va.y * 0,92000002.0);
	};
	this.stateLabel = function ()
	{
		this.subState();
	};
}

