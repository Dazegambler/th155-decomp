function Boss_Shot_T_HeartFall( t )
{
	this.SetMotion(4919, 0);
	this.SetSpeed_XY(4 - this.rand() % 81 * 0,10000000.0, -12,00000000.0 - this.rand() % 5);
	this.rz = this.atan2(this.va.y, this.va.x * this.direction);
	this.cancelCount = 1;
	this.flag1 = 3,00000000.0 + this.rand() % 3;
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.func[0] = function ()
			{
			};
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
	this.subState = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);

		if (this.va.y > 6,50000000.0)
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

		if (this.va.y < 0 && this.y < ::battle.scroll_top - 200)
		{
			this.SetSpeed_XY(this.va.x, 0,00000000.0);
		}

		this.subState();
	};
}

function Boss_Shot_T_HeartFall_B( t )
{
	this.SetMotion(4919, 0);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(10,00000000.0, this.rz, this.direction);
	this.cancelCount = 1;
	this.flag1 = 3,00000000.0 + this.rand() % 3;
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.func[0] = function ()
			{
			};
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
	this.subState = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);

		if (this.va.y > 6,50000000.0)
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(300) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.va.y < 0 && this.y < ::battle.scroll_top - 150)
		{
			this.SetSpeed_XY(this.va.x, 0,00000000.0);
		}

		this.subState();
	};
}

