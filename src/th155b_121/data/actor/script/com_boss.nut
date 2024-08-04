function CPU_SetLevel( diff_ )
{
	switch(diff_)
	{
	case 0:
		this.com_level = 0;
		this.com_baria_rate = 0;
		this.com_guard_rate = 0;
		break;

	case 1:
		this.com_level = 33;
		this.com_baria_rate = 0;
		this.com_guard_rate = 0;
		break;

	case 2:
		this.com_level = 66;
		this.com_baria_rate = 0;
		this.com_guard_rate = 0;
		break;

	case 3:
		this.com_level = 100;
		this.com_baria_rate = 0;
		this.com_guard_rate = 0;
		break;

	case 4:
		this.com_level = 100;
		this.com_baria_rate = 0;
		this.com_guard_rate = 0;
		break;
	}
}

