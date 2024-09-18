function Boss_Shot_MS1( t )
{
	this.SetMotion(4919, 0);
	this.owner.shot_actor.Add(this);
	this.rz = (45 - this.rand() % 90) * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.cancelCount = 1;
	this.SetSpeed_Vec(12.50000000, this.rz, this.direction);
	this.Warp(this.x + this.va.x * 8, this.y + this.va.y * 8);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 2);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(this.va.x * 0.80000001, this.va.y * 0.80000001);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
			this.func[1] = function ()
			{
			};
		},
		function ()
		{
			this.SetMotion(4919, 3);
			this.stateLabel = function ()
			{
				if (this.IsScreen(200))
				{
					this.ReleaseActor();
					return;
				}

				this.sx = this.sy *= 1.02499998;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
				this.SetSpeed_XY(this.va.x * 1.04999995, this.va.y * 1.04999995);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.Vec_Brake(0.25000000, 5.00000000))
		{
			this.stateLabel = function ()
			{
				if (this.IsScreen(200))
				{
					this.ReleaseActor();
					return;
				}

				if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	};
}

function Boss_Shot_SL1( t )
{
	this.SetMotion(4929, 0);
	this.owner.shot_actor.Add(this);
	this.Warp(this.direction == 1.00000000 ? ::camera.camera2d.left : ::camera.camera2d.right, this.y);
	this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
	this.cancelCount = 1;
	this.SetSpeed_Vec(6.00000000, this.rz, this.direction);
	this.flag1 = 45;
	this.flag2 = 1.02499998;
	this.sx = this.sy = 0.50000000;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag1 = 45;
		this.flag2 = 1.02999997;
		this.sx = this.sy = 0.69999999;
		break;

	case 2:
		this.flag1 = 30;
		this.flag2 = 1.03750002;
		this.sx = this.sy = 0.89999998;
		break;

	case 3:
		this.flag1 = 20;
		this.flag2 = 1.04499996;
		this.sx = this.sy = 1.00000000;
		break;

	case 4:
		this.flag1 = 15;
		this.flag2 = 1.04999995;
		this.sx = this.sy = 1.00000000;
		break;
	}

	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(this.va.x * 0.80000001, this.va.y * 0.80000001);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.PlaySE(1481);
			this.SetMotion(this.motion, 1);
			this.SetSpeed_Vec(6.00000000, this.rz, this.direction);
			::camera.Shake(10.00000000);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.60000002);
			};
			this.keyAction = function ()
			{
				this.func[0].call(this);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 20)
		{
			this.PlaySE(1480);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100))
				{
					this.func[1].call(this);
					return;
				}

				this.va.Mul(this.flag2);
				this.ConvertTotalSpeed();
			};
		}
	};
}

function Boss_Shot_SL1B( t )
{
	this.SetMotion(4929, 0);
	this.owner.shot_actor.Add(this);
	this.Warp(this.direction == 1.00000000 ? ::camera.camera2d.left : ::camera.camera2d.right, this.y);
	this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
	this.cancelCount = 1;
	this.SetSpeed_Vec(3.00000000, this.rz, this.direction);
	this.flag1 = 45;
	this.flag2 = 1.02499998;
	this.sx = this.sy = 0.50000000;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag1 = 45;
		this.flag2 = 1.02999997;
		this.sx = this.sy = 0.69999999;
		break;

	case 2:
		this.flag1 = 30;
		this.flag2 = 1.03750002;
		this.sx = this.sy = 0.89999998;
		break;

	case 3:
	case 4:
		this.flag1 = 15;
		this.flag2 = 1.04499996;
		this.sx = this.sy = 1.00000000;
		break;
	}

	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(this.va.x * 0.80000001, this.va.y * 0.80000001);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.PlaySE(1481);
			this.SetMotion(this.motion, 1);
			this.SetSpeed_Vec(6.00000000, this.rz, this.direction);
			::camera.Shake(10.00000000);

			if (this.owner.com_difficulty == 4)
			{
				for( local i = -3; i <= 3; i++ )
				{
					local t_ = {};
					t_.rot <- this.rz + 3.14159203 + 0.52359873 * i;
					this.team.master.SetShot(this.point0_x, this.point0_y, this.direction, this.team.master.Boss_Shot_M1_OD, t_);
				}
			}

			this.stateLabel = function ()
			{
				this.Vec_Brake(0.60000002);
			};
			this.keyAction = function ()
			{
				this.func[0].call(this);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= this.flag1)
		{
			this.PlaySE(1480);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100))
				{
					this.func[1].call(this);
					return;
				}

				this.va.Mul(this.flag2);
				this.ConvertTotalSpeed();
			};
		}
	};
}

