function Boss_Tutorial_Info_A( t )
{
	this.SetMotion(4000, 0);
	this.DrawScreenActorPriority(1000);
	this.alpha = 0.00000000;
	this.stateLabel = function ()
	{
		this.alpha += 0.02500000;

		if (this.alpha >= 1.00000000)
		{
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 20)
				{
					this.stateLabel = function ()
					{
						this.alpha -= 0.02500000;

						if (this.alpha <= 0.00000000)
						{
							this.Release();
						}
					};
				}
			};
		}
	};
}

function Boss_Shot_Tutorial( t )
{
	this.SetMotion(4919, 0);
	this.SetSpeed_Vec(10.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.05235988);
	this.subState = function ()
	{
		if (this.Vec_Brake(0.25000000, 2.00000000))
		{
			this.subState = function ()
			{
				this.count++;

				if (this.count >= 20)
				{
					this.subState = function ()
					{
						if (this.AddSpeed_Vec(0.20000000, null, 15.00000000, this.direction))
						{
							this.subState = function ()
							{
							};
						}
					};
				}
			};
		}
	};
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.05000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_T_StarFall( t )
{
	this.SetMotion(4919, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 0.80000001 + this.rand() % 4 * 0.10000000;
	this.SetSpeed_XY(4 - this.rand() % 81 * 0.10000000, -15.00000000);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.flag1 = 3.00000000 + this.rand() % 3;
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.10471975);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.05000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.20000000);

		if (this.va.y > 6.50000000)
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.y >= ::battle.scroll_bottom || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.va.y < 0 && this.y < ::battle.scroll_top - 100)
		{
			this.Warp(this.x + this.initTable.v * this.direction, this.y);
			this.SetSpeed_XY(2.00000000 * this.direction, 0.00000000);
		}

		this.subState();
	};
}

function Boss_Shot_T_StarFall( t )
{
	this.SetMotion(4919, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_XY(t.vx, t.vy);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.10471975);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.05000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y >= ::battle.scroll_bottom || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0.00000000, 0.10000000);
	};
}

