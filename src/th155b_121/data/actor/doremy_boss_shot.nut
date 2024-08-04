function Boss_Shot_MS1( t )
{
	this.SetMotion(4918, 1);
	this.DrawActorPriority(181);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,75000000.0;
	this.red = this.green = this.blue = 0,75000000.0;
	this.cancelCount = 3;
	this.SetSpeed_Vec(6,00000000.0, t.rot, this.direction);
	this.AddSpeed_XY(0,00000000.0, -6,00000000.0);
	this.subState = function ()
	{
		this.vy += 0,50000000.0;
		this.count++;

		if (this.count >= 24)
		{
			this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_MS1_B, {}, this.weakref());
			this.ReleaseActor();
			return;
		}
	};
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 2);
			this.flag1 = 2,00000000.0 + this.rand() % 10 * 0,10000000.0;
			this.flag2 = 0,10471975.0 + this.rand() % 12 * 0,01745329.0;
			this.func[0] = function ()
			{
			};
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
		},
		function ()
		{
			this.func[0].call(this);
		},
		function ()
		{
			this.func[0].call(this);
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.rz += 0,06981317.0;
		this.subState();
	};
}

function Boss_Shot_MS1_B( t )
{
	this.SetMotion(4918, 0);
	this.owner.shot_actor.Add(this);
	this.rz = t.pare.rz + 3,14159203.0;
	this.sx = this.sy = t.pare.sx;
	this.cancelCount = 1;
	this.SetSpeed_XY(-t.pare.va.x, -(t.pare.va.y - 6,00000000.0) - 6,00000000.0);
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.flag2 = t.pare.initTable.scale;
	this.subState = function ()
	{
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.C_AddFreeSpeed_XY(this.va, 0,00000000.0, 0,50000000.0);
		this.count++;

		if (this.count >= 24)
		{
			this.va.y -= 6,00000000.0;
			this.va.RotateByDegree(15 - this.rand() % 31);
			this.C_AddFreeSpeed_XY(this.va, 0,00000000.0, -6,00000000.0);
			this.count = 0;
		}
	};
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 2);
			this.flag1 = 2,00000000.0 + this.rand() % 10 * 0,10000000.0;
			this.flag2 = 0,10471975.0 + this.rand() % 12 * 0,01745329.0;
			this.func[0] = function ()
			{
			};
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
		},
		function ()
		{
			this.SetMotion(this.motion, 1);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,20000000.0);
				this.count++;

				if (this.count == 45)
				{
					this.stateLabel = function ()
					{
						this.rz += this.va.y * 0,20000000.0 * 0,01745329.0;
						this.C_AddSpeed_XY(this.va, 0,00000000.0, -0,25000000.0, null, -20,00000000.0);

						if (this.y < ::battle.scroll_top - 100)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			if (this.keyTake == 1)
			{
				this.func[0].call(this);
				return;
			}

			this.SetMotion(this.motion, 0);
			this.count = 0;
			this.flag1 = (4,00000000.0 + this.rand() % 21 * 0,10000000.0) * 0,01745329.0;

			if (this.rand() % 100 <= 49)
			{
				this.flag1 *= -1,00000000.0;
			}

			this.SetSpeed_XY(2,00000000.0 - this.rand() % 5, -10,00000000.0 - this.rand() % 9);
			this.stateLabel = function ()
			{
				if (this.y > ::battle.scroll_bottom + 200 || this.y < ::battle.scroll_top - 200)
				{
					this.ReleaseActor();
					return;
				}

				if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
				{
					this.func[0].call(this);
					return;
				}

				this.sx = this.sy += (this.flag2 + 1,00000000.0 - this.sx) * 0,01000000.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
				this.rz += this.flag1;
				this.flag1 *= 0,98500001.0;
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += (this.flag2 - this.sx) * 0,00600000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.rz += 0,06981317.0;
		this.subState();
	};
}

function Boss_Shot_MS1_Hole( t )
{
	this.SetMotion(4919, 1);
	this.owner.shot_actor.Add(this);
	this.DrawActorPriority(9);
	this.anime.is_write = true;
	this.anime.stencil = this.owner.back_park;
	this.SetParent(this.owner, 0, 0);
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
	this.flag5.shotScale <- 1,00000000.0;
	this.flag5.shotCycle <- 10;
	this.flag5.shotWay <- 1;
	this.flag5.shotAddWay <- 0;
	this.sx = this.sy = 0,10000000.0;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
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
		function ()
		{
			this.SetParent(null, 0, 0);
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
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
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
		if (this.count == 30)
		{
			this.subState = function ()
			{
				if (this.owner.motion != 4920)
				{
					this.subState = function ()
					{
					};
					return;
				}

				if (this.count % 20 == 1)
				{
					this.PlaySE(4026);
				}

				if (this.count % this.flag5.shotCycle == 1)
				{
					this.flag5.shotPos.x = 1,00000000.0;
					this.flag5.shotPos.y = 0,00000000.0;
					this.flag5.shotPos.RotateByRadian(this.flag5.shotRot);

					for( local i = 0; i < this.flag5.shotWay; i++ )
					{
						local t_ = {};
						t_.rot <- this.flag5.shotRot + 3,14159203.0;
						t_.scale <- this.flag5.shotScale;
						this.SetShotStencil(this.x + this.flag5.shotPos.x * 100 * this.sx, this.y + this.flag5.shotPos.y * 100 * this.sy, 1,00000000.0, this.Boss_Shot_MS1, t_, this.weakref());
						this.flag5.shotRot += this.flag5.shotAddWay;
						this.flag5.shotPos.RotateByRadian(this.flag5.shotAddWay);
					}

					this.flag5.shotRot += (10 + this.rand() % 3) * 0,01745329.0;
				}
			};
		}
	};

	switch(this.owner.com_difficulty)
	{
	case 4:
		this.flag5.shotScale = 3,50000000.0;
		this.flag5.shotCycle = 8;
		this.flag5.shotWay = 4;
		this.flag5.shotAddWay = 1,57079601.0;
		break;

	case 3:
		this.flag5.shotScale = 2,50000000.0;
		this.flag5.shotCycle = 8;
		this.flag5.shotWay = 4;
		this.flag5.shotAddWay = 1,57079601.0;
		break;

	case 2:
		this.flag5.shotScale = 2,00000000.0;
		this.flag5.shotCycle = 8;
		this.flag5.shotWay = 3;
		this.flag5.shotAddWay = 2,09439468.0;
		break;

	case 1:
		this.flag5.shotScale = 1,75000000.0;
		this.flag5.shotCycle = 8;
		this.flag5.shotWay = 2;
		this.flag5.shotAddWay = 3,14159203.0;
		break;

	default:
		this.flag5.shotScale = 1,50000000.0;
		this.flag5.shotCycle = 8;
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

function Boss_Shot_MS1_Core( t )
{
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];

	switch(this.owner.com_difficulty)
	{
	case 3:
	case 4:
		this.flag1 = 6;
		break;

	case 2:
		this.flag1 = 4;
		break;

	case 1:
		this.flag1 = 2;
		break;

	default:
		break;
	}

	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 15 == 1)
		{
			if (this.flag1 > 0)
			{
				this.flag2++;
				this.flag1--;
				this.SetLightShot(this.x + 125 * this.flag2, ::battle.scroll_top - 200, this.direction, this.Boss_Shot_MS1_Fall, {});
				this.SetLightShot(this.x - 125 * this.flag2, ::battle.scroll_top - 200, this.direction, this.Boss_Shot_MS1_Fall, {});
			}
			else
			{
				this.ReleaseActor();
			}
		}
	};
}

