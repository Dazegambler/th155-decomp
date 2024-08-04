function Binbou_Shot_Core( t )
{
	this.SetMotion(3919, 8);
	this.flag1 = [];

	for( local i = 0; i < 15; i++ )
	{
		local t_ = {};
		t_.rot <- i * 24 * 0,01745329.0;
		this.flag1.append(this.SetShot(this.x, this.y, 1,00000000.0, this.Binbou_Shot, t_, this.weakref()).weakref());
	}

	this.cancelCount = 99;
	this.func = [
		function ()
		{
			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 90)
		{
			this.func[0].call(this);
		}
	};
}

function Binbou_Shot( t )
{
	this.SetMotion(3919, this.rand() % 4);
	this.atkRate_Pat = 4,00000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(8 + this.rand() % 3, t.rot, 1,00000000.0);
	this.cancelCount = 1;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.hitOwner = t.pare;
	this.func = [
		function ()
		{
			this.hitOwner = this.weakref();
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		this.atkRate_Pat -= 0,10000000.0;

		if (this.atkRate_Pat < 1,00000000.0)
		{
			this.atkRate_Pat = 1,00000000.0;
		}

		this.sx = this.sy += 0,05000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

