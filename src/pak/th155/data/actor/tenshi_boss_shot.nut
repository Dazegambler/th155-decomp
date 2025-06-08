function Shot_Dream1_Kaname( t )
{
	this.SetMotion(4969, 1);
	this.owner.boss_shot.Add(this);
	this.rz = -135 * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetSpeed_Vec(4.50000000, this.rz + 1.57079601, this.direction);
	this.alpha = 0.00000000;
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(4969, 0);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0.05000000;

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

		if (this.y < ::battle.scroll_top - 128)
		{
			this.ReleaseActor();
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Shot_Dream1_Kaname_Back( t )
{
	this.SetMotion(4969, 0);
	this.DrawActorPriority(100);
	this.owner.boss_shot.Add(this);
	this.rz = -135 * 0.01745329;
	this.red = this.green = this.blue = 0.50000000;
	this.sx = this.sy = 0.75000000 - this.rand() % 10 * 0.01000000;
	this.SetSpeed_Vec(4.50000000 * this.sx, this.rz + 1.57079601, this.direction);
	this.func = [
		function ()
		{
			this.SetMotion(4969, 0);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y < ::battle.scroll_top - 128)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Dream2_Fire( t )
{
	this.SetMotion(4962, 10);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.02500000;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Dream2( t )
{
	this.SetMotion(4962, 9);
	this.owner.boss_shot.Add(this);
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(1.50000000, this.rz, this.direction);
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Dream2_Fire, {});
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(4962, 10);
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.10000000;
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
		if (this.IsCamera(75))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_Dream2_Kaname( t )
{
	this.SetMotion(4962, 6);
	this.owner.boss_shot.Add(this);
	this.alpha = 0.00000000;
	this.flag1 = 1;
	this.cancelCount = 10;
	this.func = [
		function ()
		{
			this.SetMotion(4962, 8);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.initTable.namazu)
			{
				this.Shot_Dream2_Namazu();
				return;
			}

			::camera.Shake(6.00000000);
			this.SetMotion(4962, 7);
			this.count = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 30)
				{
					this.PlaySE(4225);
					this.SetSpeed_XY(0.00000000, 35.00000000);
				}

				if (this.owner.com_difficulty >= 2)
				{
					if (this.flag1 > 0 && this.count % this.flag1 == 0)
					{
						this.SetShot(this.x - 64 + this.rand() % 128, this.y + this.rand() % 128, this.direction, this.Shot_Dream2, {});
					}
				}

				if (this.y > ::battle.scroll_bottom + 128)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0.05000000;
		this.SetSpeed_XY((this.target.x - this.x) * 0.10000000, 0.00000000);
		this.count++;

		if (this.count >= 90)
		{
			this.func[1].call(this);
			return;
		}
	};
}

function Shot_Dream2_Namazu()
{
	::camera.Shake(6.00000000);
	this.SetMotion(4962, 11);
	this.count = 0;
	this.sx = this.sy = 2.00000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.stateLabel = function ()
	{
		this.rz += 0.05235988;
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
		this.count++;

		if (this.count == 45)
		{
			this.PlaySE(4225);
			this.SetSpeed_XY(0.00000000, 14.50000000);
		}

		if (this.flag1 > 0 && this.count % this.flag1 == 0)
		{
			this.SetShot(this.x - 96 + this.rand() % 192, this.y - 64 + this.rand() % 128, this.direction, this.Shot_Dream2, {});
		}

		if (this.y > ::battle.scroll_bottom + 256)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Dream3_CrainNamazu( t )
{
	this.SetMotion(5001, 2);
	this.cancelCount = 9999;
	this.DrawActorPriority(180);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag5 = 0;
	this.sx = this.sy = 0.50000000;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.sx = this.sy = 0.69999999;
		this.flag5 = 30;
		break;

	case 2:
		this.sx = this.sy = 0.89999998;
		this.flag5 = 20;
		break;

	case 3:
		this.sx = this.sy = 1.00000000;
		this.flag5 = 10;
		break;
	}

	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(5001, 4);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.alpha = this.red = this.green = this.blue -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(5001, 3);
			this.SetSpeed_XY(2.00000000 * this.direction, 12.00000000);
			this.subState[1] = function ()
			{
				this.rz += 0.05235988;
				this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);

				if (this.y > ::battle.scroll_bottom - 64)
				{
					this.PlaySE(4226);
					::camera.Shake(10.00000000);
					this.SetMotion(5001, 4);
					this.SetSpeed_XY(this.va.x * 0.20000000, this.va.y * 0.20000000);
					this.subState[1] = function ()
					{
						this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
						::camera.Shake(2.00000000);
						this.rz += 0.01745329;
						this.count++;

						if (this.flag5 > 0)
						{
							if (this.count % this.flag5 == 1)
							{
								this.SetShot(this.x - 128 + this.rand() % 256, ::battle.scroll_bottom + 96, this.direction, this.Shot_Dream3_KanameB, {});
							}

							if (this.count % (this.flag5 * 3) == 1)
							{
								this.SetShot(this.x - 128 + this.rand() % 256, ::battle.scroll_bottom + 96, this.direction, this.Shot_Dream3_Kaname, {});
							}
						}

						if (this.y > ::battle.scroll_bottom + 256)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(5001, 3);
			this.SetSpeed_XY(3.00000000 * this.direction, -6.00000000);
			this.subState[1] = function ()
			{
				this.rz += 0.05235988;
				this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
				this.AddSpeed_XY(0.00000000, 0.10000000);

				if (this.va.y > 0.00000000 && this.y > ::battle.scroll_bottom - 64)
				{
					this.PlaySE(4226);
					::camera.Shake(10.00000000);
					this.SetMotion(5001, 4);
					this.SetSpeed_XY(this.va.x * 0.20000000, this.va.y * 0.20000000);
					this.subState[1] = function ()
					{
						this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
						::camera.Shake(2.00000000);
						this.rz += 0.01745329;
						this.count++;

						if (this.flag5 > 0)
						{
							if (this.count % this.flag5 == 1)
							{
								this.SetShot(this.x - 128 + this.rand() % 256, ::battle.scroll_bottom + 96, this.direction, this.Shot_Dream3_KanameB, {});
							}

							if (this.count % (this.flag5 * 3) == 1)
							{
								this.SetShot(this.x - 128 + this.rand() % 256, ::battle.scroll_bottom + 96, this.direction, this.Shot_Dream3_Kaname, {});
							}
						}

						if (this.y > ::battle.scroll_bottom + 256)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Shot_Dream3_Kaname( t )
{
	this.SetMotion(4969, 4);
	this.owner.boss_shot.Add(this);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetSpeed_Vec(2.00000000 + this.rand() % 11 * 0.10000000, (-45 - this.rand() % 40) * 0.01745329, this.direction);
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(4969, 5);
			this.stateLabel = function ()
			{
				this.rz -= 0.05235988;
				this.alpha = this.red = this.green = this.blue -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0 || this.y < ::battle.scroll_top - 64)
		{
			this.func[0].call(this);
			return;
		}

		this.rz -= 0.05235988;
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	};
}

function Shot_Dream3_KanameB( t )
{
	this.SetMotion(4969, 6);
	this.owner.boss_shot.Add(this);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetSpeed_Vec(4.00000000 + this.rand() % 21 * 0.10000000, (-45 - this.rand() % 40) * 0.01745329, this.direction);
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(4969, 7);
			this.stateLabel = function ()
			{
				this.rz -= 0.10471975;
				this.alpha = this.red = this.green = this.blue -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0 || this.y < ::battle.scroll_top - 64)
		{
			this.func[0].call(this);
			return;
		}

		this.rz -= 0.10471975;
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	};
}

function Shot_Dream3_RideNamazu( t )
{
	this.SetMotion(5000, 1);
	this.cancelCount = 9999;
	this.DrawActorPriority(180);
	this.sx = this.sy = 0.50000000;
	this.flag1 = 1.50000000;
	this.flag2 = 0;
	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.subState[0] = function ()
	{
		this.sx = this.sy += (this.flag1 - this.sx) * 0.10000000;
		local y_ = (800 - (this.y + 180 * this.sy)) * 0.10000000;
		this.SetSpeed_XY(0.00000000, y_);
	};
	this.func = [
		function ()
		{
			::camera.Shake(30.00000000);
			this.SetMotion(5000, 3);
			this.SetSpeed_XY(-1.50000000 * this.direction, -4.50000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.10000000, null, 3.00000000);
			};
		},
		function ()
		{
		},
		function ( s_ )
		{
			this.SetFreeObject(this.x, ::battle.scroll_bottom, 1.00000000, this.Shot_Dream3_NamazuWave, {});
			this.PlaySE(4253);
			::camera.Shake(20.00000000);
			this.flag1 += s_;
			this.HitReset();
			this.SetMotion(5000, 2);
			this.flag2 = 0;
			this.subState[1] = function ()
			{
				this.flag2++;

				if (this.flag2 >= 10)
				{
					this.SetMotion(5000, 1);
					this.subState[1] = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	};
}

function Shot_Dream3_NamazuWave( t )
{
	this.SetMotion(4964, 9);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.50000000;
		this.alpha -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Dream3_NamazuWaveB, {});
}

function Shot_Dream3_NamazuWaveB( t )
{
	this.SetMotion(4964, 10);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.50000000;
		this.alpha -= 0.02000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