function Boss_Shot_MS1_Fall( t )
{
	this.SetMotion(4918, 5);
	this.DrawActorPriority(180);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_XY(1,50000000.0 - this.rand() % 31 * 0,10000000.0, 0,00000000.0);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 200)
		{
			this.ReleaseActor();
			return;
		}

		this.C_AddSpeed_XY(this.va, 0,00000000.0, 0,15000001.0, 0,00000000.0, 10,00000000.0);
	};
}

function Boss_Shot_DS1( t )
{
	this.SetMotion(4918, 6);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.cancelCount = 1;
	this.SetSpeed_Vec(6,00000000.0, t.rot, this.direction);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 2);
			this.flag1 = 2,00000000.0 + this.rand() % 10 * 0,10000000.0;
			this.flag2 = 0,10471975.0 + this.rand() % 12 * 0,01745329.0;
			this.func[0] = function ()
			{
			};
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.rz += 0,06981317.0;
	};
}

function Boss_Shot_DS1_Big( t )
{
	this.SetMotion(4918, 7);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.cancelCount = 3;
	this.SetSpeed_Vec(4,00000000.0, t.rot, this.direction);
	this.AddSpeed_XY(0,00000000.0, -7,50000000.0);

	switch(this.owner.com_difficulty)
	{
	case 3:
	case 4:
		this.flag1 = 0,15000001.0;
		this.flag2 = 15;
		break;

	case 2:
		this.flag1 = 0,10000000.0;
		this.flag2 = 10;
		break;

	case 1:
		this.flag1 = 0,05000000.0;
		this.flag2 = 5;
		break;

	default:
		this.flag1 = 0;
		this.flag2 = 0;
		break;
	}

	this.hitResult = 128;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.sx = this.sy = 4,00000000.0;
			this.SetMotion(this.motion, 2);
			this.flag1 = 2,00000000.0 + this.rand() % 10 * 0,10000000.0;
			this.flag2 = 0,10471975.0 + this.rand() % 12 * 0,01745329.0;
			this.func[0] = function ()
			{
			};
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= this.flag2))
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(5);
		this.vy += 0,50000000.0;

		if (this.count % 30 == 29)
		{
			this.sx = this.sy += this.flag1;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			this.vy -= 15,00000000.0;
		}

		this.count++;
		this.rz += 0,06981317.0;
	};
}

