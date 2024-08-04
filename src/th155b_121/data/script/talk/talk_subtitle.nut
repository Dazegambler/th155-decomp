function CreateSubtitle( _text, _name = null )
{
	if (_name)
	{
		local text = ::font.CreateSubtitleString(_text);
		local name = ::font.CreateSubtitleString(_name + ":");
		name.x = (::graphics.width - text.width - name.width) / 2;
		text.x = name.x + name.width;
		name.y = text.y = ::graphics.height - 64 - text.height / 2;
		return [
			name,
			text
		];
	}
	else
	{
		local text = ::font.CreateSubtitleString(_text);
		text.x = (::graphics.width - text.width) / 2;
		text.y = ::graphics.height - 64 - text.height / 2;
		return [
			text
		];
	}
}

