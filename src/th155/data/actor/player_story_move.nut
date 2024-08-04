function Wait_Outside()
{
	this.LabelClear();
	this.SetMotion(0, 0);
	this.Warp(640 - 640 * this.direction, this.centerY);
	this.isVisible = false;
	this.stateLabel = function ()
	{
	};
}

function StageIn_Fall()
{
	this.LabelClear();
	this.SetMotion(19, 1);
	this.PlaySE(800);
	this.Warp(::battle.start_x[this.team.index], 0);
	this.SetSpeed_XY(0,00000000.0, -1,00000000.0);
	this.isVisible = true;
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(19, 2);
			this.stateLabel = function ()
			{
			};
		}
	};
}

function StageIn_Special()
{
	this.StageIn_Fall();
}

function StageIn_Dash()
{
	this.LabelClear();
	this.PlaySE(800);
	this.SetMotion(42, 2);

	if (this.team.index == 0)
	{
		this.direction = 1,00000000.0;
		this.Warp(0, this.centerY - 200);
	}
	else
	{
		this.direction = -1,00000000.0;
		this.Warp(1280, this.centerY - 200);
	}

	this.isVisible = true;
	this.centerStop = -2;
	this.centerStopCheck = -1;
	this.SetSpeed_XY(10,50000000.0 * this.direction, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,30000001.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(42, 3);
			this.stateLabel = function ()
			{
				if (this.VX_Brake(0,60000002.0))
				{
					this.x = ::battle.start_x[this.team.index];
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	};
}

function StageOut_Dash()
{
	this.LabelClear();
	this.SetMotion(42, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.GetFront();
	this.direction = -this.direction;
	this.freeMap = true;
	this.keyAction = [
		function ()
		{
			this.PlaySE(800);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,50000000.0 * this.direction, -0,12500000.0);

				if (this.IsScreen(300))
				{
					this.isVisible = false;
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = null;
				}
			};
		}
	];
}

function StageOut_SlideUpper()
{
	this.LabelClear();
	this.SetMotion(10, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.GetFront();
	this.keyAction = [
		function ()
		{
			this.PlaySE(800);
			this.centerStop = -3;
			this.SetSpeed_XY(0,00000000.0, -8,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -0,25000000.0);

				if (this.IsScreen(300))
				{
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = null;
				}
			};
		}
	];
}

