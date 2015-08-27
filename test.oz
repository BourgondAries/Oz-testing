functor
import
	Application
	Browser
	List
	System
define
	fun {Factorial Number}
		if Number == 0 then 1
		else Number * {Factorial Number - 1} end
	end

	proc {PrintLines NumberOfLines}
		if NumberOfLines == 0 then skip
		else
			{System.showInfo 'woot'}
			{PrintLines NumberOfLines - 1}
		end
	end

	%% Declare an anonymous procedure
	Max = proc {$ X Y Z}
		if X >= Y then Z = X
		else Z = Y end
	end

	local A in
		{Max 1 2 A}
		{System.showInfo A}
	end

	proc {Do A}
		case A of 3 then {System.showInfo 'three'}
		[] 2 then {System.showInfo 'two'}
		[] 1 then {System.showInfo 'one'}
		else {System.showInfo 'none'} end
	end

	{Do 4}
	{Do 2}

	fun {Generate N}
		case N of 0 then nil
		else N|{Generate N-1}
		end
	end

	fun {Sumi L A}
		case L of nil then A
		[] X|Xs then {Sumi Xs A+X}
		end
	end

	{System.showInfo {Sumi {Generate 121389} 0}}
	{ForAll {Generate 120} proc {$ Item} {System.showInfo Item} end}

	%% Let's create a small URL parser
	{ForAll "Damn son where'd you find this" proc {$ C} {System.showInfo C} end}

	local
		R = record(x: hello)
		fun {GetX record(x:X ...)} X end
	in
		{System.showInfo {GetX R}}
	end

	local X = [f a b c d] in
		{System.showInfo {Nth {Reverse X} 2}}
		{System.showInfo X.2.2.1}
		{System.showInfo {Nth {Append X X} 6}}
		{System.showInfo {Nth {Sort X fun {$ X Y} X < Y end} 1}}
	end

	local
		fun {Find X C O}
			case X of Xi|Xs then
				if Xi == C then O
				else {Find Xs C O+1} end
			else O end
		end
	in
		{System.showInfo {Find "Hey:Ho" &: 0}}
	end

	local X in
		{NewName X}
	end


	%% {For 1 20 1 proc {$ I} {System.showInfo I} end}

	%% thread {PrintLines 10} end
	%% thread {System.showInfo {Factorial 100}} end

	%% {Application.exit 0}
end
