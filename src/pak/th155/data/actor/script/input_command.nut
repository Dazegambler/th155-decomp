class this.InputCommand 
{
	device = null;
	reserve_count = 0;
	rsv_x = 0;
	rsv_y = 0;
	rsv_k0 = 0;
	rsv_k1 = 0;
	rsv_k2 = 0;
	rsv_k3 = 0;
	rsv_k3_r = 0;
	rsv_k4 = 0;
	rsv_k5 = 0;
	rsv_k01 = 0;
	rsv_k12 = 0;
	rsv_k23 = 0;
	ban_slide = 0;
	com = null;
	constructor( _device )
	{
		this.com = ::manbow.InputCommand();
		this.com.SetDevice(_device);
		this.device = _device;
	}

	function Clear()
	{
		this.com.Clear();
	}

	function ResetReserve()
	{
		this.reserve_count = 0;
		this.rsv_x = 0;
		this.rsv_y = 0;
		this.rsv_k0 = 0;
		this.rsv_k1 = 0;
		this.rsv_k2 = 0;
		this.rsv_k3 = 0;
		this.rsv_k3_r = 0;
		this.rsv_k4 = 0;
		this.rsv_k5 = 0;
		this.rsv_k01 = 0;
		this.rsv_k12 = 0;
		this.rsv_k23 = 0;
	}

	function ResetAllReserve()
	{
		this.reserve_count = 0;
		this.rsv_x = 0;
		this.rsv_y = 0;
		this.rsv_k0 = 0;
		this.rsv_k1 = 0;
		this.rsv_k2 = 0;
		this.rsv_k3 = 0;
		this.rsv_k3_r = 0;
		this.rsv_k4 = 0;
		this.rsv_k5 = 0;
		this.rsv_k01 = 0;
		this.rsv_k12 = 0;
		this.rsv_k23 = 0;
	}

	function Update( direction, keep )
	{
		this.com.Update(direction);
		local inputSet_ = false;

		if (this.device.b4 == 0 || this.device.y <= 0 && this.ban_slide == 1 || this.device.y >= 0 && this.ban_slide == -1)
		{
			this.ban_slide = 0;
		}

		if (this.com.b0 > 0 && this.com.b1 > 0)
		{
			this.rsv_k01 = 5;
			inputSet_ = true;
		}

		if (this.com.b1 > 0 && this.com.b2 > 0)
		{
			this.rsv_k12 = 5;
			inputSet_ = true;
		}

		if (this.com.b2 > 0 && this.com.b3 > 0)
		{
			this.rsv_k23 = 5;
			inputSet_ = true;
		}

		if (this.device.b0 == 2 || this.device.b0 == 0 && this.com.b0 > 0)
		{
			this.rsv_k0 = 5;
			inputSet_ = true;
		}

		if (this.device.b1 == 2 || this.device.b1 == 0 && this.com.b1 > 0)
		{
			this.rsv_k1 = 5;
			inputSet_ = true;
		}

		if (this.device.b2 == 2 || this.device.b2 == 0 && this.com.b2 > 0)
		{
			this.rsv_k2 = 5;
			inputSet_ = true;
		}

		if (this.device.b3r > 0)
		{
			this.rsv_k3_r = 10;
		}

		if (this.device.b3 == 2 || this.device.b3 == 0 && this.com.b3 > 0)
		{
			this.rsv_k3 = 7;
			inputSet_ = true;
		}

		if (inputSet_)
		{
			this.reserve_count = 5;
			this.rsv_x = this.device.x;
			this.rsv_y = this.device.y;
		}
		else if (this.reserve_count == 1)
		{
			this.ResetReserve();
		}

		if (keep)
		{
			if (this.rsv_k0 > 0)
			{
				this.rsv_k0--;
			}

			if (this.rsv_k1 > 0)
			{
				this.rsv_k1--;
			}

			if (this.rsv_k2 > 0)
			{
				this.rsv_k2--;
			}

			if (this.rsv_k3 > 0)
			{
				this.rsv_k3--;
			}

			if (this.rsv_k3_r > 0)
			{
				this.rsv_k3_r--;
			}

			if (this.rsv_k4 > 0)
			{
				this.rsv_k4--;
			}

			if (this.rsv_k5 > 0)
			{
				this.rsv_k5--;
			}

			if (this.rsv_k01 > 0)
			{
				this.rsv_k01--;
			}

			if (this.rsv_k12 > 0)
			{
				this.rsv_k12--;
			}

			if (this.rsv_k23 > 0)
			{
				this.rsv_k23--;
			}
		}
	}

	function Check( handle )
	{
		return this.com.Check(handle);
	}

}

this.N6N6 <- ::manbow.InputCommand.Register("N6N6", 15);
this.N4N4 <- ::manbow.InputCommand.Register("N4N4", 15);
this.N6N6A <- ::manbow.InputCommand.Register("N6N6A", 25);
this.N6N6B <- ::manbow.InputCommand.Register("N6N6B", 25);
this.BB <- ::manbow.InputCommand.Register("BBB", 20);
this.DD <- ::manbow.InputCommand.Register("DD", 15);
this.EE <- ::manbow.InputCommand.Register("EE", 15);
