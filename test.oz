functor
import
	Application
	Browser
	System
define
	/* Utility function to print lists vim > emacs */
	fun {ListToString Ls}
		case Ls of L1|L2 then
			{IntToString L1} # "|" # {ListToString L2}
		else
			"nil"
		end
	end

	/********************/
	fun {Generate N Limit}
		if N < Limit then
			N|{Generate N+1 Limit}
		else nil end
	end

	fun {Sum Xs A}
		case Xs of X1|X2 then
			{Sum X2 A+X1}
		[] nil then
			A
		end
	end
	/********************/

	/* Task 2 */
	fun {StreamMap S F}
		case S of S1|S0 then
			{F S1}|{StreamMap S0 F}
		else
			nil
		end
	end

	local X A in
		thread X = {Generate 0 1500} end
		thread A = {StreamMap X fun {$ Num} Num * 2 end} end
		{System.showInfo {ListToString A}}
	end
	/********************/

	/* Task 3 */
	/* Assuming the sizes of the streams are equal */
	fun {StreamZip S1 S2 F}
		case S1 of S1_1|S1_2 then
			case S2 of S2_1|S2_2 then
				{F S1_1  S2_1}|{StreamZip S1_2 S2_2 F}
			else
				nil
			end
		else
			nil
		end
	end

	B = {StreamZip [1 2 3] [4 5 6] fun {$ L R} L * R end}
	{System.showInfo {ListToString B}}
	/********************/

	/* Task 4 */
	fun {StreamScale SF Factor}
		{StreamMap SF fun {$ Elem} Elem * Factor end}
	end

	C = {StreamScale [1 2 3 6] 2}
	{System.showInfo {ListToString C}}
	/********************/

	/* Task 5 */
	fun {StreamAdd SF1 SF2}
		{StreamZip SF1 SF2 fun {$ A B} A + B end}
	end

	/* Task 6 */
	fun {StreamAccum List Prev}
		case List of L1|L2 then
			local A = Prev+L1 in
				A|{StreamAccum L2 A}
			end
		else
			nil
		end
	end

	fun {StreamIntegrate SF InitValue Dt}
		local A B in
			thread A = {StreamScale SF Dt} end
			thread B = {StreamAccum A InitValue} end
			InitValue|B
		end
	end

	D = {StreamIntegrate [1 0 1] 5 1}
	{System.showInfo {ListToString D}}
	E = {StreamIntegrate [5 6 7] 2 3}
	{System.showInfo {ListToString E}}

	{Application.exit 0}
end
