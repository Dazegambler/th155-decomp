function GetVersion()
{
	return 1551000;
}

function GetReplayVersion()
{
	return 1551000;
}

this.current_version <- ::manbow.GetPrivateProfileString("updater", "version", "0", "config.ini").tointeger();
function GetUpdaterVersion()
{
	return this.current_version;
}

function GetVersionString()
{
	return "Ver1.00";
}

function GetVersionSignature()
{
	return "1_00";
}

::SetWindowText("“Œ•ûœ\x2580ˆ\x2566‰Ø@` Antinomy of Common Flowers. " + this.GetVersionString());
