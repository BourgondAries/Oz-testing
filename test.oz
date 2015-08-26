functor
import
	Application
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
		{System.showInfo {Fact 1012}}
	end
	{Application.exit 0}
end
