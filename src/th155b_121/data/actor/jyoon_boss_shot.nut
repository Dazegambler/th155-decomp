function Boss_Shot_MS1( t )
{
	this.flag3 = this.rand() % 4;
	this.SetMotion(4919, 4 + this.flag3);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = t.scale;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.cancelCount = 1;
	this.flag1 = 1,00000000.0;
	this.flag2 = this.Vector3();
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.SetMotion(4919, 4 + this.flag3);
			this.sx = this.sy *= 1,50000000.0;
			this.stateLabel = function ()
			{
				this.C_SetSpeed_XY(this.va, this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4919, this.flag3);
			this.stateLabel = function ()
			{
				this.flag2.x = this.owner.x - this.x;
				this.flag2.y = this.owner.y - this.y;

				if (this.flag2.Length() <= 150)
				{
					this.func[0].call(this);
					return;
				}
				else
				{
					if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
					{
						this.func[0].call(this);
						return;
					}

					this.flag1 += 0,34999999.0;

					if (this.flag1 > 8,00000000.0)
					{
						this.flag1 = 8,00000000.0;
					}

					this.flag2.SetLength(this.flag1);
					this.C_SetSpeed_XY(this.va, this.flag2.x, this.flag2.y);
					this.rz += 0,05235988.0;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.func[1].call(this);
			return;
		}

		this.flag2.x = this.owner.x - this.x;
		this.flag2.y = this.owner.y - this.y;

		if (this.flag2.Length() <= 100)
		{
			this.func[0].call(this);
			return;
		}
		else
		{
			if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
			{
				this.func[0].call(this);
				return;
			}

			this.flag1 += 0,34999999.0;

			if (this.flag1 > 5,00000000.0)
			{
				this.flag1 = 5,00000000.0;
			}

			this.flag2.SetLength(this.flag1);
			this.C_SetSpeed_XY(this.va, this.flag2.x, this.flag2.y);
			this.rz += 0,05235988.0;
		}
	};
}

function Boss_Shot_MS2( t )
{
	this.Boss_Shot_MS2_Common(t);
	this.C_SetSpeed_XY(this.va, 6,00000000.0 - this.rand() % 13, -10,00000000.0 - this.rand() % 6);
}

function Boss_Shot_MS2_High( t )
{
	this.Boss_Shot_MS2_Common(t);
	this.C_SetSpeed_XY(this.va, 6,00000000.0 - this.rand() % 13, -16,00000000.0 - this.rand() % 6);
}

function Boss_Shot_MS2_Common( t )
{
	this.SetMotion(4929, this.rand() % 8);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.cancelCount = 1;
	this.flag1 = 6 + this.rand() % 6;
	this.flag1 *= (1,00000000.0 - this.rand() % 2 * 2) * 0,01745329.0;
	this.flag2 = this.Vector3();
	this.func = [
		function ()
		{
			this.SetMotion(4929, 8);
			this.sx = this.sy = 2,00000000.0;
			this.C_SetSpeed_XY(this.va, 0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.C_SetSpeed_XY(this.va, 0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.flag2.x = this.team.current.point0_x - this.x;
				this.flag2.y = this.team.current.point0_y - this.y;

				if (this.flag2.Length() <= 20)
				{
					this.func[0].call(this);
					return;
				}
				else
				{
					if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
					{
						this.func[0].call(this);
						return;
					}

					this.flag1 += 0,50000000.0;

					if (this.flag1 > 10,00000000.0)
					{
						this.flag1 = 10,00000000.0;
					}

					this.flag2.SetLength(this.flag1);
					this.C_SetSpeed_XY(this.va, this.flag2.x, this.flag2.y);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 64)
		{
			this.ReleaseActor();
		}

		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.rz += this.flag1;
		this.flag1 *= 0,98000002.0;
		this.C_AddSpeed_XY(this.va, 0,00000000.0, 0,12500000.0, this.va.x, 5,00000000.0);
	};
}

function Boss_Shot_MS3( t )
{
	this.SetMotion(4939, 0);
	this.DrawActorPriority(180);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.stateLabel = function ()
	{
	};
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			if (this.flag2)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.PlaySE(4676);
			::camera.Shake(6,00000000.0);
			this.flag1 = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Boss_Shot_MS3_Aura, {}, this.weakref()).weakref();
			this.flag2 = this.SetShotDynamic(this.x, this.y, this.direction, this.Boss_Shot_MS3_Shot, {}, this.weakref()).weakref();
			this.stateLabel = function ()
			{
				::camera.Shake(1,00000000.0);
			};
		}
	];
}

function Boss_Shot_MS3_Aura( t )
{
	this.SetMotion(4939, 1);
	this.DrawActorPriority(179);
	this.SetParent(t.pare, 0, 0);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.center_x = 0;
	this.anime.center_y = 0;
	this.anime.radius0 = 0;
	this.anime.radius1 = 0;
	this.anime.length = 0;
	this.anime.vertex_alpha1 = 0,00000000.0;
	this.anime.vertex_blue1 = 1,00000000.0;
	this.anime.vertex_red1 = 1,00000000.0;
	this.anime.vertex_green1 = 1,00000000.0;
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.anime.radius1 += (600 - this.anime.radius1) * 0,10000000.0;
				this.anime.top -= 12,00000000.0;
				this.count++;
				this.anime.radius0 = this.anime.radius1 += 0,50000000.0;
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
		this.anime.radius1 += (600 - this.anime.radius1) * 0,10000000.0;
		this.anime.top -= 3,00000000.0;
		this.count++;
		this.alpha += 0,02500000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}
	};
}

function Boss_Shot_MS3_Shot( t )
{
	this.SetMotion(4939, 2);
	this.SetParent(t.pare, 0, 0);
	this.flag1 = false;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 512;
	this.anime.center_x = 0;
	this.anime.center_y = 0;
	this.anime.radius0 = 0;
	this.anime.radius1 = 0;
	this.anime.length = 0;
	this.anime.vertex_alpha1 = 1,00000000.0;
	this.anime.vertex_blue1 = 1,00000000.0;
	this.anime.vertex_red1 = 1,00000000.0;
	this.anime.vertex_green1 = 1,00000000.0;
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitResult & 13)
		{
			if (this.flag1 == false)
			{
				this.flag1 = true;
				this.owner.hitResult = 1;
			}
		}

		this.anime.radius1 += (1600 - this.anime.radius1) * 0,01500000.0;
		this.anime.radius0 += (this.anime.radius1 - this.anime.radius0) * 0,10000000.0;
		this.anime.top -= 12;
		this.SetCollisionScaling(this.anime.radius1 / 100,00000000.0, this.anime.radius1 / 100,00000000.0, 1,00000000.0);
		this.count++;
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}
	};
}