function Boss_Shot_SL2_Pre( t )
{
	this.SetMotion(4929, 4);
	this.alpha = 0.00000000;
	this.func = [
		function ()
		{
			this.alpha = 1.00000000;
			this.stateLabel = function ()
			{
				this.sx += 0.10000000;
				this.sy += 0.10000000;
				this.alpha -= 0.07500000;

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
		this.sx += 0.05000000;
		this.sy += 0.00500000;
	};
}

function Boss_Shot_SL2( t )
{
	this.SetMotion(4929, 3);
	this.owner.shot_actor.Add(this);
	this.flag1 = 90;
	this.flag2 = 1.02499998;
	this.flag3 = null;

	if (this.direction == 1.00000000)
	{
		this.Warp(::battle.scroll_left, this.owner.target.y);
		this.flag3 = this.SetShot(::battle.scroll_right, this.y, -1.00000000, this.Boss_Shot_SL2, {}).weakref();
	}

	this.flag4 = this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_SL2_Pre, {}).weakref();
	this.cancelCount = 1;
	this.sx = this.sy = 0.50000000;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag1 = 60;
		this.flag2 = 1.02999997;
		break;

	case 2:
		this.flag1 = 45;
		this.flag2 = 1.03750002;
		break;

	case 3:
		this.flag1 = 30;
		this.flag2 = 1.05499995;
		break;

	case 4:
		this.flag1 = 20;
		this.flag2 = 1.07500005;
		break;
	}

	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);

			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.stateLabel = function ()
			{
				this.SetSpeed_XY(this.va.x * 0.80000001, this.va.y * 0.80000001);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.PlaySE(1481);
			this.SetMotion(this.motion, 1);
			this.SetSpeed_Vec(1.20000005, this.rz, this.direction);
			::camera.Shake(10.00000000);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.60000002);
			};
			this.keyAction = function ()
			{
				this.func[0].call(this);
			};

			if (this.flag3)
			{
				this.flag3.func[1].call(this.flag3);
			}
		},
		function ()
		{
			this.SetMotion(4929, 0);
			this.count = 0;

			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.flag4 = null;
			this.SetSpeed_Vec(3.00000000, this.rz, this.direction);

			if (this.flag3)
			{
				this.flag3.func[2].call(this.flag3);
				this.stateLabel = function ()
				{
					this.count++;

					if (this.count >= 20)
					{
						this.PlaySE(1480);
						this.stateLabel = function ()
						{
							if (this.x > this.flag3.x)
							{
								this.PlaySE(1481);
								::camera.Shake(10.00000000);
								this.func[1].call(this);
								return;
							}

							this.va.Mul(this.flag2);
							this.ConvertTotalSpeed();
						};
					}
				};
			}
			else
			{
				this.stateLabel = function ()
				{
					this.count++;

					if (this.count >= 20)
					{
						this.stateLabel = function ()
						{
							this.va.Mul(this.flag2);
							this.ConvertTotalSpeed();
						};
					}
				};
			}
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= this.flag1)
		{
			this.func[2].call(this);
		}
	};
}

