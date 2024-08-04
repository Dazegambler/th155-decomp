function CreateSystemInputDevice( device_id )
{
	local device;
	local devmap = ::manbow.DeviceMapping();

	if (device_id == -1)
	{
		device = ::manbow.InputMulti();
		devmap.device = -1;
		devmap.up = 200;
		devmap.down = 208;
		devmap.left = 203;
		devmap.right = 205;
		devmap.b0 = 44;
		devmap.b1 = 45;
		devmap.b2 = 46;
		devmap.b3 = 30;
		devmap.b4 = 31;
		devmap.b5 = 32;
		local device_tmp_local0 = ::manbow.InputSingle();
		device_tmp_local0.SetDeviceAssign(devmap);
		devmap.b0 = 28;
		devmap.b1 = 1;
		local device_tmp_local1 = ::manbow.InputSingle();
		device_tmp_local1.SetDeviceAssign(devmap);
		device.Append(device_tmp_local0);
		device.Append(device_tmp_local1);
	}
	else if (device_id >= 0)
	{
		device = ::manbow.InputMulti();
		devmap.device = device_id;
		devmap.up = 516;
		devmap.down = 513;
		devmap.left = 515;
		devmap.right = 512;
		devmap.analog_x = 256;
		devmap.analog_y = 257;
		devmap.rotate_x = 259;
		devmap.rotate_y = 260;
		devmap.b0 = 0;
		devmap.b1 = 1;
		devmap.b2 = 2;
		devmap.b3 = 3;
		devmap.b4 = 4;
		devmap.b5 = 5;
		devmap.b6 = -1;
		devmap.b7 = -1;
		devmap.b8 = -1;
		devmap.b9 = -1;
		devmap.b10 = -1;
		devmap.b11 = -1;
		local device_tmp_local0 = ::manbow.InputSingle();
		device_tmp_local0.SetDeviceAssign(devmap);
		devmap.up = 524;
		devmap.down = 526;
		devmap.left = 527;
		devmap.right = 525;
		local device_tmp_local1 = ::manbow.InputSingle();
		device_tmp_local1.SetDeviceAssign(devmap);
		device.Append(device_tmp_local0);
		device.Append(device_tmp_local1);
	}
	else
	{
	}

	return device;
}

function CreatePlayerInputDevice( index, device_id )
{
	if (::network.IsActive())
	{
		return ::network.inst.device[index];
	}

	return this.CreatePlayerInputDeviceLocal(index, device_id);
}

function CreatePlayerInputDeviceLocal( index, device_id )
{
	local device = ::manbow.InputSingle();
	this.SetDeviceAssign(index, device_id, device);
	return device;
}

function CreatePlayerInputDevicePractice2P( device_id_1p )
{
	local device = ::manbow.InputMulti();
	local d = ::manbow.InputSingle();
	this.SetDeviceAssign(1, -1, d);
	device.Append(d);

	for( local i = 0; i < ::manbow.GetJoyNum(); i = ++i )
	{
		if (i == device_id_1p)
		{
		}
		else
		{
			local d = ::manbow.InputSingle();
			this.SetDeviceAssign(1, i, d);
			device.Append(d);
		}
	}

	return device;
}

function SetDeviceAssign( index, device_id, target_device )
{
	if (target_device == null)
	{
		return;
	}

	local devmap = ::manbow.DeviceMapping();

	if (device_id == -1)
	{
		devmap.device = -1;

		foreach( key, val in ::config.input.key[index] )
		{
			devmap[key] = val;
		}
	}
	else if (device_id >= 0)
	{
		devmap.device = device_id;

		foreach( key, val in ::config.input.pad[index] )
		{
			devmap[key] = val;
		}
	}
	else
	{
		devmap.device = -2;
	}

	target_device.SetDeviceAssign(devmap);
}

function SetDeviceAssignPractice2P( device_id_1p, target_device )
{
	target_device.Release();
	local d = ::manbow.InputSingle();
	this.SetDeviceAssign(1, -1, d);
	target_device.Append(d);

	for( local i = 0; i < ::manbow.GetJoyNum(); i = ++i )
	{
		if (i == device_id_1p)
		{
		}
		else
		{
			local d = ::manbow.InputSingle();
			this.SetDeviceAssign(1, i, d);
			target_device.Append(d);
		}
	}

	target_device.Lock();
}

::input_key <- this.CreateSystemInputDevice(-1);
::input_joy <- [];
::input_joy_all <- ::manbow.InputMulti();

for( local i = 0; i < ::manbow.GetJoyNum(); i++ )
{
	local device = this.CreateSystemInputDevice(i);
	::input_joy.push(device);
	::input_joy_all.Append(device);
}

::input_all <- ::manbow.InputMulti();
this.input_all.Append(::input_key);
this.input_all.Append(::input_joy_all);
::input_function <- ::manbow.InputSingle();
local devmap = ::manbow.DeviceMapping();
devmap.device = -1;
devmap.up = 54;
devmap.down = 42;
devmap.left = -1;
devmap.right = -1;
devmap.b0 = 59;
devmap.b1 = 60;
devmap.b2 = 61;
devmap.b3 = 62;
devmap.b4 = 63;
devmap.b5 = 64;
devmap.b6 = 65;
devmap.b7 = 66;
devmap.b8 = 67;
devmap.b9 = 68;
devmap.b10 = 87;
devmap.b11 = 88;
::input_function.SetDeviceAssign(devmap);
::input_talk <- ::manbow.InputMulti();

for( local i = -1; i < ::manbow.GetJoyNum(); i = ++i )
{
	devmap.device = i;

	if (i >= 0)
	{
		devmap.b0 = 0;
		devmap.b1 = 1;
		devmap.b2 = 2;
	}
	else
	{
		devmap.b0 = 44;
		devmap.b1 = 45;
		devmap.b2 = 46;
	}

	local input_device_local = ::manbow.InputSingle();
	input_device_local.SetDeviceAssign(devmap);
	::input_talk.Append(input_device_local);
}

local task = {};
task.Update <- function ()
{
	if (::manbow.GetJoyNum() > ::input_joy.len())
	{
		local device = ::input.CreateSystemInputDevice(::input_joy.len());
		::input_joy.push(device);
		::input_joy_all.Append(device);
	}
};
::loop.AddTask(task);
