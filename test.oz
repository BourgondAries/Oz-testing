functor
import
	Application
	Browser
	System
define
	{System.showInfo 'Hi'}
	local I F C in
		I = 5
		F = 5.5
		C = &t
		{System.showInfo C + I}
	end
	fun {Fact N}
		if N =< 0 then 1 else N*{Fact N-1} end
	end
	local X Y B in
		X = 32
		{NewName Y}
		B = true
		{System.showInfo X}
		{System.showInfo {Fact 12}}
	end
	{System.showInfo'Here we just have running code it seems'}

	local X Y Z in
		Y = 2
		Z = 3
		X = Y * Z
		{System.showInfo X}
	end

	local X Y in
		X = 'this is magic'
		Y = X
		{System.showInfo Y}
	end



	local X in
		X = {Fact 32}
		{System.showInfo X}
	end





	{Application.exit 0}
end
